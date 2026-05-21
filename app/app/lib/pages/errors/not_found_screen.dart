import 'package:base_core/presenter/base_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:saa2025/pages/errors/not_found.dart';
import 'package:saa2025/pages/errors/saa_error_copy.dart';
import 'package:saa2025/pages/errors/widgets/saa_error_layout.dart';
import 'package:saa2025/theme/app_colors.dart';
import 'package:saa2025/theme/saa_design_tokens.dart';

class NotFoundScreen extends BaseScreen<NotFoundPage> {
  NotFoundScreen(super.main, super.context);

  @override
  Widget screen() {
    final copy = SaaErrorCopy.current();
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: AppColors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SaaErrorLayout(
          title: copy.notFoundTitle,
          message: copy.notFoundMessage,
          goHomeLabel: copy.goHomeLabel,
          illustration: const SaaErrorIllustration(
            assetPath: 'assets/images/errors/error_not_found.png',
            icon: Icons.search_off,
          ),
          onBack: main.onBack,
          onGoHome: main.onGoHome,
        ),
      ),
    );
  }
}
