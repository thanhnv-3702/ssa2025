import 'package:base_core/common/base_const.dart';
import 'package:base_core/presenter/base_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:saa2025/generated/assets.dart';
import 'package:saa2025/pages/secret_box/secret_box.dart';
import 'package:saa2025/pages/secret_box/secret_box_models.dart';
import 'package:saa2025/pages/secret_box/widgets/secret_box_activity_tile.dart';
import 'package:saa2025/pages/secret_box/widgets/secret_box_panel.dart';
import 'package:saa2025/pages/utils/extension.dart';
import 'package:saa2025/theme/app_colors.dart';
import 'package:saa2025/theme/saa_design_tokens.dart';

/// Secret Box screen — Figma `3:20845` [iOS] Open secret box.
class SecretBoxScreen extends BaseScreen<SecretBoxPage> {
  SecretBoxScreen(super.main, super.context);

  @override
  Widget screen() {
    final visible = main.visibleActivities;

    return AnnotatedRegion(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: AppColors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(Assets.homeHomeBg, fit: BoxFit.cover),
            ),
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: AppColors.scaffoldFadeGradientColors,
                  ),
                ),
              ),
            ),
            Column(
              children: [
                _topBar(),
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      _markAllReadRow(),
                      Gap(12.h),
                      _notificationList(visible),
                      Gap(16.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: SecretBoxPanel(
                          visualState: main.visualState,
                          unopenedCount: main.unopenedCount,
                          lastRewardLabel: main.lastRewardLabel,
                          onBoxTap: main.onBoxTap,
                          onStandbyContinue: main.onStandbyContinue,
                        ),
                      ),
                      Gap(40.h),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _markAllReadRow() {
    return Padding(
      padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 12.h),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Material(
          color: AppColors.transparent,
          child: InkWell(
            onTap: main.onMarkAllRead,
            borderRadius: BorderRadius.circular(4.r),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.done_all, size: 24.sp, color: AppColors.textPrimary),
                  Gap(4.w),
                  Text(
                    tr.secretBoxMarkAllRead,
                    style: TextStyle(
                      fontFamily: BaseConst.fontBold,
                      fontSize: 14.sp,
                      height: 20 / 14,
                      letterSpacing: 0.25,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _notificationList(List<SecretBoxActivityItem> visible) {
    return Center(
      child: Container(
        width: 335.w,
        decoration: BoxDecoration(
          color: AppColors.panelOverlay,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Column(
          children: [
            for (var i = 0; i < visible.length; i++)
              SecretBoxActivityTile(
                item: visible[i],
                showBottomBorder: i < visible.length - 1,
                onTap: () => main.onActivityTap(visible[i]),
                onActionTap: () => main.onActivityActionTap(visible[i]),
              ),
            if (main.canShowMore) _showMoreButton(),
          ],
        ),
      ),
    );
  }

  Widget _showMoreButton() {
    return SizedBox(
      height: 40.h,
      width: double.infinity,
      child: TextButton(
        onPressed: main.onShowMore,
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          minimumSize: Size.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: Text(
          tr.secretBoxShowMore,
          style: TextStyle(
            fontFamily: BaseConst.fontMedium,
            fontSize: 14.sp,
            height: 20 / 14,
            color: AppColors.textPrimary,
            decoration: TextDecoration.underline,
            decorationColor: AppColors.textPrimary,
          ),
        ),
      ),
    );
  }

  Widget _topBar() {
    return ColoredBox(
      color: AppColors.background.withValues(alpha: 0.9),
      child: SafeArea(
        bottom: false,
        child: SizedBox(
          height: 42.h,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  padding: EdgeInsets.only(left: 7.w),
                  icon: const Icon(Icons.arrow_back_ios, color: AppColors.textPrimary, size: 20),
                  onPressed: main.onBack,
                ),
              ),
              Text(
                tr.secretBoxTitle,
                style: TextStyle(
                  fontFamily: BaseConst.fontMedium,
                  fontSize: 17.sp,
                  height: 24 / 17,
                  letterSpacing: 0.5,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
