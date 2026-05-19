import 'dart:convert';

import 'package:dio/dio.dart';

/// Interceptor that adds HTTP Basic Auth header when username and password are provided.
/// Used for gateway (no OpenVPN) API access. Preserved when [API] clears and re-adds interceptors.
class BasicAuthInterceptor extends Interceptor {
  final String? _username;
  final String? _password;

  BasicAuthInterceptor({
    String? username,
    String? password,
  })  : _username = username?.trim(),
        _password = password?.trim();

  bool get _isActive => _username != null && _username!.isNotEmpty && _password != null && _password!.isNotEmpty;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    if (_isActive) {
      final credentials = base64Encode(
        utf8.encode('$_username:$_password'),
      );
      options.headers['Authorization'] = 'Basic $credentials';
    }
    handler.next(options);
  }
}
