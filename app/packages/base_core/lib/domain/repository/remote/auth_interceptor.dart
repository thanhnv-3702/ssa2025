import 'dart:async';
import 'dart:ui';

import 'package:base_core/common/base_const.dart';
import 'package:dio/dio.dart';

import '../../../common/config.dart';
import '../../../storage/storage.dart';

class TokenRefreshResponse {
  final String? accessToken;
  final String? refreshToken;

  TokenRefreshResponse({
    this.accessToken,
    this.refreshToken,
  });
}

class AuthInterceptor extends Interceptor {
  final StorageService _storageService;
  final Future<TokenRefreshResponse> Function(String refreshToken) _refreshTokenCallback;
  final VoidCallback? _onRefreshFailure;

  bool _isRefreshing = false;
  final List<_PendingRequest> _pendingRequests = [];

  AuthInterceptor({
    required StorageService storageService,
    required Future<TokenRefreshResponse> Function(String refreshToken) refreshTokenCallback,
    VoidCallback? onRefreshFailure,
  })  : _storageService = storageService,
        _refreshTokenCallback = refreshTokenCallback,
        _onRefreshFailure = onRefreshFailure;

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.requestOptions.extra['skipAuthInterceptor'] == true) {
      handler.reject(err);
      return;
    }

    if (err.response?.statusCode == 401 && !BaseConst.excludedAPIs.any((v) => err.requestOptions.path.contains(v))) {
      final requestOptions = err.requestOptions;
      if (_isRefreshEndpoint(requestOptions.path)) {
        _onRefreshFailure?.call();
        handler.reject(err);
        return;
      }

      try {
        final response = await _handleTokenRefresh(requestOptions);
        if (response != null) {
          handler.resolve(response);
        } else {
          handler.reject(err);
        }
      } catch (e) {
        handler.reject(err);
      }
    } else {
      handler.reject(err);
    }
  }

  bool _isRefreshEndpoint(String path) {
    return path.contains(BaseConst.apiRefreshToken);
  }

  Future<Response?> _handleTokenRefresh(RequestOptions requestOptions) async {
    if (_isRefreshing) {
      final completer = Completer<Response?>();
      _pendingRequests.add(_PendingRequest(requestOptions, completer));
      return completer.future;
    }

    _isRefreshing = true;

    try {
      final refreshToken = _storageService.getPrivateToken();
      if (refreshToken.isEmpty || refreshToken == 'N/A') {
        _onRefreshFailure?.call();
        _isRefreshing = false;
        _rejectPendingRequests();
        return null;
      }

      final tokenResponse = await _refreshTokenCallback(refreshToken);

      if (tokenResponse.accessToken != null) {
        await _storageService.setToken(userToken: tokenResponse.accessToken!);
      }
      if (tokenResponse.refreshToken != null) {
        await _storageService.setPrivateToken(privateToken: tokenResponse.refreshToken!);
      }

      final retryResponse = await _retryRequest(requestOptions, tokenResponse.accessToken);
      _isRefreshing = false;
      return retryResponse;
    } catch (e) {
      _isRefreshing = false;
      _rejectPendingRequests();
      _onRefreshFailure?.call();
      return null;
    }
  }

  static dynamic _cloneData(dynamic data) {
    if (data == null) return null;
    if (data is Map) return Map<String, dynamic>.from(data);
    if (data is List) return List<dynamic>.from(data);
    if (data is String) return data;
    return data;
  }

  Future<Response> _retryRequest(RequestOptions requestOptions, String? newAccessToken) async {
    final updatedHeaders = Map<String, dynamic>.from(requestOptions.headers);
    updatedHeaders['inno-auth'] = 'Bearer $newAccessToken';
    final retryData = _cloneData(requestOptions.data);
    final options = requestOptions.copyWith(
      headers: updatedHeaders,
      data: retryData,
    );

    final dio = Dio(
      BaseOptions(
        baseUrl: requestOptions.baseUrl,
        receiveDataWhenStatusError: true,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
      ),
    );
    dio.interceptors.clear();
    dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        requestHeader: true,
        responseBody: true,
        responseHeader: true,
        logPrint: (ob) {
          logger.d('DIO REST LOG: $ob');
        },
      ),
    );

    try {
      final response = await dio.fetch<String>(options);
      if (response.statusCode == 401) {
        _onRefreshFailure?.call();
        throw DioException(
          requestOptions: requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
        );
      }
      return response;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        _onRefreshFailure?.call();
      }
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  void _rejectPendingRequests() {
    final pending = List<_PendingRequest>.from(_pendingRequests);
    _pendingRequests.clear();

    for (final pendingRequest in pending) {
      if (!pendingRequest.completer.isCompleted) {
        pendingRequest.completer.complete(null);
      }
    }
  }
}

class _PendingRequest {
  final RequestOptions requestOptions;
  final Completer<Response?> completer;

  _PendingRequest(this.requestOptions, this.completer);
}
