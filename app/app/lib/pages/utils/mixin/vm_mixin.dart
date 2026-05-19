import 'package:base_core/common/config.dart';
import 'package:base_core/common/error_dto.dart';
import 'package:base_core/domain/repository/resource.dart';
import 'package:base_core/presenter/viewmodel/base_vm.dart';
import 'package:base_core/storage/storage.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:https/vn/sun/https/data/dto/base_dto.dart';
import 'package:https/vn/sun/https/domain/usecase/user_usecase.dart';
import 'package:https/vn/sun/https/inject/injection.dart';
import 'package:saa2025/pages/app_pages.locator.dart';

mixin ViewModelMixin on AppBaseViewModel {
  UserCase get userUC => getIt<UserCase>();
  final storageService = locator<StorageService>();
  String currentEnv = 'dev';

  bool get isDev => currentEnv == 'dev';

  Future<void> saveEnvMode(String mode) async {
    await storageService.setString(StorageKey.keySelectedEnv.name, mode);
    currentEnv = mode;
    logger.d('NEON currentEnv = $currentEnv');
  }

  void handleResponseAPI<T>({
    required Object event,
    Function(T)? handleDataAPI,
    required Function(bool) onSuccess,
    required Function(bool) onLoading,
    required Function(String) onToast,
    bool isAuthApi = false,
  }) {
    try {
      logger.d('handleResponseAPI: event = $event');
      if (event is Success) {
        onLoading(false);
        handleDataAPI?.call(event is T ? event : event.data);
        onSuccess(true);
        rebuildUi();
      } else {
        if (event is Loading) {
          onLoading(true);
        } else {
          EasyLoading.dismiss();
          handleError(event, isAuthApi, (error) {
            logger.d('NEON error = $error');
            if (error is ErrorDto) {
              onToast(_getMessageError(error));
              onSuccess(false);
            } else if (error is BaseDto) {
              _handleAPIErrorDto(onToast, error);
            } else {
              onToast(error.toString());
            }
            onLoading(false);
          });
        }
      }
    } catch (e) {
      logger.d(e);
      onLoading(false);
      //onToast(BaseConst.systemError);
    }
  }

  void _handleAPIErrorDto(Function(String) onToast, error) {
    logger.d('NEON _handleAPIErrorDto: error = $error');
    onToast(error.toString());
  }

  String _getMessageError(ErrorDto error) {
    var messageIds = error.messageId;
    var message = error.message ?? '';
    if (messageIds == null) return message;

    if (messageIds.isNotEmpty && messageIds.first == null) {
      return message;
    }

    return messageIds.join('\n');
  }
}
