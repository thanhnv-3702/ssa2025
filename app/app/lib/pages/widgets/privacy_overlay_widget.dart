import 'dart:ui';

import 'package:base_core/res/widgets/text.dart';
import 'package:base_core/resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saa2025/generated/assets.dart';
import 'package:saa2025/pages/utils/const.dart';

/// Privacy overlay widget to hide sensitive data when app is in background
/// Shows blur effect or logo overlay to prevent OS snapshot from capturing sensitive data
class PrivacyOverlayWidget extends StatelessWidget {
  final bool isVisible;

  const PrivacyOverlayWidget({
    super.key,
    required this.isVisible,
  });

  @override
  Widget build(BuildContext context) {
    if (!isVisible) {
      return const SizedBox.shrink();
    }

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                decoration: BoxDecoration(
                  gradient: AppColors.gradient3,
                ),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      Assets.splashIcLogo,
                      width: 193.w,
                    ),
                    SizedBox(height: 32.h),
                    TextCs(
                      text: Const.defaultTitle,
                      style: TextStyle(
                        color: AppColors.greenBase,
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
