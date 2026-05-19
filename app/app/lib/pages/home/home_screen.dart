import 'package:base_core/common/base_const.dart';
import 'package:base_core/presenter/base_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:saa2025/generated/assets.dart';
import 'package:saa2025/pages/home/home.dart';
import 'package:saa2025/pages/home/home_models.dart';
import 'package:saa2025/theme/saa_design_tokens.dart';

/// SAA 2025 home — MoMorph screen `OuH1BUTYT0` ([iOS] Home).
class HomeScreen extends BaseScreen<Home> {
  HomeScreen(super.main, super.context);

  static const Color _background = SaaDesignTokens.background;
  static const Color _accent = SaaDesignTokens.accent;
  static const Color _textOnDark = SaaDesignTokens.textOnDark;

  static const LinearGradient _headerGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF00101A),
      Color(0x4D00101A),
      Color(0x3300101A),
      Color(0x0000101A),
    ],
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
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(child: _buildHeader()),
        SliverToBoxAdapter(
          child: Stack(
            children: [
              Image.asset(Assets.homeHomeBg, width: double.infinity, fit: BoxFit.cover),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Gap(8.h),
                    Image.asset(Assets.homeHomeRootFurther, width: 247.w, fit: BoxFit.contain),
                    Gap(16.h),
                    _buildCountdownSection(),
                    Gap(16.h),
                    _buildHeroActions(),
                    Gap(32.h),
                    _buildThemeNote(),
                    Gap(32.h),
                    _buildAwardsSection(),
                    Gap(32.h),
                    _buildKudosSection(),
                    Gap(100.h),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
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
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _vnFlag(),
            Gap(4.w),
            Text(
              main.languageCode,
              style: TextStyle(
                fontFamily: BaseConst.fontMedium,
                fontSize: 14.sp,
                color: _textOnDark,
              ),
            ),
            SvgPicture.asset(
              Assets.commonIcDown,
              width: 20.w,
              height: 20.h,
              colorFilter: const ColorFilter.mode(_textOnDark, BlendMode.srcIn),
            ),
          ],
        ),
      ),
    );
  }

  Widget _vnFlag() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(2.r),
      child: SizedBox(
        width: 24.w,
        height: 16.h,
        child: Column(
          children: [
            Expanded(child: Container(color: const Color(0xFFDA251D))),
            Expanded(child: Container(color: const Color(0xFFFFD700))),
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
              decoration: const BoxDecoration(color: Color(0xFFFF5247), shape: BoxShape.circle),
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
          colorFilter: const ColorFilter.mode(_textOnDark, BlendMode.srcIn),
        ),
      ),
    );
  }

  Widget _buildCountdownSection() {
    final c = main.countdown;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Coming soon',
          style: TextStyle(
            fontFamily: BaseConst.fontSemiBold,
            fontSize: 16.sp,
            color: _accent,
          ),
        ),
        Gap(12.h),
        Row(
          children: [
            _countdownUnit(c.days, 'DAYS'),
            Gap(8.w),
            _countdownUnit(c.hours, 'HOURS'),
            Gap(8.w),
            _countdownUnit(c.minutes, 'MINUTES'),
          ],
        ),
        Gap(16.h),
        _infoRow('Thời gian: ', '26/12/2025'),
        Gap(8.h),
        _infoRow('Địa điểm:', 'Âu Cơ Art Center'),
        Gap(8.h),
        Text(
          'Tường thuật trực tiếp tại Group Facebook Sun* Family',
          style: TextStyle(
            fontFamily: BaseConst.fontLight,
            fontSize: 12.sp,
            height: 16 / 12,
            color: _textOnDark.withValues(alpha: 0.85),
          ),
        ),
      ],
    );
  }

  Widget _countdownUnit(int value, String label) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(4.r),
          border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
        ),
        child: Column(
          children: [
            Text(
              value.toString().padLeft(2, '0'),
              style: TextStyle(
                fontFamily: BaseConst.fontSemiBold,
                fontSize: 20.sp,
                color: _accent,
              ),
            ),
            Gap(4.h),
            Text(
              label,
              style: TextStyle(
                fontFamily: BaseConst.fontMedium,
                fontSize: 10.sp,
                color: _textOnDark.withValues(alpha: 0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          fontFamily: BaseConst.fontRegular,
          fontSize: 14.sp,
          height: 20 / 14,
          color: _textOnDark,
        ),
        children: [
          TextSpan(
            text: label,
            style: TextStyle(color: _textOnDark.withValues(alpha: 0.7)),
          ),
          TextSpan(text: value),
        ],
      ),
    );
  }

  Widget _buildHeroActions() {
    return Column(
      children: [
        _yellowButton('ABOUT AWARD', main.onAboutAwardTap),
        Gap(12.h),
        _outlineButton('ABOUT KUDOS', main.onAboutKudosTap),
      ],
    );
  }

  Widget _yellowButton(String label, VoidCallback onTap) {
    return Material(
      color: _accent,
      borderRadius: BorderRadius.circular(4.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(4.r),
        child: SizedBox(
          width: double.infinity,
          height: 40.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontFamily: BaseConst.fontMedium,
                  fontSize: 14.sp,
                  color: _background,
                ),
              ),
              Gap(8.w),
              SvgPicture.asset(Assets.homeHomeIcArrow, width: 20.w, height: 20.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _outlineButton(String label, VoidCallback onTap) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(4.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(4.r),
        child: Container(
          width: double.infinity,
          height: 40.h,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.r),
            border: Border.all(color: _textOnDark.withValues(alpha: 0.4)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontFamily: BaseConst.fontMedium,
                  fontSize: 14.sp,
                  color: _textOnDark,
                ),
              ),
              Gap(8.w),
              SvgPicture.asset(
                Assets.homeHomeIcArrow,
                width: 20.w,
                height: 20.h,
                colorFilter: const ColorFilter.mode(_textOnDark, BlendMode.srcIn),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildThemeNote() {
    return Text(
      main.themeNote,
      style: TextStyle(
        fontFamily: BaseConst.fontLight,
        fontSize: 13.sp,
        height: 20 / 13,
        letterSpacing: 0.25,
        color: _textOnDark.withValues(alpha: 0.9),
      ),
    );
  }

  Widget _buildAwardsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader('Sun* Annual Awards 2025', 'Hệ thống giải thưởng'),
        Gap(16.h),
        SizedBox(
          height: 220.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: main.awards.length,
            separatorBuilder: (_, __) => Gap(12.w),
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
        Text(
          eyebrow,
          style: TextStyle(
            fontFamily: BaseConst.fontMedium,
            fontSize: 12.sp,
            color: _accent,
          ),
        ),
        Gap(4.h),
        Text(
          title,
          style: TextStyle(
            fontFamily: BaseConst.fontSemiBold,
            fontSize: 20.sp,
            color: _textOnDark,
          ),
        ),
      ],
    );
  }

  Widget _awardCard(HomeAwardItem item, VoidCallback onDetail) {
    return Container(
      width: 280.w,
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(4.r),
            child: Image.asset(item.imageAsset, height: 72.h, width: double.infinity, fit: BoxFit.cover),
          ),
          Gap(8.h),
          Text(
            item.title,
            style: TextStyle(
              fontFamily: BaseConst.fontSemiBold,
              fontSize: 16.sp,
              color: _textOnDark,
            ),
          ),
          Gap(4.h),
          Expanded(
            child: Text(
              item.description,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontFamily: BaseConst.fontLight,
                fontSize: 12.sp,
                height: 16 / 12,
                color: _textOnDark.withValues(alpha: 0.75),
              ),
            ),
          ),
          Gap(8.h),
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton(
              onPressed: onDetail,
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Chi tiết',
                    style: TextStyle(
                      fontFamily: BaseConst.fontMedium,
                      fontSize: 14.sp,
                      color: _accent,
                    ),
                  ),
                  Gap(4.w),
                  SvgPicture.asset(Assets.homeHomeIcArrow, width: 16.w, height: 16.h),
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
        Gap(16.h),
        ClipRRect(
          borderRadius: BorderRadius.circular(8.r),
          child: Image.asset(Assets.homeHomeKudosBanner, width: double.infinity, fit: BoxFit.cover),
        ),
        Gap(16.h),
        Text(
          'ĐIỂM MỚI CỦA SAA 2025',
          style: TextStyle(
            fontFamily: BaseConst.fontSemiBold,
            fontSize: 12.sp,
            color: _accent,
          ),
        ),
        Gap(8.h),
        Text(
          main.kudosNote,
          style: TextStyle(
            fontFamily: BaseConst.fontLight,
            fontSize: 13.sp,
            height: 20 / 13,
            color: _textOnDark.withValues(alpha: 0.9),
          ),
        ),
        Gap(16.h),
        _yellowButton('Chi tiết', main.onKudosDetailTap),
      ],
    );
  }

  Widget _buildFab() {
    return Positioned(
      right: 16.w,
      bottom: 24.h,
      child: Material(
        elevation: 8,
        borderRadius: BorderRadius.circular(28.r),
        color: _accent,
        child: InkWell(
          onTap: main.onFabKudosTap,
          borderRadius: BorderRadius.circular(28.r),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.edit, size: 20.sp, color: _background),
                Gap(8.w),
                Text(
                  'Kudos',
                  style: TextStyle(
                    fontFamily: BaseConst.fontSemiBold,
                    fontSize: 14.sp,
                    color: _background,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
