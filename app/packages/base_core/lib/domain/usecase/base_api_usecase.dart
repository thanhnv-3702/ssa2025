import 'dart:io';

import 'package:base_core/domain/network/api_impl.dart';

import '../../common/config.dart';
import '../repository/resource.dart';

abstract class BaseAPIUseCase {
  void handleBack(callback, data, {notify, success, error}) {
    logger.d('NEON...sun.- handleBack: $data');
    if (data is ErrorAPI) {
      if (error != null) {
        logger.d('NEON 113 sun.- error: $data');
        error(data);
      } else {
        logger.d('NEON 112 sun.- handleError: $data');
        handleError(callback, data);
      }
    } else {
      if (success != null) {
        success(data);
      } else {
        handleSuccess(callback, data);
      }
    }
  }

  void handleNotify<T>(Function(Resource<T>) callback, Set<String?> msg) {
    callback(Notify(msg));
  }

  void handleError<T>(Function(Resource<T>) callback, T data) {
    final error = data as ErrorAPI;
    logger.d('NEON sun.- error.type: ${error.type}');
    logger.d('NEON sun.- error.data: ${error.data}');
    switch (error.type) {
      case ErrorAPI.typeNetwork:
      case ErrorAPI.typeExpiredToken:
      case ErrorAPI.typeMsg:
      case ErrorAPI.typeMsgEx:
      case ErrorAPI.typeResNull:
      // case ErrorAPI.typeSystem:
        callback(Notify(error.data?.toString()));
        logger.d('sun.- Notify: ${error.data?.toString()}');
        return;
    }
    logger.d('NEON HERE sun.- error.data: ${error.data}');
    callback(Failed(error.data, error.type, key: error.key));
  }

  void handleSuccess<T>(Function(Resource<T>) callback, dynamic data) {
    final success = data as SuccessAPI;
    callback(Success<T>(success.data));
  }

  void execAPI<T>(
    Function(Resource<T>) callback,
    Function() exec, {
    Function()? loading,
    Function(HttpException)? fail,
    Function(Object)? exception,
  }) {
    try {
      if (loading != null) {
        loading();
      } else {
        callback(Loading());
      }
      exec();
    } on RedirectException catch (e) {
      if (fail != null) {
        fail.call(e);
      } else {
        callback(Failed(e, e.redirects[0].statusCode, key: 'RedirectException'));
      }
    } catch (e) {
      if (exception != null) {
        exception(e);
      } else {
        callback(Exception(e));
      }
    }
  }

  APIImpl apiCall<T>(Function(T) callBack, Function(T) onData) {
    return APIImpl(
      (data) {
        handleBack(
          callBack,
          data,
          success: (dataSuccess) {
            final rs = dataSuccess as SuccessAPI;
            T dto = rs.data as T;
            onData(dto);
          },
        );
      },
    );
  }
}
