import 'package:base_core/common/config.dart';
import 'package:base_core/presenter/base_screen_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:saa2025/main.dart' as main_app;
import 'package:saa2025/pages/app_pages.router.dart';
import 'package:saa2025/pages/splash/splash_vm.dart';
import 'package:saa2025/pages/utils/mixin/ui_mixin.dart';
import 'package:saa2025/pages/widgets/update_dialog.dart';
import 'package:saa2025/services/version_check_service.dart';

import '../login/login.dart';
import 'splash_screen.dart';

class SplashState extends StatefulWidget {
  const SplashState({super.key});

  @override
  State<StatefulWidget> createState() => Splash();
}

class Splash extends BaseScreenState<SplashState, SplashVM> with UIMixin {
  @override
  SplashVM initViewModel() => SplashVM();

  @override
  Widget initWidget(BuildContext context) {
    return SplashScreen(this, context).screen();
  }

  @override
  void beforeBuild() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (kDebugMode) {
        _runTask();
        return;
      }
      _checkForUpdate();
    });
  }

  Future<void> _checkForUpdate() async {
    try {
      final versionCheckService = VersionCheckService();
      final result = await versionCheckService.checkForUpdate();
      logger.d('Version Check - Current: ${result.currentVersion}, Latest: ${result.latestVersion}');
      logger.d('Version Check - Has Update: ${result.hasUpdate}, Required: ${result.isRequired}');
      logger.d('Version Check - Download URL: ${result.downloadUrl}');

      if (result.hasUpdate && context.mounted) {
        logger.d('Update available: ${result.latestVersion}');
        showDialog(
          context: context,
          barrierDismissible: !result.isRequired,
          builder: (dialogContext) => UpdateDialogState(
            updateInfo: result,
            version: result.latestVersion,
            isRequired: result.isRequired,
          ),
        );
      } else {
        logger.d('No update available. Current: ${result.currentVersion}');
        _runTask();
      }
    } catch (e) {
      logger.e('Error checking for update: $e');
      _runTask();
    }
  }

  void _runTask() {
    final token = storage.getToken();
    if (token == null || token.isEmpty) {
      navigator.clearStackAndShow(Routes.loginState, arguments: LoginStateArguments(rootBack: LoginRootBack.root));
      return;
    }

    final refreshToken = storage.getPrivateToken();
    final accessToken = storage.getToken() ?? '';
    final isRefreshTokenInvalid = refreshToken.isEmpty || refreshToken == 'N/A';
    final isTokenInvalid = accessToken.isEmpty || accessToken == 'N/A';

    if (isTokenInvalid) {
      logger.d(
        'Splash: invalid session — isRefreshTokenInvalid: $isRefreshTokenInvalid, isTokenInvalid: $isTokenInvalid',
      );
      main_app.logout();
      return;
    }

    navigator.clearStackAndShow(Routes.mainTabState);
  }
}
