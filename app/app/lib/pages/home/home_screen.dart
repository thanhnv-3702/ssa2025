import 'dart:ui';

import 'package:base_core/presenter/base_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:saa2025/generated/assets.dart';
import 'package:saa2025/pages/home/home.dart';
import 'package:saa2025/pages/home/home_models.dart';
import 'package:saa2025/pages/home/home_styles.dart';

/// SAA 2025 home — MoMorph `OuH1BUTYT0` / Figma `6885:8978` ([iOS] Home).
class HomeScreen extends BaseScreen<Home> {
  HomeScreen(super.main, super.context);

  /// Figma `6885:9057` — fades to fully transparent; layer opacity 0.9.
  static const LinearGradient _headerGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF00101A),
      Color(0x4D00101A),
      Color(0x3300101A),
      Color(0x2600101A),
      Color(0x1A00101A),
      Color(0x0D00101A),
      Color(0x0000101A),
    ],
    stops: [0.0, 0.7644, 0.8462, 0.887, 0.9279, 0.9639, 1.0],
  );

  static const double _headerHeight = 104;
  static const double _headerMarginBottom = 40;

  @override
  Widget screen() {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: HomeStyles.background,
        body: Stack(
          children: [
            _buildScrollBody(),
            _buildFab(),
          ],
        ),
      ),
    );
  }

  Widget _buildScrollBody() {
    final contentTop = (_headerHeight + _headerMarginBottom).h;
    return Stack(
      children: [
        Image.asset(Assets.homeHomeBg, width: double.infinity, fit: BoxFit.cover),
        Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF00101A),
                Color(0xFF00101A),
                Color(0x0000101A),
              ],
            ),
          ),
        ),
        CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(20.w, contentTop, 20.w, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(Assets.homeHomeRootFurther, width: 247.w, fit: BoxFit.contain),
                    Gap(32.h),
                    _buildHeroBlock(),
                    Gap(32.h),
                    Text(main.themeNote, style: HomeStyles.bodyLight),
                    Gap(32.h),
                    _buildAwardsSection(),
                    Gap(32.h),
                    _buildKudosSection(),
                    Gap(100.h),
                  ],
                ),
              ),
            ),
          ],
        ),
        Positioned(top: 0, left: 0, right: 0, child: _buildHeader()),
      ],
    );
  }

  /// Figma `mms_1_header` — overlays hero; transparent gradient, 40px gap before content.
  Widget _buildHeader() {
    return SizedBox(
      height: _headerHeight.h,
      child: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.9,
              child: const DecoratedBox(decoration: BoxDecoration(gradient: _headerGradient)),
            ),
          ),
          Positioned(left: 20.w, bottom: 8.h, child: Image.asset(Assets.homeHomeLogo, width: 48.w, height: 44.h)),
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
              colorFilter: const ColorFilter.mode(HomeStyles.textPrimary, BlendMode.srcIn),
            ),
          ],
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
            right: 6.w,
            top: 6.h,
            child: Container(
              width: 8.w,
              height: 8.h,
              decoration: const BoxDecoration(color: HomeStyles.notificationDot, shape: BoxShape.circle),
            ),
          ),
      ],
    );
  }

  Widget _iconButton(String asset, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8.r),
      child: Padding(
        padding: EdgeInsets.all(8.w),
        child: SvgPicture.asset(
          asset,
          width: 24.w,
          height: 24.h,
          colorFilter: const ColorFilter.mode(HomeStyles.textPrimary, BlendMode.srcIn),
        ),
      ),
    );
  }

  Widget _buildHeroBlock() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildCountdownSection(),
        Gap(24.h),
        _buildHeroActions(),
      ],
    );
  }

  Widget _buildCountdownSection() {
    final c = main.countdown;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Coming soon', style: HomeStyles.comingSoon),
        Gap(8.h),
        Row(
          children: [
            _countdownUnit(c.days, 'DAYS'),
            Gap(16.w),
            _countdownUnit(c.hours, 'HOURS'),
            Gap(16.w),
            _countdownUnit(c.minutes, 'MINUTES', wide: true),
          ],
        ),
        Gap(24.h),
        _infoRow('Thời gian: ', '26/12/2025'),
        Gap(8.h),
        _infoRow('Địa điểm:', 'Âu Cơ Art Center'),
        Gap(8.h),
        Text(
          'Tường thuật trực tiếp tại Group Facebook Sun* Family',
          style: HomeStyles.bodyLight,
        ),
      ],
    );
  }

  Widget _countdownUnit(int value, String label, {bool wide = false}) {
    final digits = value.toString().padLeft(2, '0').split('');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (var i = 0; i < digits.length; i++) ...[
              if (i > 0) Gap(8.w),
              _digitBox(digits[i]),
            ],
          ],
        ),
        Gap(4.h),
        SizedBox(
          width: wide ? 92.w : 72.w,
          child: Text(label, style: HomeStyles.countdownLabel),
        ),
      ],
    );
  }

  /// Figma `6885:8992` — glass digit cell behind `Digital Numbers` glyph.
  Widget _digitBox(String digit) {
    return SizedBox(
      width: 32.w,
      height: 56.h,
      child: Stack(
        alignment: Alignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 16.64, sigmaY: 16.64),
              child: Opacity(
                opacity: 0.5,
                child: Container(
                  width: 32.w,
                  height: 56.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(color: HomeStyles.accent, width: 0.5),
                    gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xFFFFFFFF), Color(0x1AFFFFFF)],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Text(digit, style: HomeStyles.countdownDigit),
        ],
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: HomeStyles.infoLabel),
        Gap(8.w),
        Flexible(child: Text(value, style: HomeStyles.infoValue)),
      ],
    );
  }

  Widget _buildHeroActions() {
    return Row(
      children: [
        Expanded(child: _filledButton('ABOUT AWARD', main.onAboutAwardTap)),
        Gap(16.w),
        Expanded(child: _outlineButton('ABOUT KUDOS', main.onAboutKudosTap)),
      ],
    );
  }

  Widget _filledButton(String label, VoidCallback onTap) {
    return Material(
      color: HomeStyles.accent,
      borderRadius: BorderRadius.circular(4.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(4.r),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  label,
                  style: HomeStyles.buttonLabel,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Gap(8.w),
              SvgPicture.asset(Assets.homeHomeIcArrow, width: 24.w, height: 24.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _outlineButton(String label, VoidCallback onTap) {
    return Material(
      color: HomeStyles.accentSurface10,
      borderRadius: BorderRadius.circular(4.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(4.r),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.r),
            border: Border.all(color: HomeStyles.borderMuted),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  label,
                  style: HomeStyles.buttonLabelOutline,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Gap(8.w),
              SvgPicture.asset(
                Assets.homeHomeIcArrow,
                width: 24.w,
                height: 24.h,
                colorFilter: const ColorFilter.mode(HomeStyles.textPrimary, BlendMode.srcIn),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAwardsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader('Sun* Annual Awards 2025', 'Hệ thống giải thưởng'),
        Gap(24.h),
        SizedBox(
          height: 298.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: main.awards.length,
            separatorBuilder: (_, __) => Gap(16.w),
            itemBuilder: (_, index) => _awardCard(main.awards[index], () => main.onAwardDetailTap(index)),
          ),
        ),
      ],
    );
  }

  Widget _sectionHeader(String eyebrow, String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(eyebrow, style: HomeStyles.sectionEyebrow),
        Gap(4.h),
        Container(height: 1, color: HomeStyles.divider),
        Gap(4.h),
        Text(title, style: HomeStyles.sectionTitle),
      ],
    );
  }

  Widget _awardCard(HomeAwardItem item, VoidCallback onDetail) {
    return SizedBox(
      width: 160.w,
      height: 298.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 160.w,
            height: 160.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(11.43.r),
              border: Border.all(color: HomeStyles.accent.withValues(alpha: 0.5), width: 0.5),
              boxShadow: const [
                BoxShadow(color: Color(0x40000000), blurRadius: 1.9, offset: Offset(0, 1.9)),
                BoxShadow(color: Color(0xFFFAE287), blurRadius: 2.86),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(11.43.r),
              child: Image.asset(item.imageAsset, fit: BoxFit.cover),
            ),
          ),
          Gap(12.h),
          Text(item.title, style: HomeStyles.awardTitle, maxLines: 1, overflow: TextOverflow.ellipsis),
          Gap(2.h),
          Expanded(
            child: Text(
              item.description,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: HomeStyles.bodyLight,
            ),
          ),
          Gap(12.h),
          SizedBox(
            height: 32.h,
            child: InkWell(
              onTap: onDetail,
              borderRadius: BorderRadius.circular(4.r),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Chi tiết', style: HomeStyles.linkLabel),
                  Gap(8.w),
                  SvgPicture.asset(
                    Assets.homeHomeIcArrow,
                    width: 24.w,
                    height: 24.h,
                    colorFilter: const ColorFilter.mode(HomeStyles.textPrimary, BlendMode.srcIn),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKudosSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader('Phong trào ghi nhận', 'Sun* Kudos'),
        Gap(24.h),
        ClipRRect(
          borderRadius: BorderRadius.circular(4.65.r),
          child: SizedBox(
            height: 145.h,
            width: double.infinity,
            child: Image.asset(Assets.homeHomeKudosBanner, fit: BoxFit.cover),
          ),
        ),
        Gap(16.h),
        Text.rich(
          TextSpan(
            style: HomeStyles.bodyLight,
            children: [
              TextSpan(text: 'ĐIỂM MỚI CỦA SAA 2025\n', style: HomeStyles.kudosNoteTitle),
              TextSpan(text: main.kudosNote),
            ],
          ),
        ),
        Gap(16.h),
        Align(
          alignment: Alignment.centerLeft,
          child: SizedBox(
            width: 160.w,
            child: _filledButton('Chi tiết', main.onKudosDetailTap),
          ),
        ),
      ],
    );
  }

  /// MoMorph `mms_6_float button` — Figma `6885:9058`.
  Widget _buildFab() {
    return Positioned(
      right: 20.w,
      bottom: 24.h,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: HomeStyles.accent,
          borderRadius: BorderRadius.circular(100.r),
          boxShadow: const [
            BoxShadow(color: Color(0x40000000), blurRadius: 4, offset: Offset(0, 4)),
            BoxShadow(color: Color(0xFFFAE287), blurRadius: 6),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: main.onFabWriteKudoTap,
                borderRadius: BorderRadius.circular(100.r),
                child: Padding(
                  padding: EdgeInsets.all(4.w),
                  child: SvgPicture.asset(Assets.kudosKudosPen, width: 24.w, height: 24.h),
                ),
              ),
              Gap(8.w),
              Text(
                '/',
                style: HomeStyles.countdownLabel.copyWith(
                  fontSize: 24.sp,
                  height: 32 / 24,
                  color: HomeStyles.background,
                ),
              ),
              Gap(8.w),
              InkWell(
                onTap: main.onFabKudosListTap,
                borderRadius: BorderRadius.circular(100.r),
                child: Padding(
                  padding: EdgeInsets.all(4.w),
                  child: SvgPicture.asset(Assets.kudosKudosLogo, width: 24.w, height: 24.h),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
