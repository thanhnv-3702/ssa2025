import 'package:base_core/common/base_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:saa2025/generated/assets.dart';
import 'package:saa2025/theme/saa_design_tokens.dart';

/// Shared error page body — MoMorph Access denied / Not Found.
class SaaErrorLayout extends StatelessWidget {
  const SaaErrorLayout({
    super.key,
    required this.title,
    required this.message,
    required this.illustration,
    required this.onGoHome,
    required this.goHomeLabel,
    this.onBack,
  });

  final String title;
  final String message;
  final Widget illustration;
  final VoidCallback onGoHome;
  final String goHomeLabel;
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          height: 320.h,
          child: Image.asset(Assets.homeHomeBg, fit: BoxFit.cover),
        ),
        Column(
          children: [
            _topBar(context),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(20.w, 40.h, 20.w, 32.h),
                child: Column(
                  children: [
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: BaseConst.fontBold,
                        fontSize: 18.sp,
                        height: 24 / 18,
                        color: SaaDesignTokens.accent,
                      ),
                    ),
                    Gap(8.h),
                    const Divider(color: SaaDesignTokens.divider, height: 1),
                    Gap(8.h),
                    Text(
                      message,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: BaseConst.fontMedium,
                        fontSize: 14.sp,
                        height: 20 / 14,
                        color: SaaDesignTokens.textOnDark,
                      ),
                    ),
                    Gap(24.h),
                    illustration,
                    Gap(24.h),
                    const Divider(color: SaaDesignTokens.divider, height: 1),
                    Gap(24.h),
                    SizedBox(
                      width: double.infinity,
                      height: 40.h,
                      child: Material(
                        color: SaaDesignTokens.accent,
                        borderRadius: BorderRadius.circular(4.r),
                        child: InkWell(
                          onTap: onGoHome,
                          borderRadius: BorderRadius.circular(4.r),
                          child: Center(
                            child: Text(
                              goHomeLabel,
                              style: TextStyle(
                                fontFamily: BaseConst.fontMedium,
                                fontSize: 14.sp,
                                color: SaaDesignTokens.background,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _topBar(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: SizedBox(
        height: 42.h,
        child: Stack(
          alignment: Alignment.center,
          children: [
            if (onBack != null)
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
                  onPressed: onBack,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// Figma-aligned illustration — SVG asset with icon fallback.
class SaaErrorIllustration extends StatelessWidget {
  const SaaErrorIllustration({
    super.key,
    this.assetPath,
    this.icon = Icons.error_outline,
  });

  final String? assetPath;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 320.w,
      height: 248.h,
      child: Center(
        child: assetPath != null
            ? Image.asset(
                assetPath!,
                width: 320.w,
                height: 248.h,
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) => _iconFallback(),
              )
            : _iconFallback(),
      ),
    );
  }

  Widget _iconFallback() {
    return Icon(
      icon,
      size: 120.sp,
      color: SaaDesignTokens.accent.withValues(alpha: 0.85),
    );
  }
}
