import 'package:base_core/common/base_const.dart';
import 'package:base_core/presenter/base_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:saa2025/generated/app_localizations.dart';
import 'package:saa2025/generated/assets.dart';
import 'package:saa2025/pages/kudos/community_standards.dart';
import 'package:saa2025/pages/kudos/community_standards_mock_data.dart';
import 'package:saa2025/pages/utils/extension.dart';
import 'package:saa2025/theme/app_colors.dart';
import 'package:saa2025/theme/saa_design_tokens.dart';

/// Tiêu chuẩn cộng đồng — Figma `3:22374` [iOS] Sun*Kudos_Tiêu chuẩn cộng đồng.
class CommunityStandardsScreen extends BaseScreen<CommunityStandards> {
  CommunityStandardsScreen(super.main, super.context);

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
                Gap(8),
                _topBar(),
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 32.h),
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Image.asset(
                          Assets.homeHomeRootFurther,
                          width: 151.w,
                          height: 64.h,
                          fit: BoxFit.contain,
                          alignment: Alignment.bottomLeft,
                        ),
                      ),
                      Gap(24.h),
                      _communitySection(),
                      Gap(12.h),
                      const Divider(color: AppColors.divider, height: 1),
                      Gap(12.h),
                      _privacySection(),
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
                padding: EdgeInsets.only(left: 7.w),
                icon: const Icon(Icons.arrow_back_ios, color: AppColors.textPrimary, size: 20),
                onPressed: main.onBack,
              ),
            ),
            Text(
              tr.communityStandardsScreenTitle,
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

  Widget _communitySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeading(tr.communityStandardsSectionTitle),
        Gap(16.h),
        _goldBody(tr.communityStandardsPurpose),
        Gap(16.h),
        _bodyText(tr.communityStandardsSpamIntro),
        Gap(16.h),
        ...List.generate(
          CommunityStandardsMockData.communityRuleKeys.length,
          (i) => _numberedRule(i + 1, _ruleText(tr, CommunityStandardsMockData.communityRuleKeys[i])),
        ),
      ],
    );
  }

  Widget _privacySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeading(tr.privacyStandardsSectionTitle),
        Gap(16.h),
        _boldWhiteBody(tr.communityStandardsPrivacyCommitment),
        Gap(8.h),
        ...CommunityStandardsMockData.privacyBulletKeys.map(
          (key) => _bulletItem(_ruleText(tr, key)),
        ),
        Gap(16.h),
        _goldBody(tr.communityStandardsSupport),
      ],
    );
  }

  String _ruleText(AppLocalizations tr, String key) {
    return switch (key) {
      'communityStandardsRule1' => tr.communityStandardsRule1,
      'communityStandardsRule2' => tr.communityStandardsRule2,
      'communityStandardsRule3' => tr.communityStandardsRule3,
      'communityStandardsRule4' => tr.communityStandardsRule4,
      'communityStandardsRule5' => tr.communityStandardsRule5,
      'communityStandardsRule6' => tr.communityStandardsRule6,
      'communityStandardsRule7' => tr.communityStandardsRule7,
      'communityStandardsRule8' => tr.communityStandardsRule8,
      'communityStandardsRule9' => tr.communityStandardsRule9,
      'communityStandardsRule10' => tr.communityStandardsRule10,
      'communityStandardsPrivacyBullet1' => tr.communityStandardsPrivacyBullet1,
      'communityStandardsPrivacyBullet2' => tr.communityStandardsPrivacyBullet2,
      _ => '',
    };
  }

  Widget _sectionHeading(String text) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: BaseConst.fontBold,
        fontSize: 18.sp,
        height: 24 / 18,
        color: AppColors.accent,
      ),
    );
  }

  Widget _goldBody(String text) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: BaseConst.fontBold,
        fontSize: 14.sp,
        height: 20 / 14,
        letterSpacing: 0.25,
        color: AppColors.accent,
      ),
    );
  }

  Widget _boldWhiteBody(String text) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: BaseConst.fontBold,
        fontSize: 14.sp,
        height: 20 / 14,
        letterSpacing: 0.25,
        color: AppColors.textPrimary,
      ),
    );
  }

  Widget _bodyText(String text) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: BaseConst.fontRegular,
        fontSize: 14.sp,
        height: 20 / 14,
        letterSpacing: 0.25,
        color: AppColors.textPrimary,
      ),
    );
  }

  Widget _numberedRule(int index, String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 4.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 20.w,
            child: Text(
              '$index.',
              style: TextStyle(
                fontFamily: BaseConst.fontRegular,
                fontSize: 14.sp,
                height: 20 / 14,
                letterSpacing: 0.25,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          Expanded(child: _bodyText(text)),
        ],
      ),
    );
  }

  Widget _bulletItem(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 4.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 2.h, right: 8.w),
            child: Text(
              '•',
              style: TextStyle(
                fontFamily: BaseConst.fontRegular,
                fontSize: 14.sp,
                height: 20 / 14,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          Expanded(child: _bodyText(text)),
        ],
      ),
    );
  }
}
