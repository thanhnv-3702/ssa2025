import 'dart:math';

import 'package:base_core/presenter/base_screen.dart';
import 'package:base_core/res/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:saa2025/generated/assets.dart';
import 'package:saa2025/pages/home/home_styles.dart';
import 'package:saa2025/pages/kudos/kudos.dart';
import 'package:saa2025/pages/kudos/kudos_mock_data.dart';
import 'package:saa2025/pages/kudos/kudos_models.dart';
import 'package:saa2025/pages/kudos/widgets/kudos_filter_dropdown.dart';
import 'package:saa2025/pages/kudos/widgets/kudos_highlight_card.dart';
import 'package:saa2025/pages/utils/extension.dart';
import 'package:saa2025/theme/app_colors.dart';
import 'package:saa2025/theme/saa_design_tokens.dart';

/// Sun* Kudos hub — MoMorph screen `fO0Kt19sZZ` ([iOS] Sun*Kudos).
class KudosScreen extends BaseScreen<Kudos> {
  KudosScreen(super.main, super.context);

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
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: AppColors.scaffoldFadeGradientColors,
                ),
              ),
            ),
            CustomScrollView(
              slivers: [
                SliverToBoxAdapter(child: _buildHeader()),
                SliverToBoxAdapter(child: _buildHero()),
                SliverToBoxAdapter(child: _buildSendCta()),
                SliverToBoxAdapter(child: _buildHighlightSection()),
                SliverToBoxAdapter(child: _buildSpotlightSection()),
                SliverToBoxAdapter(child: _buildAllKudosSection()),
                SliverToBoxAdapter(child: Gap(100.h)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return SizedBox(
      height: 96.h,
      child: Stack(
        children: [
          Positioned(
            left: 20.w,
            bottom: 8.h,
            child: Image.asset(
              Assets.homeHomeLogo,
              width: 48.w,
              height: 44.h,
            ),
          ),
          Positioned(
            right: 12.w,
            bottom: 8.h,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildLanguageChip(),
                Gap(8.w),
                _iconButton(Assets.homeHomeIcSearch, main.onSearchTap),
                Gap(4.w),
                _notificationButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageChip() {
    return InkWell(
      onTap: main.onLanguageTap,
      borderRadius: BorderRadius.circular(4.r),
      child: Padding(
        padding: EdgeInsets.fromLTRB(8.w, 4.h, 0, 4.h),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              Assets.flagsVn,
              width: 24.w,
              height: 24.h,
            ),
            Gap(4.w),
            Text(main.languageCode, style: HomeStyles.languageCode),
            SvgPicture.asset(
              Assets.commonIcDown,
              width: 24.w,
              height: 24.h,
              colorFilter: const ColorFilter.mode(AppColors.textPrimary, BlendMode.srcIn),
            ),
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
        child: SvgPicture.asset(
          asset,
          width: 24.w,
          height: 24.w,
          colorFilter: ColorFilter.mode(
            AppColors.textPrimary,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }

  Widget _notificationButton() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        _iconButton(Assets.homeHomeIcNotification, main.onNotificationTap),
        if (main.hasUnreadNotifications)
          Positioned(
            top: 6.h,
            right: 6.w,
            child: Container(
              width: 8.w,
              height: 8.w,
              decoration: const BoxDecoration(color: AppColors.errorMaterial, shape: BoxShape.circle),
            ),
          ),
      ],
    );
  }

  Widget _buildHero() {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                tr.kudosRecognitionSystemEyebrow,
                style: TextStyle(color: AppColors.accent, fontSize: 14.sp),
              ),
              Gap(12.h),
              Row(
                children: [
                  SvgPicture.asset(Assets.kudosKudosLogo, height: 38.w),
                  Gap(8.w),
                  SvgPicture.asset(Assets.kudosKudosText, height: 38.w),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSendCta() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Material(
        color: AppColors.accent.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(4.r),
        child: InkWell(
          onTap: main.onSendKudoTap,
          borderRadius: BorderRadius.circular(4.r),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.accentOrange.withValues(alpha: 0.1),
              border: Border.all(color: AppColors.borderMuted),
              borderRadius: BorderRadius.circular(4.r),
            ),
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            child: Row(
              children: [
                SvgPicture.asset(
                  Assets.kudosKudosPen,
                  colorFilter: ColorFilter.mode(
                    AppColors.textPrimary,
                    BlendMode.srcIn,
                  ),
                  width: 24.w,
                  height: 24.w,
                ),
                Gap(8.w),
                Expanded(
                  child: Text(
                    tr.kudosSendCtaPrompt,
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHighlightSection() {
    return Padding(
      padding: EdgeInsets.only(top: 32.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionHeader(tr.kudosHighlightSectionTitle, showFilters: true),
          Gap(16.h),
          SizedBox(
            height: 255.h,
            child: Stack(
              children: [
                PageView.builder(
                  controller: main.highlightController,
                  itemCount: main.highlightPageCount,
                  onPageChanged: main.onHighlightPageChanged,
                  itemBuilder: (_, i) {
                    if (main.highlights.isEmpty) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Center(
                          child: Text(
                            tr.kudosHighlightEmptyFiltered,
                            style: TextStyle(color: AppColors.textMuted, fontSize: 14.sp),
                          ),
                        ),
                      );
                    }
                    final item = main.highlights[i];
                    return Padding(
                      padding: EdgeInsets.only(left: i == 0 ? 20.w : 8.w, right: 8.w),
                      child: KudosHighlightCard(
                        item: item,
                        onTap: () => main.onKudoTap(item),
                      ),
                    );
                  },
                ),
                Container(
                  height: double.infinity,
                  width: 28,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.background,
                        AppColors.background.withValues(alpha: 0.5),
                        AppColors.background.withValues(alpha: 0),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  child: Container(
                    height: double.infinity,
                    width: 28,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.background.withValues(alpha: 0),
                          AppColors.background.withValues(alpha: 0.5),
                          AppColors.background,
                        ],
                      ),
                    ),
                  ),
                  top: 0,
                  bottom: 0,
                  right: 0,
                ),
              ],
            ),
          ),
          Gap(12.h),
          _buildPager(),
        ],
      ),
    );
  }

  Widget _buildPager() {
    final current = main.highlightPage + 1;
    final total = main.highlightPageCount;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _pagerArrow(Icons.chevron_left, main.onHighlightPrev, enabled: main.highlightPage > 0),
          Gap(16.w),
          Text(
            '$current',
            style: TextStyle(color: AppColors.accent, fontSize: 14.sp, fontWeight: FontWeight.w800),
          ),
          Text(
            '/$total',
            style: TextStyle(color: AppColors.gray, fontSize: 14.sp, fontWeight: FontWeight.w800),
          ),
          Gap(16.w),
          _pagerArrow(
            Icons.chevron_right,
            main.onHighlightNext,
            enabled: main.highlightPage < total - 1,
          ),
        ],
      ),
    );
  }

  Widget _pagerArrow(IconData icon, VoidCallback onTap, {required bool enabled}) {
    return InkWell(
      onTap: enabled ? onTap : null,
      child: Icon(icon, color: enabled ? AppColors.textPrimary : AppColors.textMuted, size: 28.sp),
    );
  }

  Widget _buildSpotlightSection() {
    return Padding(
      padding: EdgeInsets.only(top: 32.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionHeader(tr.kudosSpotlightSectionTitle),
          Gap(16.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: AppColors.accentBorder20),
              ),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12.r),
                      child: Stack(
                        children: [
                          Image.asset(
                            Assets.kudosKudosSpotlightBg,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                          ),
                          Container(
                            color: AppColors.overlayBlack70,
                          ),
                        ],
                      ),
                    ),
                  ),
                  _buildSpotlightContent().marginAll(12),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSpotlightContent() {
    return Stack(
      children: [
        Column(
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: main.onSpotlightSearchTap,
                  child: Container(
                    padding: EdgeInsets.only(left: 6.w, top: 2.h, bottom: 2.h, right: 32.w),
                    decoration: BoxDecoration(
                      color: AppColors.accent.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(13.464.r),
                      border: Border.all(color: AppColors.borderMuted),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.search, color: AppColors.textPrimary, size: 12.w),
                        Gap(8.w),
                        Text(
                          tr.kudosSpotlightSearch,
                          style: TextStyle(
                            color: AppColors.textPrimary,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.03,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                  child: Text(
                    tr.kudosSpotlightTotalCount(main.stats.totalKudos),
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            Gap(16.h),
            Wrap(
              spacing: 8.w,
              runSpacing: 8.h,
              children: main.filteredSpotlight.map(
                (e) {
                  SunnerProfile? sunner;
                  for (final s in KudosMockData.sunners) {
                    if (s.name == e.name) {
                      sunner = s;
                      break;
                    }
                  }
                  return InkWell(
                    child: Text(
                      e.name,
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 8.sp,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.06,
                      ),
                    ).marginOnly(top: Random().nextInt(12).toDouble()),
                    onTap: sunner != null ? () => main.onSpotlightSunnerTap(sunner!) : null,
                  );
                },
              ).toList(),
            ),
          ],
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: InkWell(
            child: SvgPicture.asset(
              Assets.kudosKudosPanZoom,
              width: 12.w,
              height: 12.w,
            ),
            onTap: () {},
          ),
        ),
      ],
    );
  }

  Widget _buildAllKudosSection() {
    return Padding(
      padding: EdgeInsets.only(top: 32.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionHeader(tr.kudosAllSectionTitle),
          Gap(24.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: _buildUserStats(),
          ),
          Gap(24.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: _buildTopGiftReceivers(),
          ),
          Gap(24.h),
          Center(
            child: Column(
              children: main.allKudos
                  .take(3)
                  .map(
                    (item) => Padding(
                      padding: EdgeInsets.only(bottom: 12.h),
                      child: KudosListTileCard(
                        item: item,
                        onTap: () => main.onKudoTap(item),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          Center(
            child: InkWell(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    tr.kudosViewAllLink,
                    style: TextStyle(color: AppColors.textPrimary, fontSize: 14.sp, fontWeight: FontWeight.w600),
                  ),
                  SvgPicture.asset(
                    Assets.kudosArrowCross,
                    width: 24,
                    colorFilter: ColorFilter.mode(AppColors.textPrimary, BlendMode.srcIn),
                  )
                ],
              ),
              onTap: main.onViewAllKudosTap,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserStats() {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColors.containerDark,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AppColors.borderMuted, width: 0.794),
      ),
      child: Column(
        children: [
          _statRow(tr.kudosStatsReceivedLabel, '25'),
          Gap(12.h),
          _statRow(tr.kudosStatsSentLabel, '25'),
          Gap(12.h),
          _statRowWithIcon(tr.kudosStatsHeartsLabel, '25'),
          Gap(12.h),
          Container(height: 0.794, color: AppColors.divider),
          Gap(12.h),
          _statRow(tr.kudosStatsSecretBoxOpenedLabel, '25'),
          Gap(12.h),
          _statRow(tr.kudosStatsSecretBoxUnopenedLabel, '25'),
          Gap(12.h),
          Material(
            color: AppColors.accent,
            borderRadius: BorderRadius.circular(4.r),
            child: InkWell(
              onTap: main.onOpenSecretBoxTap,
              borderRadius: BorderRadius.circular(4.r),
              child: Container(
                height: 40.h,
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      tr.kudosOpenSecretBoxButton,
                      style: TextStyle(
                        color: AppColors.background,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Gap(8.w),
                    SvgPicture.asset(Assets.kudosGift, width: 24.sp),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _statRow(String label, String value) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 14.sp,
              fontWeight: FontWeight.w300,
              height: 20 / 14,
              letterSpacing: 0.25,
            ),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: AppColors.accent,
            fontSize: 14.sp,
            fontWeight: FontWeight.w700,
            height: 20 / 14,
            letterSpacing: 0.25,
          ),
        ),
      ],
    );
  }

  Widget _statRowWithIcon(String label, String value) {
    return Row(
      children: [
        Text(
          label,
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 14.sp,
            fontWeight: FontWeight.w300,
            height: 20 / 14,
            letterSpacing: 0.25,
          ),
        ),
        Spacer(),
        Image.asset(Assets.kudosX2, width: 24.sp),
        Spacer(),
        Text(
          value,
          style: TextStyle(
            color: AppColors.accent,
            fontSize: 14.sp,
            fontWeight: FontWeight.w700,
            height: 20 / 14,
            letterSpacing: 0.25,
          ),
        ),
      ],
    );
  }

  Widget _buildTopGiftReceivers() {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColors.containerDark,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AppColors.borderMuted, width: 0.794),
      ),
      child: Column(
        children: [
          Text(
            tr.kudosTopGiftReceiversTitle,
            style: TextStyle(
              color: AppColors.accent,
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
              height: 20 / 14,
            ),
            textAlign: TextAlign.center,
          ),
          Gap(12.7.h),
          ...List.generate(
            3,
            (i) => Padding(
              padding: EdgeInsets.only(bottom: i < 2 ? 12.7.h : 0),
              child: Row(
                children: [
                  Container(
                    width: 32.w,
                    height: 32.w,
                    decoration: BoxDecoration(
                      color: AppColors.gray,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.person, color: AppColors.textPrimary, size: 20.sp),
                  ),
                  Gap(6.35.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          tr.kudosTopGiftReceiverNamePlaceholder,
                          style: TextStyle(
                            color: AppColors.accent,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w700,
                            height: 20 / 14,
                          ),
                        ),
                        Gap(1.59.h),
                        Text(
                          tr.kudosTopGiftReceiverRewardPlaceholder,
                          style: TextStyle(
                            color: AppColors.textPrimary,
                            fontSize: 12.sp,
                            height: 16 / 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionHeader(String title, {bool showFilters = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            tr.kudosSectionEyebrow,
            style: TextStyle(color: AppColors.textMuted, fontSize: 12.sp),
          ),
          Gap(4.h),
          Container(height: 1, color: AppColors.divider),
          Gap(4.h),
          Text(
            title,
            style: TextStyle(
              color: AppColors.accent,
              fontSize: 22.sp,
              fontWeight: FontWeight.w500,
              height: 28 / 22,
            ),
          ),
          if (showFilters) ...[
            Gap(16.h),
            Wrap(
              spacing: 8.w,
              runSpacing: 8.h,
              children: [
                KudosFilterDropdown(
                  label: main.filterHashtag,
                  onTap: main.onFilterHashtagTap,
                  buttonKey: main.hashtagButtonKey,
                ),
                KudosFilterDropdown(
                  label: main.filterDepartment,
                  onTap: main.onFilterDepartmentTap,
                  buttonKey: main.departmentButtonKey,
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
