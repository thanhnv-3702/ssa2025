import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:stacked/stacked_annotations.dart';

import '../../../common/base_const.dart';
import '../../../storage/storage.dart';

enum MethodType { get, post, put, delete }

MethodType toMethodType(String type) {
  return MethodType.values.firstWhere((v) => v.name == type);
}

class DioInterceptor extends Interceptor {
  bool isFormData;
  String baseUrl;
  MethodType method;
  String? token;
  ResponseType type;
  Map<String, dynamic>? headers;
  Map<String, dynamic>? queries;
  Map<String, dynamic>? params;
  Map<String, dynamic>? body;
  /// When set (e.g. for binary downloads), Dio will not throw on 4xx/5xx so the
  /// caller can parse JSON error bodies that are UTF-8 bytes, not files.
  ValidateStatus? validateStatus;

  DioInterceptor({
    required this.baseUrl,
    required this.type,
    this.isFormData = false,
    this.headers,
    this.queries,
    this.method = MethodType.post,
    this.params,
    this.body,
    this.token,
    this.validateStatus,
  });

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // if (token != null) {
    //   options.headers['Authorization'] = '$token';
    // } else {
    //   final token = StackedLocator.instance<StorageService>().getToken();
    //   if (token != null) {
    //     options.headers['Authorization'] = 'Bearer $token';
    //   }
    // }
    options.method = method.name.toUpperCase();
    options.responseType = type;
    final statusValidator = validateStatus;
    if (statusValidator != null) {
      options.validateStatus = statusValidator;
    }

    if (!isFormData) {
      options.headers[HttpHeaders.contentTypeHeader] = 'application/json';
      options.headers[HttpHeaders.acceptHeader] = 'application/json';
    }

    // Add Accept-Language header from storage
    final storageService = StackedLocator.instance<StorageService>();
    final savedLanguage = storageService.getString(StorageKey.keySelectedLanguage.name);
    final language = savedLanguage != null && savedLanguage.isNotEmpty ? savedLanguage : BaseConst.defaultLangue;
    options.headers['Accept-Language'] = language;

    if (headers != null) {
      options.headers.addAll(headers!);
    }
    if (queries != null) {
      options.queryParameters.addAll(queries!);
    }
    if (params != null) {
      options.queryParameters.addAll(params!);
    }
    if (body != null) {
      options.data = json.encode(body);
    }
    options.baseUrl = baseUrl;
    super.onRequest(options, handler);
  }
}
