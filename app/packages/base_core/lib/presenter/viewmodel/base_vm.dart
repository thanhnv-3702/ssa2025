import 'dart:convert';

import 'package:base_core/common/config.dart';
import 'package:base_core/common/const_strings.dart';
import 'package:base_core/common/data_exception.dart';
import 'package:base_core/common/event_bus.dart';
import 'package:base_core/domain/network/api_impl.dart';
import 'package:base_core/domain/repository/resource.dart' as rs;
import 'package:base_core/localization/localization_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import '../../common/error_dto.dart';
import '../../resources.dart';

enum LoadingState { idle, preLoading, refreshing, loadMore, noMore }

abstract class AppBaseViewModel extends BaseViewModel {
  static const tag = 'AppBaseViewModel';
  LoadingState loadingState = LoadingState.idle;

  bool get isEN => StackedLocator.instance<LocalizationService>().isEN;

  void init() {
    //do nothing
  }

  void handleError(dynamic event, bool isAuthApi, Function(dynamic) callBack) {
    logger.d('[$tag] - handleError callBack: $event');
    if (event is rs.Notify || event is rs.Failed) {
      if (event is rs.Notify) {
        final txt = (event as rs.Resource).message ?? systemErrorMsg;
        callBack(ErrorDto.fromText(txt));
        return;
      }

      try {
        var data = (event as rs.Failed).error;
        logger.d('NEON - handleError: data = $data');
        if (data is ErrorAPI) {
          final errorDto = data.data;
          if (errorDto is String) {
            callBack(ErrorDto.fromText(errorDto));
            return;
          } else {
            callBack(errorDto);
          }
        }

        if (data is DataException) {
          data = data.dataError;
        }

        if (data is Map<String, dynamic>) {
          final errorDto = ErrorDto.fromJson(data);
          logger.d('[$tag] - handleError: txt = $data');
          if (errorDto.code == '401' && !isAuthApi) {
            EventBus.instance
                .notificationListener(name: logoutNotification, parameter: ConstStrings.errExpiredLoginTime);
            return;
          }
          callBack(errorDto);
        } else {
          callBack(data);
        }
      } catch (e) {
        logger.d(e);
        callBack(ErrorDto.fromJson(json.decode(systemErrorMsg)));
      }
    }
  }
}
