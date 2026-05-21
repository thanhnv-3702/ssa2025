import 'package:base_core/common/base_const.dart';
import 'package:base_core/presenter/base_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:saa2025/generated/assets.dart';
import 'package:saa2025/pages/rules/rules.dart';
import 'package:saa2025/pages/rules/rules_mock_data.dart';
import 'package:saa2025/pages/rules/rules_models.dart';
import 'package:saa2025/pages/rules/widgets/rules_hero_badge.dart';
import 'package:saa2025/pages/rules/widgets/rules_saa_icon_chip.dart';
import 'package:saa2025/pages/utils/extension.dart';
import 'package:saa2025/theme/app_colors.dart';
import 'package:saa2025/theme/saa_design_tokens.dart';

/// Thể lệ — Figma `3:22428` [iOS] Thể lệ.
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
                Gap(5),
                _topBar(),
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 32.h),
                    children: [
                      _sectionTitle(tr.rulesContentTitle),
                      Gap(16.h),
                      _heroIntroBlock(),
                      Gap(24.h),
                      const Divider(color: AppColors.divider, height: 1),
                      Gap(24.h),
                      ...RulesMockData.heroLevels.map(_heroLevelBlock),
                      Gap(24.h),
                      _iconsSection(),
                      Gap(24.h),
                      _nationalKudosSection(),
                      Gap(24.h),
                      _footerActions(),
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
              tr.rulesTitle,
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

  Widget _sectionTitle(String text) {
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

  Widget _goldHeading(String text) {
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

  Widget _heroIntroBlock() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _goldHeading(tr.rulesHeroSectionTitle),
        Gap(16.h),
        _bodyText(tr.rulesHeroSectionIntro),
      ],
    );
  }

  Widget _heroLevelBlock(RulesHeroLevel level) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RulesHeroBadge(tier: level.tier),
          Gap(8.h),
          Text(
            _heroRequirement(level),
            style: TextStyle(
              fontFamily: BaseConst.fontBold,
              fontSize: 14.sp,
              height: 20 / 14,
              letterSpacing: 0.25,
              color: AppColors.textPrimary,
            ),
          ),
          Gap(6.h),
          ..._heroDescription(level).split('\n').map(_bodyText),
        ],
      ),
    );
  }

  String _heroRequirement(RulesHeroLevel level) {
    return switch (level.requirementKey) {
      'rulesHeroNewRequirement' => tr.rulesHeroNewRequirement,
      'rulesHeroRisingRequirement' => tr.rulesHeroRisingRequirement,
      'rulesHeroSuperRequirement' => tr.rulesHeroSuperRequirement,
      'rulesHeroLegendRequirement' => tr.rulesHeroLegendRequirement,
      _ => '',
    };
  }

  String _heroDescription(RulesHeroLevel level) {
    return switch (level.descriptionKey) {
      'rulesHeroNewDescription' => tr.rulesHeroNewDescription,
      'rulesHeroRisingDescription' => tr.rulesHeroRisingDescription,
      'rulesHeroSuperDescription' => tr.rulesHeroSuperDescription,
      'rulesHeroLegendDescription' => tr.rulesHeroLegendDescription,
      _ => '',
    };
  }

  Widget _iconsSection() {
    final icons = RulesMockData.saaIcons;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          tr.rulesIconsSectionTitle,
          style: TextStyle(
            fontFamily: BaseConst.fontRegular,
            fontSize: 14.sp,
            height: 20 / 14,
            letterSpacing: 0.25,
            color: AppColors.accent,
          ),
        ),
        Gap(16.h),
        _bodyText(tr.rulesIconsSectionIntro),
        Gap(16.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RulesSaaIconChip(icon: icons[0], width: 48),
            RulesSaaIconChip(icon: icons[1], width: 48),
            RulesSaaIconChip(icon: icons[2], width: 48),
            RulesSaaIconChip(icon: icons[3], width: 50),
            RulesSaaIconChip(icon: icons[4], width: 64),
            RulesSaaIconChip(icon: icons[5], width: 48),
          ],
        ),
        Gap(16.h),
        _bodyText(tr.rulesIconsFooter),
      ],
    );
  }

  Widget _nationalKudosSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _goldHeading(tr.rulesNationalKudosTitle),
        Gap(16.h),
        _bodyText(tr.rulesNationalKudosBody),
      ],
    );
  }

  Widget _footerActions() {
    return Row(
      children: [
        Expanded(
          child: _outlineAction(
            label: tr.rulesCloseButton,
            onTap: main.onBack,
          ),
        ),
        Gap(12.w),
        Expanded(
          child: _filledAction(
            label: tr.rulesWriteKudoButton,
            onTap: main.onWriteKudoTap,
          ),
        ),
      ],
    );
  }

  Widget _outlineAction({required String label, required VoidCallback onTap}) {
    return Material(
      color: AppColors.accentSurface10,
      borderRadius: BorderRadius.circular(4.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(4.r),
        child: Container(
          height: 40.h,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.r),
            border: Border.all(color: AppColors.borderMuted, width: 0.5),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontFamily: BaseConst.fontMedium,
              fontSize: 14.sp,
              height: 20 / 14,
              color: AppColors.textPrimary,
            ),
          ),
        ),
      ),
    );
  }

  Widget _filledAction({required String label, required VoidCallback onTap}) {
    return Material(
      color: AppColors.accentGold,
      borderRadius: BorderRadius.circular(4.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(4.r),
        child: SizedBox(
          height: 40.h,
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                fontFamily: BaseConst.fontMedium,
                fontSize: 14.sp,
                height: 20 / 14,
                color: AppColors.background,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
