import 'package:base_core/common/base_const.dart';
import 'package:base_core/presenter/base_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:saa2025/generated/assets.dart';
import 'package:saa2025/pages/secret_box/secret_box.dart';
import 'package:saa2025/pages/secret_box/widgets/secret_box_activity_tile.dart';
import 'package:saa2025/pages/secret_box/widgets/secret_box_panel.dart';
import 'package:saa2025/pages/utils/extension.dart';
import 'package:saa2025/theme/app_colors.dart';

/// Secret Box screen — MoMorph `kQk65hSYF2` / `KUmv414uC9`.
class SecretBoxScreen extends BaseScreen<SecretBoxPage> {
  SecretBoxScreen(super.main, super.context);

  @override
  Widget screen() {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: AppColors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: Stack(
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
                _topBar(),
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                        child: SecretBoxPanel(
                          visualState: main.visualState,
                          unopenedCount: main.unopenedCount,
                          lastRewardLabel: main.lastRewardLabel,
                          onBoxTap: main.onBoxTap,
                          onStandbyContinue: main.onStandbyContinue,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 4.h),
                        child: Text(
                          tr.secretBoxActivitySectionTitle,
                          style: TextStyle(
                            fontFamily: BaseConst.fontSemiBold,
                            fontSize: 14.sp,
                            color: AppColors.white70,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20.w, bottom: 8.h),
                        child: TextButton.icon(
                          onPressed: main.onMarkAllRead,
                          icon: Icon(Icons.done_all, size: 20.sp, color: AppColors.accent),
                          label: Text(
                            tr.secretBoxMarkAllRead,
                            style: TextStyle(
                              fontFamily: BaseConst.fontBold,
                              fontSize: 14.sp,
                              letterSpacing: 0.25,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 20.w),
                        decoration: BoxDecoration(
                          color: AppColors.panelOverlay,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Column(
                          children: [
                            for (final item in main.activities)
                              SecretBoxActivityTile(
                                item: item,
                                onTap: () => main.onActivityTap(item),
                                onActionTap: () => main.onActivityActionTap(item),
                              ),
                          ],
                        ),
                      ),
                      Gap(32.h),
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
                icon: const Icon(Icons.arrow_back_ios, color: AppColors.textPrimary, size: 20),
                onPressed: main.onBack,
              ),
            ),
            Text(
              tr.secretBoxTitle,
              style: TextStyle(
                fontFamily: BaseConst.fontMedium,
                fontSize: 17.sp,
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
