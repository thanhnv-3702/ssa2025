import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:saa2025/generated/assets.dart';
import 'package:saa2025/theme/app_colors.dart';

/// Shared SAA header — logo, language, search, notifications.
class SaaAppHeader extends StatelessWidget {
  const SaaAppHeader({
    super.key,
    required this.languageCode,
    required this.onLanguageTap,
    this.onSearchTap,
    this.onNotificationTap,
    this.hasUnreadNotifications = false,
    this.showBack = false,
    this.onBack,
    this.title,
  });

  final String languageCode;
  final VoidCallback onLanguageTap;
  final VoidCallback? onSearchTap;
  final VoidCallback? onNotificationTap;
  final bool hasUnreadNotifications;
  final bool showBack;
  final VoidCallback? onBack;
  final String? title;

  static const LinearGradient _headerGradient = AppColors.headerOverlayGradientShort;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 96.h,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 104.h,
            child: const DecoratedBox(decoration: BoxDecoration(gradient: _headerGradient)),
          ),
          if (showBack)
            Positioned(
              left: 4.w,
              bottom: 4.h,
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: AppColors.textPrimary, size: 20),
                onPressed: onBack,
              ),
            ),
          if (!showBack)
            Positioned(
              left: 20.w,
              bottom: 8.h,
              child: Image.asset(Assets.homeHomeHeaderLogo, width: 48.w, height: 44.h),
            ),
          if (title != null)
            Positioned(
              left: showBack ? 48.w : 76.w,
              bottom: 16.h,
              child: Text(
                title!,
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          Positioned(
            right: 12.w,
            bottom: 8.h,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _languageChip(),
                if (onSearchTap != null) ...[
                  Gap(8.w),
                  _iconButton(Assets.homeHomeIcSearch, onSearchTap!),
                ],
                if (onNotificationTap != null) ...[
                  Gap(4.w),
                  _notificationButton(),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _languageChip() {
    return InkWell(
      onTap: onLanguageTap,
      borderRadius: BorderRadius.circular(20.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.white30),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              languageCode,
              style: TextStyle(color: AppColors.textPrimary, fontSize: 12.sp, fontWeight: FontWeight.w600),
            ),
            Gap(4.w),
            Icon(Icons.keyboard_arrow_down, color: AppColors.textPrimary, size: 16.sp),
          ],
        ),
      ),
    );
  }

  Widget _iconButton(String asset, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24.r),
      child: Padding(
        padding: EdgeInsets.all(8.w),
        child: SvgPicture.asset(asset, width: 24.w, height: 24.w),
      ),
    );
  }

  Widget _notificationButton() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        _iconButton(Assets.homeHomeIcNotification, onNotificationTap!),
        if (hasUnreadNotifications)
          Positioned(
            top: 6.h,
            right: 6.w,
            child: Container(
              width: 8.w,
              height: 8.w,
              decoration: const BoxDecoration(
                color: AppColors.errorMaterial,
                shape: BoxShape.circle,
              ),
            ),
          ),
      ],
    );
  }
}
