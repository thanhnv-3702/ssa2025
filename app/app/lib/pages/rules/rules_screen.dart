import 'package:base_core/common/base_const.dart';
import 'package:base_core/presenter/base_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:saa2025/pages/rules/rules.dart';
import 'package:saa2025/pages/widgets/saa_app_header.dart';

class RulesScreen extends BaseScreen<Rules> {
  RulesScreen(super.main, super.context);

  static const Color _background = Color(0xFF00101A);
  static const Color _accent = Color(0xFFFFE99E);
  static const Color _textOnDark = Color(0xFFFFFFFF);

  @override
  Widget screen() {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: _background,
        body: Column(
          children: [
            SaaAppHeader(
              languageCode: 'VN',
              onLanguageTap: () {},
              showBack: true,
              onBack: main.onBack,
              title: 'Thể lệ',
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 32.h),
                children: [
                  Text(
                    'Sun* Annual Awards 2025',
                    style: TextStyle(
                      fontFamily: BaseConst.fontSemiBold,
                      fontSize: 20.sp,
                      color: _textOnDark,
                    ),
                  ),
                  Gap(12.h),
                  Text(
                    main.intro,
                    style: TextStyle(
                      fontFamily: BaseConst.fontLight,
                      fontSize: 14.sp,
                      height: 22 / 14,
                      color: _textOnDark.withValues(alpha: 0.9),
                    ),
                  ),
                  Gap(24.h),
                  for (final section in main.sections) ...[
                    Text(
                      section.title,
                      style: TextStyle(
                        fontFamily: BaseConst.fontSemiBold,
                        fontSize: 15.sp,
                        color: _accent,
                      ),
                    ),
                    Gap(8.h),
                    Text(
                      section.body,
                      style: TextStyle(
                        fontFamily: BaseConst.fontLight,
                        fontSize: 14.sp,
                        height: 22 / 14,
                        color: _textOnDark.withValues(alpha: 0.9),
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
