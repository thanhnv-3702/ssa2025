import 'package:base_core/presenter/base_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:saa2025/generated/assets.dart';
import 'package:saa2025/pages/kudos/kudos.dart';
import 'package:saa2025/pages/kudos/kudos_mock_data.dart';
import 'package:saa2025/pages/kudos/kudos_models.dart';
import 'package:saa2025/pages/kudos/widgets/kudos_filter_dropdown.dart';
import 'package:saa2025/pages/kudos/widgets/kudos_highlight_card.dart';
import 'package:saa2025/theme/saa_design_tokens.dart';

/// Sun* Kudos hub — MoMorph screen `fO0Kt19sZZ` ([iOS] Sun*Kudos).
class KudosScreen extends BaseScreen<Kudos> {
  KudosScreen(super.main, super.context);

  static const Color _background = SaaDesignTokens.background;
  static const Color _accent = SaaDesignTokens.accent;
  static const Color _textMuted = Color(0xB3FFFFFF);

  static const LinearGradient _headerGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF00101A), Color(0x4D00101A), Color(0x3300101A), Color(0x0000101A)],
    stops: [0.0, 0.76, 0.88, 1.0],
  );

  @override
  Widget screen() {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: _background,
        body: CustomScrollView(
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
      ),
    );
  }

  Widget _buildHeader() {
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
          Positioned(left: 20.w, bottom: 8.h, child: Image.asset(Assets.homeHomeHeaderLogo, width: 48.w, height: 44.h)),
          Positioned(
            right: 12.w,
            bottom: 8.h,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _languageChip(),
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

  Widget _languageChip() {
    return InkWell(
      onTap: main.onLanguageTap,
      borderRadius: BorderRadius.circular(20.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(main.languageCode, style: TextStyle(color: Colors.white, fontSize: 12.sp, fontWeight: FontWeight.w600)),
            Gap(4.w),
            Icon(Icons.keyboard_arrow_down, color: Colors.white, size: 16.sp),
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
        _iconButton(Assets.homeHomeIcNotification, main.onNotificationTap),
        if (main.hasUnreadNotifications)
          Positioned(
            top: 6.h,
            right: 6.w,
            child: Container(
              width: 8.w,
              height: 8.w,
              decoration: const BoxDecoration(color: Color(0xFFE53935), shape: BoxShape.circle),
            ),
          ),
      ],
    );
  }

  Widget _buildHero() {
    return Stack(
      children: [
        Image.asset(Assets.homeHomeBg, width: double.infinity, fit: BoxFit.cover),
        Padding(
          padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hệ thống ghi nhận và cảm ơn',
                style: TextStyle(color: _textMuted, fontSize: 14.sp),
              ),
              Gap(12.h),
              SvgPicture.asset(Assets.kudosKudosLogo, width: 200.w),
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
        color: _accent,
        borderRadius: BorderRadius.circular(28.r),
        child: InkWell(
          onTap: main.onSendKudoTap,
          borderRadius: BorderRadius.circular(28.r),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
            child: Row(
              children: [
                SvgPicture.asset(Assets.kudosKudosPen, width: 20.w, height: 20.w),
                Gap(12.w),
                Expanded(
                  child: Text(
                    'Hôm nay, bạn muốn gửi kudos đến ai?',
                    style: TextStyle(color: _background, fontSize: 14.sp, fontWeight: FontWeight.w600),
                  ),
                ),
                Icon(Icons.chevron_right, color: _background, size: 24.sp),
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
          _sectionHeader('HIGHLIGHT', showFilters: true),
          Gap(16.h),
          SizedBox(
            height: 280.h,
            child: PageView.builder(
              controller: main.highlightController,
              itemCount: main.highlightPageCount,
              onPageChanged: main.onHighlightPageChanged,
              itemBuilder: (_, i) {
                if (main.highlights.isEmpty) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Center(
                      child: Text(
                        'Không có Kudos phù hợp bộ lọc',
                        style: TextStyle(color: _textMuted, fontSize: 14.sp),
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
            '$current/$total',
            style: TextStyle(color: _accent, fontSize: 14.sp, fontWeight: FontWeight.w600),
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
      child: Icon(icon, color: enabled ? _accent : _textMuted, size: 28.sp),
    );
  }

  Widget _buildSpotlightSection() {
    return Padding(
      padding: EdgeInsets.only(top: 32.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionHeader('SPOTLIGHT BOARD'),
          Gap(16.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF0A2A3A), Color(0xFF00101A)],
                ),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: const Color(0x33FFE99E)),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                        decoration: BoxDecoration(
                          color: _accent,
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        child: Text(
                          '${main.stats.totalKudos} KUDOS',
                          style: TextStyle(
                            color: _background,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: main.onSpotlightSearchTap,
                        child: Text(
                          'Tìm kiếm Sunner',
                          style: TextStyle(
                            color: _accent,
                            fontSize: 12.sp,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Gap(16.h),
                  Wrap(
                    spacing: 8.w,
                    runSpacing: 8.h,
                    children: main.filteredSpotlight
                        .map(
                          (e) {
                            SunnerProfile? sunner;
                            for (final s in KudosMockData.sunners) {
                              if (s.name == e.name) {
                                sunner = s;
                                break;
                              }
                            }
                            return ActionChip(
                              label: Text(
                                '${e.name} (${e.kudosCount})',
                                style: TextStyle(color: Colors.white, fontSize: 11.sp),
                              ),
                              backgroundColor: const Color(0xFF1A3A4A),
                              side: BorderSide(color: _accent.withValues(alpha: 0.3)),
                              onPressed: sunner != null
                                  ? () => main.onSpotlightSunnerTap(sunner!)
                                  : null,
                            );
                          },
                        )
                        .toList(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAllKudosSection() {
    return Padding(
      padding: EdgeInsets.only(top: 32.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionHeader('ALL KUDOS'),
          Gap(16.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: _buildStatsRow(),
          ),
          Gap(16.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: main.allKudos
                  .take(3)
                  .map(
                    (item) => KudosListTileCard(
                      item: item,
                      onTap: () => main.onKudoTap(item),
                    ),
                  )
                  .toList(),
            ),
          ),
          Gap(8.h),
          Center(
            child: TextButton(
              onPressed: main.onViewAllKudosTap,
              child: Text(
                'Xem thêm',
                style: TextStyle(color: _accent, fontSize: 14.sp, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsRow() {
    final s = main.stats;
    return Row(
      children: [
        Expanded(child: _statBox('${s.totalKudos}', 'Kudos')),
        Gap(8.w),
        Expanded(child: _statBox('${s.totalReceivers}', 'Người nhận')),
        Gap(8.w),
        Expanded(child: _statBox('${s.totalSenders}', 'Người gửi')),
      ],
    );
  }

  Widget _statBox(String value, String label) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      decoration: BoxDecoration(
        color: const Color(0xFF0A1F2E),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: const Color(0x33FFE99E)),
      ),
      child: Column(
        children: [
          Text(value, style: TextStyle(color: _accent, fontSize: 18.sp, fontWeight: FontWeight.w800)),
          Gap(4.h),
          Text(label, style: TextStyle(color: _textMuted, fontSize: 11.sp)),
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
            'Sun* Annual Awards 2025',
            style: TextStyle(color: _textMuted, fontSize: 11.sp),
          ),
          Gap(4.h),
          Row(
            children: [
              Container(width: 4.w, height: 20.h, color: _accent),
              Gap(8.w),
              Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
          if (showFilters) ...[
            Gap(12.h),
            Wrap(
              spacing: 8.w,
              runSpacing: 8.h,
              children: [
                KudosFilterDropdown(label: main.filterPeriod, onTap: main.onFilterPeriodTap),
                KudosFilterDropdown(label: main.filterHashtag, onTap: main.onFilterHashtagTap),
                KudosFilterDropdown(label: main.filterDepartment, onTap: main.onFilterDepartmentTap),
              ],
            ),
          ],
        ],
      ),
    );
  }

}
