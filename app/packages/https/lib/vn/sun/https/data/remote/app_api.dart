import 'dart:convert';
import 'dart:typed_data';

import 'package:base_core/common/base_const.dart';
import 'package:base_core/common/config.dart';
import 'package:base_core/common/data_exception.dart';
import 'package:base_core/domain/network/api.dart';
import 'package:base_core/domain/repository/remote/dio_interceptor.dart';
import 'package:base_core/storage/storage.dart';
import 'package:dio/dio.dart';
import 'package:https/vn/sun/https/data/dto/account_dto.dart';
import 'package:https/vn/sun/https/data/dto/msg_dto.dart';
import 'package:https/vn/sun/https/data/remote/api_http_exception.dart';
import 'package:stacked/stacked_annotations.dart';

class AppAPI extends API {
  AppAPI(Dio dio, String baseUrl) : super(dio, baseUrl);

  /// Helper method to call POST API and handle errors
  Future<Map<String, dynamic>> _callAPI({
    bool isAuth = false,
    Map<String, dynamic>? body,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? query,
    required String url,
    MethodType methodType = MethodType.post,
  }) async {
    try {
      Map<String, dynamic>? header;
      if (isAuth) {
        final storageService = StackedLocator.instance<StorageService>();
        final accessToken = storageService.getToken();
        header = {'inno-auth': 'Bearer $accessToken'};
        logger.d(
          'NEON accessToken = $accessToken',
        );
      }
      if (headers != null) {
        if (header == null) {
          header = {};
        }
        header.addAll(headers);
      }

      logger.d(
        'NEON body = ${json.encode(body)}',
      );
      var txt = switch (methodType) {
        MethodType.post => await doPost(url: url, body: body, header: header, query: query),
        MethodType.get => await doGet(url: url, body: body, header: header, query: query),
        MethodType.put => await doPut(url: url, body: body, header: header, query: query),
        MethodType.delete => await doDelete(url: url, body: body, header: header, query: query)
      };
      final response = json.decode(txt);
      logger.d(
        'NEON _callAPI = $response',
      );
      return response as Map<String, dynamic>;
    } on DioException catch (e) {
      logger.d(
        'NEON ERROR = $e, url = $url',
      );
      throw _commonErrorHandling(e);
    }
  }

  Future<AccountDto> refreshToken({required String refreshToken}) async {
    logger.d(
      'NEON refresh_token = $refreshToken',
    );
    final response = await _callAPI(
      body: {'refresh_token': refreshToken},
      url: '/apis/default/api/refresh-token',
    );
    return AccountDto.fromJson(response);
  }

  Future<AccountDto> login({
    required Map<String, dynamic> body,
  }) async {
    final response = await _callAPI(
      body: body,
      url: '/apis/default/api/login',
    );
    return AccountDto.fromJson(response);
  }

  Future<MsgDto> logout({
    required Map<String, dynamic> body,
  }) async {
    final response = await _callAPI(
      body: body,
      isAuth: true,
      url: '/apis/default/api/logout',
    );
    return MsgDto.fromJson(response);
  }

  /// SAA Kudos hub — stats, highlights, spotlight.
  Future<Map<String, dynamic>> getKudosHub({
    Map<String, dynamic>? query,
  }) async {
    return _callAPI(
      url: '/apis/default/api/kudos/hub',
      methodType: MethodType.get,
      isAuth: true,
      query: query,
    );
  }

  /// SAA awards list for Awards tab.
  Future<Map<String, dynamic>> getAwards() async {
    return _callAPI(
      url: '/apis/default/api/awards',
      methodType: MethodType.get,
      isAuth: true,
    );
  }

  /// Submit a new Kudo.
  Future<Map<String, dynamic>> postKudo({required Map<String, dynamic> body}) async {
    return _callAPI(
      url: '/apis/default/api/kudos',
      methodType: MethodType.post,
      isAuth: true,
      body: body,
    );
  }

  /// Sunner profile by id (or `me` for current user).
  Future<Map<String, dynamic>> getSunnerProfile({required String sunnerId}) async {
    return _callAPI(
      url: '/apis/default/api/sunner/profile',
      methodType: MethodType.get,
      isAuth: true,
      query: {'sunner_id': sunnerId},
    );
  }

  /// Kudos received/sent for a Sunner.
  Future<Map<String, dynamic>> getSunnerKudos({required String sunnerId}) async {
    return _callAPI(
      url: '/apis/default/api/sunner/kudos',
      methodType: MethodType.get,
      isAuth: true,
      query: {'sunner_id': sunnerId},
    );
  }

  /// In-app notifications list.
  Future<Map<String, dynamic>> getNotifications() async {
    return _callAPI(
      url: '/apis/default/api/notifications',
      methodType: MethodType.get,
      isAuth: true,
    );
  }

  /// Search Sunners by name / department / employee code.
  Future<Map<String, dynamic>> searchSunners({
    required String query,
    int? limit,
  }) async {
    return _callAPI(
      url: '/apis/default/api/sunner/search',
      methodType: MethodType.get,
      isAuth: true,
      query: {
        'q': query,
        if (limit != null) 'limit': limit,
      },
    );
  }

  Exception _commonErrorHandling(DioException e) {
    final status = e.response?.statusCode;
    if (status != null && status >= 400) {
      dynamic body = e.response?.data;
      if (body is Uint8List || body is List<int>) {
        try {
          body = json.decode(utf8.decode(body is Uint8List ? body : Uint8List.fromList(body)));
        } catch (_) {}
      }
      return ApiHttpException(
        statusCode: status,
        body: body,
        message: e.message,
      );
    }

    if (e.response != null && e.response!.data != null) {
      try {
        String responseBody = '';
        logger.d(('NEON e.response!.code = ${e.response!.statusCode}'));
        logger.d(('NEON e.response!.data = ${e.response!.data}'));
        final raw = e.response!.data;
        if (raw is String) {
          responseBody = raw;
        } else if (raw is Uint8List || raw is List<int>) {
          responseBody = utf8.decode(
            raw is Uint8List ? raw : Uint8List.fromList(raw as List<int>),
          );
        } else if (raw is Map) {
          responseBody = json.encode(raw);
        } else {
          responseBody = json.encode(raw);
        }

        if (responseBody.isNotEmpty) {
          final responseData = json.decode(responseBody);
          if (responseData is Map<String, dynamic>) {
            return DataException(responseData);
          }
        }
      } catch (parseError) {
        logger.e(
          'Failed to parse error response: $parseError',
        );
        return DataException(BaseConst.systemErrorData);
      }
    }
    return DataException(BaseConst.systemErrorData);
  }
}
