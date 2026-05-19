import 'dart:convert';
import 'dart:typed_data';

import 'package:base_core/common/base_const.dart';
import 'package:base_core/common/config.dart';
import 'package:base_core/common/data_exception.dart';
import 'package:dio/dio.dart';

import '../repository/remote/auth_interceptor.dart';
import '../repository/remote/basic_auth_interceptor.dart';
import '../repository/remote/dio_interceptor.dart';

abstract class API {
  final Dio _dio;
  final String baseUrl;
  final _log = LogInterceptor(
    requestBody: true,
    requestHeader: true,
    responseBody: true,
    responseHeader: true,
    logPrint: (ob) {
      logger.d('DIO REST LOG: $ob');
    },
  );

  API(this._dio, this.baseUrl);

  Future<String> doGet({
    Map<String, dynamic>? query,
    Map<String, dynamic>? body,
    Map<String, dynamic>? header,
    String? baseUrl,
    required String url,
  }) =>
      _doPostGet(
        header: header,
        query: query,
        body: body,
        baseUrl: baseUrl,
        url: url,
        method: MethodType.get,
      );

  /// GET request that returns response body as bytes, filename from Content-Disposition, and content-type header (for downloads).
  Future<
      ({
        Uint8List? bytes,
        String? filename,
        String? title,
        String? contentType
      })> doGetBytesWithFilename({
    Map<String, dynamic>? query,
    Map<String, dynamic>? header,
    String? baseUrl,
    required String url,
  }) =>
      _doGetBytesWithFilename(
        header: header,
        query: query,
        baseUrl: baseUrl,
        url: url,
      );

  /// Parses content-type from response header, e.g. image/png, application/pdf.
  static String? contentTypeFromHeaders(Headers? headers) {
    if (headers == null) return null;
    final value = headers.value('content-type');
    return value?.trim().isNotEmpty == true ? value!.trim() : null;
  }

  /// Parses filename from Content-Disposition header value, e.g. attachment; filename="file.pdf".
  static String? filenameFromContentDisposition(String key, Headers? headers) {
    logger.d('NEON headers = $headers');
    try {
      if (headers == null) return null;
      final value = headers.value('content-disposition');
      if (value == null || value.isEmpty) return null;
      final starTag = '$key="';
      final isNotFound = !value.contains(starTag);
      if (isNotFound) return null;
      final startIndex = value.indexOf(starTag) + starTag.length;
      final endTag = '"';
      final endIndex = value.indexOf(endTag, startIndex);
      final fileName = value.substring(startIndex, endIndex);
      logger.d('NEON $key = $fileName');
      return fileName;
    } catch (_) {
      return null;
    }
  }

  /// Decodes error body from a bytes download response (UTF-8 JSON string).
  static String? _downloadErrorBodyToString(dynamic data) {
    if (data == null) return null;
    if (data is String) return data;
    if (data is Uint8List) {
      return utf8.decode(data);
    }
    if (data is List<int>) {
      return utf8.decode(data);
    }
    return null;
  }

  static Never _throwDataExceptionFromDownloadErrorBody(dynamic data) {
    final bodyStr = _downloadErrorBodyToString(data);
    if (bodyStr == null || bodyStr.trim().isEmpty) {
      throw DataException(BaseConst.systemErrorData);
    }
    try {
      final decoded = json.decode(bodyStr);
      if (decoded is Map<String, dynamic>) {
        throw DataException(decoded);
      }
    } on DataException {
      rethrow;
    } catch (_) {}
    throw DataException(BaseConst.systemErrorData);
  }

  Future<String> doPost({
    Map<String, dynamic>? param,
    Map<String, dynamic>? body,
    Map<String, dynamic>? query,
    Map<String, dynamic>? header,
    String? token,
    String? baseUrl,
    url,
  }) =>
      _doPostGet(
        param: param,
        query: query,
        body: body,
        header: header,
        baseUrl: baseUrl,
        token: token,
        url: url,
        method: MethodType.post,
      );

  Future<String> doPut({
    Map<String, dynamic>? param,
    Map<String, dynamic>? body,
    Map<String, dynamic>? query,
    Map<String, dynamic>? header,
    String? token,
    String? baseUrl,
    url,
  }) =>
      _doPostGet(
        param: param,
        query: query,
        body: body,
        header: header,
        baseUrl: baseUrl,
        token: token,
        url: url,
        method: MethodType.put,
      );

  Future<String> doDelete({
    Map<String, dynamic>? param,
    Map<String, dynamic>? body,
    Map<String, dynamic>? query,
    Map<String, dynamic>? header,
    String? token,
    String? baseUrl,
    url,
  }) =>
      _doPostGet(
        param: param,
        query: query,
        body: body,
        header: header,
        baseUrl: baseUrl,
        token: token,
        url: url,
        method: MethodType.delete,
      );

  void doPostStream(
    Function call, {
    Map<String, dynamic>? param,
    Map<String, dynamic>? body,
    Map<String, dynamic>? query,
    Map<String, dynamic>? header,
    String? token,
    String? baseUrl,
    required String url,
  }) {
    doPostGetStream(
      param: param,
      query: query,
      body: body,
      header: header,
      token: token,
      baseUrl: baseUrl,
      url: url,
      method: MethodType.post,
    ).listen((result) {
      String data =
          (result.data == null || result.data!.isEmpty || result.data == '')
              ? '{}'
              : result.data!;
      data = data.replaceAll('data: ', '');
      call(data);
    });
  }

  Future<String> _doPostGet({
    Map<String, dynamic>? param,
    Map<String, dynamic>? header,
    String? token,
    Map<String, dynamic>? query,
    Map<String, dynamic>? body,
    String? baseUrl,
    required String url,
    required MethodType method,
    isFormData = false,
  }) async {
    baseUrl ??= this.baseUrl;
    // Preserve interceptors that must run on every request (re-added after clear)
    final basicAuth =
        _dio.interceptors.whereType<BasicAuthInterceptor>().toList();
    final authInterceptors =
        _dio.interceptors.whereType<AuthInterceptor>().toList();
    _dio.interceptors.clear();
    _dio.interceptors.add(_log);
    _dio.interceptors.addAll(basicAuth);
    _dio.interceptors.addAll(authInterceptors);
    _dio.interceptors.add(
      DioInterceptor(
        type: ResponseType.plain,
        isFormData: isFormData,
        baseUrl: baseUrl,
        method: method,
        body: body,
        headers: header,
        queries: query,
        params: param,
        token: token,
      ),
    );
    final result = await _dio.fetch<String>(
      Options().compose(_dio.options, url),
    );

    logger.d('[API] doPostGet fetch = $result');
    return (result.data == null || result.data!.isEmpty || result.data == '')
        ? '{}'
        : result.data!;
  }

  Future<
      ({
        Uint8List? bytes,
        String? filename,
        String? title,
        String? contentType
      })> _doGetBytesWithFilename({
    Map<String, dynamic>? header,
    Map<String, dynamic>? query,
    String? baseUrl,
    required String url,
  }) async {
    baseUrl ??= this.baseUrl;
    final basicAuth =
        _dio.interceptors.whereType<BasicAuthInterceptor>().toList();
    final authInterceptors =
        _dio.interceptors.whereType<AuthInterceptor>().toList();
    _dio.interceptors.clear();
    _dio.interceptors.add(_log);
    _dio.interceptors.addAll(basicAuth);
    _dio.interceptors.addAll(authInterceptors);
    _dio.interceptors.add(
      DioInterceptor(
        type: ResponseType.bytes,
        baseUrl: baseUrl,
        method: MethodType.get,
        headers: header,
        queries: query,
        validateStatus: (_) => true,
      ),
    );
    final result = await _dio.fetch<Uint8List>(
      Options().compose(_dio.options, url),
    );
    final status = result.statusCode ?? 0;
    if (status < 200 || status >= 300) {
      API._throwDataExceptionFromDownloadErrorBody(result.data);
    }
    final filename =
        API.filenameFromContentDisposition('filename', result.headers);
    final title = result.headers.value('x-original-name');
    final contentType = API.contentTypeFromHeaders(result.headers);
    return (
      bytes: result.data,
      filename: filename,
      title: title,
      contentType: contentType
    );
  }

  Stream<Response> doPostGetStream({
    Map<String, dynamic>? param,
    Map<String, dynamic>? header,
    String? token,
    Map<String, dynamic>? query,
    dynamic body,
    String? baseUrl,
    required String url,
    required MethodType method,
    isFormData = false,
  }) {
    baseUrl ??= this.baseUrl;
    final basicAuth =
        _dio.interceptors.whereType<BasicAuthInterceptor>().toList();
    final authInterceptors =
        _dio.interceptors.whereType<AuthInterceptor>().toList();
    _dio.interceptors.clear();
    _dio.interceptors.add(_log);
    _dio.interceptors.addAll(basicAuth);
    _dio.interceptors.addAll(authInterceptors);
    _dio.interceptors.add(
      DioInterceptor(
        type: ResponseType.plain,
        isFormData: isFormData,
        baseUrl: baseUrl,
        method: method,
        body: body,
        token: token,
        headers: header,
        queries: query,
        params: param,
      ),
    );

    return _dio
        .fetch<String>(
          Options(
            validateStatus: (status) => true,
          ).compose(_dio.options, url),
        )
        .asStream();
  }

  Future<String> doPostFormData({
    Map<String, dynamic>? param,
    Map<String, dynamic>? header,
    Map<String, dynamic>? query,
    required String url,
    required MethodType method,
  }) async {
    return _doPostGet(
      param: param,
      header: header,
      query: query,
      method: method,
      isFormData: true,
      url: url,
    );
  }
}
