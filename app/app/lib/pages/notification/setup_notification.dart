import 'dart:io';

import 'package:base_core/common/config.dart';
import 'package:base_core/presenter/base_screen_state.dart';
import 'package:flutter/material.dart';
import 'package:saa2025/pages/utils/extension.dart';
import 'package:saa2025/pages/utils/mixin/ui_mixin.dart';
import 'package:permission_handler/permission_handler.dart';

import 'setup_notification_screen.dart';
import 'setup_notification_vm.dart';

class NotificationSetupState extends StatefulWidget {
  const NotificationSetupState({super.key});

  @override
  State<StatefulWidget> createState() => SetupNotification();
}

class SetupNotification extends BaseScreenState<NotificationSetupState, SetupNotificationVm> with UIMixin {
  bool _isNotificationEnabled = false;

  bool get isNotificationEnabled => _isNotificationEnabled;

  @override
  SetupNotificationVm initViewModel() => SetupNotificationVm();

  @override
  void beforeBuild() {
    super.beforeBuild();
    _loadNotificationState();
  }

  void _loadNotificationState() {
    setState(() {
      _isNotificationEnabled = vm.getNotificationEnabled();
    });
  }

  @override
  Widget initWidget(BuildContext context) => SetupNotificationScreen(this, context).screen();

  Future<void> onNotificationToggleChanged(bool value) async {
    if (value) {
      final bool granted = await _requestNotificationPermission();
      if (!granted) {
        setState(() => _isNotificationEnabled = false);
        handleToast(tr.allowNotification);
        return;
      }
    }
    vm.updateNotificationEnabled(
      onToast: handleToast,
      onLoading: handleLoading,
      onSuccess: (isSuccess) {
        if (isSuccess) {
          setState(() {
            _isNotificationEnabled = value;
          });
        }
      },
      enabled: value,
    );
    logger.d('Notification enabled set to: $value');
  }

  /// Request system notification permission. Returns true if granted or already granted.
  Future<bool> _requestNotificationPermission() async {
    if (Platform.isAndroid) {
      final status = await Permission.notification.request();
      return status.isGranted;
    }
    if (Platform.isIOS) {
      final status = await Permission.notification.request();
      return status.isGranted;
    }
    return true;
  }

  void onBackPressed() {
    navigator.back();
  }
}
