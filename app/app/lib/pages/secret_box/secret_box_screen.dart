import 'package:base_core/common/base_const.dart';
import 'package:base_core/presenter/base_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:saa2025/generated/assets.dart';
import 'package:saa2025/pages/secret_box/secret_box.dart';
import 'package:saa2025/pages/secret_box/widgets/secret_box_panel.dart';
import 'package:saa2025/pages/utils/extension.dart';
import 'package:saa2025/theme/app_colors.dart';
import 'package:saa2025/theme/saa_design_tokens.dart';

/// Secret Box screen — Figma `3:20845` [iOS] Open secret box.
class SecretBoxScreen extends BaseScreen<SecretBoxPage> {
  SecretBoxScreen(super.main, super.context);

  static const double _listWidth = 335;

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
                decoration: BoxDecoration(color: AppColors.background.withValues(alpha: 0.9)),
              ),
            ),
            Column(
              children: [
                _topBar(),
                Expanded(
                  child: Container(
                    color: AppColors.background,
                    padding: EdgeInsets.only(top: 65),
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children: [
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
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _topBar() {
    return SafeArea(
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
    );
  }
}
