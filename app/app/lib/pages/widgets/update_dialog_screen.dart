import 'dart:io';

import 'package:base_core/presenter/base_screen.dart';
import 'package:base_core/res/widgets/app_elevated_button.dart';
import 'package:base_core/res/widgets/text.dart';
import 'package:base_core/resources.dart' hide AppColors;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:saa2025/pages/utils/extension.dart';
import 'package:saa2025/pages/widgets/update_dialog.dart';
import 'package:saa2025/theme/app_colors.dart';

class UpdateDialogScreen extends BaseScreen<UpdateDialog> {
  UpdateDialogScreen(super.main, super.context);

  @override
  Widget screen() {
    return PopScope(
      canPop: !main.widget.isRequired, // Prevent dismiss if required
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Container(
          padding: EdgeInsets.all(24.w),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _header(),
              Gap(24.h),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _content(),
                  Gap(24.h),
                  if (main.isDownloading) _progressSection(),
                  if (main.isDownloading) Gap(16.h),
                  _buttons(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _header() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 48.w,
          height: 48.w,
          decoration: BoxDecoration(
            color: AppColors.greenLightest,
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.system_update,
            color: AppColors.greenBase,
            size: 24.w,
          ),
        ),
        Gap(12.w),
        TextCs(
          text: tr.updateAvailable,
          style: AppFonts.regular600.copyWith(
            color: AppColors.inkDarkest,
            fontSize: 18.sp,
          ),
        ),
        Gap(4.h),
        TextCs(
          text: tr.newVersionAvailable(main.widget.updateInfo.latestVersion),
          style: AppFonts.small500.copyWith(
            color: AppColors.inkLight,
            fontSize: 14.sp,
          ),
        ),
        if (!main.widget.isRequired)
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              width: 32.w,
              height: 32.w,
              decoration: BoxDecoration(
                color: AppColors.skyLightest,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.close,
                size: 20.w,
                color: AppColors.inkDarkest,
              ),
            ),
          ),
      ],
    );
  }

  Widget _content() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextCs(
          text: tr.currentVersion,
          style: AppFonts.small500.copyWith(
            color: AppColors.inkBase,
            fontSize: 14.sp,
          ),
        ),
        Gap(4.h),
        TextCs(
          text: '${tr.version} ${main.widget.updateInfo.currentVersion}',
          style: AppFonts.regular400.copyWith(
            color: AppColors.inkDarkest,
            fontSize: 16.sp,
          ),
        ),
        Gap(12.h),
        TextCs(
          text: tr.latestVersion,
          style: AppFonts.small500.copyWith(
            color: AppColors.inkBase,
            fontSize: 14.sp,
          ),
        ),
        Gap(4.h),
        TextCs(
          text: '${tr.version} ${main.widget.updateInfo.latestVersion}',
          style: AppFonts.regular400.copyWith(
            color: AppColors.inkDarkest,
            fontSize: 16.sp,
          ),
        ),
        if (main.widget.updateInfo.changelog.isNotEmpty) ...[
          Gap(16.h),
          TextCs(
            text: tr.whatsNew,
            style: AppFonts.small600.copyWith(
              color: AppColors.inkDarkest,
              fontSize: 14.sp,
            ),
          ),
          Gap(8.h),
          TextCs(
            text: main.widget.updateInfo.changelog,
            style: AppFonts.small400.copyWith(
              color: AppColors.inkBase,
              fontSize: 14.sp,
              height: 1.5,
            ),
          ),
        ],
      ],
    );
  }

  Widget _progressSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextCs(
              text: tr.downloadingUpdate,
              style: AppFonts.small500.copyWith(
                color: AppColors.inkBase,
                fontSize: 14.sp,
              ),
            ),
            TextCs(
              text: '${(main.downloadProgress * 100).toStringAsFixed(0)}%',
              style: AppFonts.small600.copyWith(
                color: AppColors.greenBase,
                fontSize: 14.sp,
              ),
            ),
          ],
        ),
        Gap(8.h),
        ClipRRect(
          borderRadius: BorderRadius.circular(4.r),
          child: LinearProgressIndicator(
            value: main.downloadProgress,
            backgroundColor: AppColors.skyLighter,
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.greenBase),
            minHeight: 8.h,
          ),
        ),
      ],
    );
  }

  Widget _buttons() {
    if (main.isDownloading) {
      return const SizedBox.shrink();
    }

    return Row(
      children: [
        if (!main.widget.isRequired)
          Expanded(
            child: OutlinedButton(
              onPressed: () => Navigator.of(context).pop(),
              style: OutlinedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 14.h),
                side: BorderSide(color: AppColors.skyLight),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              child: TextCs(
                text: tr.updateLater,
                style: AppFonts.regular500.copyWith(
                  color: AppColors.inkBase,
                  fontSize: 16.sp,
                ),
              ),
            ),
          ),
        if (!main.widget.isRequired) Gap(12.w),
        Expanded(
          child: AppElevatedButton(
            title: tr.updateNow,
            onPressed: Platform.isAndroid ? main.handleUpdate : main.handleUpdateIOS,
            height: 48.h,
            backgroundColor: AppColors.greenBase,
            textStyle: AppFonts.regular600.copyWith(
              color: AppColors.white,
              fontSize: 16.sp,
            ),
          ),
        ),
      ],
    );
  }
}
