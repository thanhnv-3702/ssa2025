import 'package:base_core/presenter/base_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:saa2025/pages/errors/access_denied.dart';
import 'package:saa2025/pages/errors/saa_error_copy.dart';
import 'package:saa2025/pages/errors/widgets/saa_error_layout.dart';
import 'package:saa2025/theme/saa_design_tokens.dart';

class AccessDeniedScreen extends BaseScreen<AccessDeniedPage> {
  AccessDeniedScreen(super.main, super.context);

  @override
  Widget screen() {
    final copy = SaaErrorCopy.current();
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: SaaDesignTokens.background,
        body: SaaErrorLayout(
          title: copy.accessDeniedTitle,
          message: copy.accessDeniedMessage,
          goHomeLabel: copy.goHomeLabel,
          illustration: const SaaErrorIllustration(
            assetPath: 'assets/images/errors/error_access_denied.png',
            icon: Icons.lock_outline,
          ),
          onBack: main.onBack,
          onGoHome: main.onGoHome,
        ),
      ),
    );
  }
}
