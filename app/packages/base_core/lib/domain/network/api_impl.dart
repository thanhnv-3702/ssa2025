import 'dart:async';
import 'dart:ui';

import 'package:base_core/domain/network/connectivity_checker.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../common/config.dart';

class APIImpl {
  static const tag = 'APIImpl';
  final apiFetcher = StreamController<Object>();
  static const String keyCommon = 'KEY_COMMON';

  Stream<dynamic> get apiStream => apiFetcher.stream;

  APIImpl(Function(dynamic) handle) {
    apiStream.listen((event) {
      handle(event);
      _dispose();
    });
  }

  void execApiCommon(Function() exe, {VoidCallback? refreshToken}) async {
    execApiTask(exe: exe, key: keyCommon);
  }

  void execApiTask({required Function() exe, required String key}) async {
    logger.d('NEON execApiTask start - key: $key');
    if (!await GetIt.instance<ConnectivityChecker>().hasInternet()) {
      logger.d('NEON execApiTask no internet');
      apiFetcher.sink.add(ErrorAPI(type: ErrorAPI.typeNetwork, data: ErrorAPI.netWorkError, key: key));
    } else {
      logger.d('NEON execApiTask has internet, setting up Future chain');
      try {
        final rs = await exe.call();
        handleSuccess(key, rs);
      } catch (e) {
        logger.e('NEON execApiTask error in handleErrorAPI - key: $key, error: ${e.toString()}');
        handleErrorAPI(e, key);
      }
    }
  }

  void handleSuccess(String key, Object it) {
    logger.d('[$tag]  - Object : $it');
    apiFetcher.sink.add(SuccessAPI(key: key, data: it));
  }

  void handleErrorAPI(Object obj, String key) {
    if (obj is DioException) {
      commonErrorAPI(obj, key);
    } else {
      logger.e('[$tag] - Something when wrong! no Dio, $obj');
      apiFetcher.sink.add(ErrorAPI(type: ErrorAPI.typeSystem, data: obj, key: key));
    }
  }

  void commonErrorAPI(DioException error, String key) async {
    final res = error.response;
    if (res == null) {
      logger.e(ErrorAPI.systemError);
      logger.e(error.toString());
      apiFetcher.sink.add(ErrorAPI(type: ErrorAPI.typeResNull, data: ErrorAPI.systemError, key: key));
      return;
    }
    if (res.data == null) {
      logger.e('[$tag] - commonErrorAPI: ${ErrorAPI.systemError + res.toString()}');
      apiFetcher.sink.add(ErrorAPI(type: ErrorAPI.typeDataErrNull, data: res, key: key));
      return;
    }

    logger.e('[$tag] - commonErrorAPI-code: ${error.response?.statusCode}');
    logger.e('[$tag] - commonErrorAPI-key: $key');

    try {
      apiFetcher.sink.add(ErrorAPI(type: ErrorAPI.typeMsg, data: res.data, key: key));
    } on Exception catch (f) {
      logger.e('[$tag] - commonErrorAPI: Exception: ${ErrorAPI.systemError} parse msg fail, $res');
      apiFetcher.sink.add(ErrorAPI(type: ErrorAPI.typeMsgEx, data: f.toString(), key: key));
    }
  }

  void _dispose() {
    apiFetcher.close();
  }

  void execApiMockTask(String key, {bool isSuccess = true, required Object data}) async {
    if (!await GetIt.instance<ConnectivityChecker>().hasInternet()) {
      apiFetcher.sink.add(ErrorAPI(type: ErrorAPI.typeNetwork, data: ErrorAPI.netWorkError, key: key));
    } else {
      if (isSuccess) {
        handleSuccess(key, data);
      } else {
        handleErrorAPI(data, key);
      }
    }
  }
}

class SuccessAPI<T> {
  final String key;
  T? data;

  SuccessAPI({required this.key, this.data});
}

class ErrorAPI {
  static const systemError = 'Something when wrong! null error';
  static const netWorkError = 'System error, try again later';
  static const tokenExpired = 'Token is expired';

  static const int typeSystem = 999;
  static const int typeResNull = 997;
  static const int typeDataErrNull = 996;
  static const int typeMsg = 995;
  static const int typeMsgEx = 994;
  static const int typeNetwork = 993;
  static const int typeExpiredToken = 992;
  final String key;
  final int type;
  Object? data;

  ErrorAPI({required this.type, this.data, required this.key});

  @override
  String toString() {
    return 'ERROR:\nkey = $key\type=$type\ndata=$data';
  }
}
