import 'package:base_core/common/base_const.dart';
import 'package:base_core/presenter/base_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:saa2025/pages/rules/rules.dart';
import 'package:saa2025/pages/utils/extension.dart';
import 'package:saa2025/pages/widgets/saa_app_header.dart';
import 'package:saa2025/theme/app_colors.dart';

class RulesScreen extends BaseScreen<Rules> {
  RulesScreen(super.main, super.context);

  @override
  Widget screen() {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: AppColors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: Column(
          children: [
            SaaAppHeader(
              languageCode: 'VN',
              onLanguageTap: () {},
              showBack: true,
              onBack: main.onBack,
              title: tr.rulesTitle,
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 32.h),
                children: [
                  Text(
                    tr.rulesEventTitle,
                    style: TextStyle(
                      fontFamily: BaseConst.fontSemiBold,
                      fontSize: 20.sp,
                      color: AppColors.textOnDark,
                    ),
                  ),
                  Gap(12.h),
                  Text(
                    main.intro,
                    style: TextStyle(
                      fontFamily: BaseConst.fontLight,
                      fontSize: 14.sp,
                      height: 22 / 14,
                      color: AppColors.textOnDark.withValues(alpha: 0.9),
                    ),
                  ),
                  Gap(24.h),
                  for (final section in main.sections) ...[
                    Text(
                      section.title,
                      style: TextStyle(
                        fontFamily: BaseConst.fontSemiBold,
                        fontSize: 15.sp,
                        color: AppColors.accent,
                      ),
                    ),
                    Gap(8.h),
                    Text(
                      section.body,
                      style: TextStyle(
                        fontFamily: BaseConst.fontLight,
                        fontSize: 14.sp,
                        height: 22 / 14,
                        color: AppColors.textOnDark.withValues(alpha: 0.9),
                      ),
                    ),
                    Gap(20.h),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
