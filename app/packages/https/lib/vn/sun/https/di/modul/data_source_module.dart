import 'dart:async';

import 'package:base_core/common/const_strings.dart';
import 'package:base_core/common/event_bus.dart';
import 'package:base_core/domain/network/api_impl.dart';
import 'package:base_core/domain/repository/remote/auth_interceptor.dart';
import 'package:base_core/domain/repository/remote/base_source_module.dart';
import 'package:base_core/domain/repository/remote/basic_auth_interceptor.dart';
import 'package:base_core/resources.dart';
import 'package:base_core/storage/storage.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:stacked/stacked_annotations.dart';

import '../../data/dto/account_dto.dart';
import '../../data/remote/app_api.dart';
import '../../data/remote/repository/remote_repository_impl.dart';
import '../../domain/repository/remote_repository.dart';

const String _envBasicAuthUser = 'API_BASIC_AUTH_USER';
const String _envBasicAuthPassword = 'API_BASIC_AUTH_PASSWORD';

class DataSourceModule extends BaseDataSourceModule {
  AppAPI providesAppAPI(Dio dio) => AppAPI(dio, dotenv.env[baseUrl]!);

  Dio providesDio() {
    final dio = Dio(
      BaseOptions(
        receiveDataWhenStatusError: true,
        connectTimeout: Duration(seconds: 30),
        receiveTimeout: Duration(seconds: 30),
        sendTimeout: Duration(seconds: 30),
      ),
    );

    dio.interceptors.add(
      BasicAuthInterceptor(
        username: dotenv.env[_envBasicAuthUser],
        password: dotenv.env[_envBasicAuthPassword],
      ),
    );

    final storageService = StackedLocator.instance<StorageService>();
    Future<TokenRefreshResponse> refreshTokenCallback(String refreshToken) async {
      final completer = Completer<TokenRefreshResponse>();
      final apiImpl = APIImpl((event) {
        if (event is SuccessAPI) {
          final accountDto = event.data as AccountDto;
          completer.complete(
            TokenRefreshResponse(
              accessToken: accountDto.accessToken,
              refreshToken: accountDto.refreshToken,
            ),
          );
        } else {
          completer.completeError('Refresh token failed');
        }
      });
      apiImpl.execApiTask(
        exe: () async => await providesAppAPI(dio).refreshToken(refreshToken: refreshToken),
        key: APIImpl.keyCommon,
      );
      return completer.future;
    }

    dio.interceptors.add(
      AuthInterceptor(
        storageService: storageService,
        refreshTokenCallback: refreshTokenCallback,
        onRefreshFailure: () {
          EventBus.instance.notificationListener(
            name: logoutNotification,
            parameter: ConstStrings.errExpiredLoginTime,
          );
        },
      ),
    );

    return dio;
  }

  RemoteRepository provideRemoteRepository(AppAPI api) => RemoteRepositoryImpl(api);
}
