import 'package:base_core/presenter/base_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:saa2025/generated/assets.dart';
import 'package:saa2025/pages/home/home_styles.dart';
import 'package:saa2025/pages/kudos/kudos_models.dart';
import 'package:saa2025/pages/kudos/sunner_profile.dart';
import 'package:saa2025/pages/kudos/widgets/kudos_highlight_card.dart';
import 'package:saa2025/pages/kudos/widgets/kudos_option_sheet.dart';
import 'package:saa2025/theme/saa_design_tokens.dart';

class SunnerProfileScreen extends BaseScreen<SunnerProfilePage> {
  SunnerProfileScreen(super.main, super.context);

  static const Color _background = SaaDesignTokens.background;
  static const Color _primaryGold = Color(0xFFFFEA9E);
  static const Color _textWhite = Colors.white;
  static const Color _textGray = Color(0xFF999999);
  static const Color _containerBg = Color(0xFF00070C);
  static const Color _border = Color(0xFF998C5F);
  static const Color _divider = Color(0xFF2E3940);

  final GlobalKey _dropdownButtonKey = GlobalKey();

  @override
  Widget screen() {
    final p = main.profile;
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: _background,
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
                  colors: [
                    Color(0xFF00101A),
                    Color(0xFF00101A),
                    Color(0x0000101A),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: _buildHeader(),
            ),
            // Content
            if (!main.isLoading)
              Positioned.fill(
                top: 80.h,
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(bottom: 88.h),
                  child: Column(
                    children: [
                      Gap(40.h),
                      _buildMemberSection(p),
                      Gap(24.h),
                      _buildIconCollection(p),
                      Gap(12.h),
                      _buildDetailedStats(p),
                      Gap(40.h),
                      _buildKudosSection(),
                    ],
                  ),
                ),
              ),
            if (main.isLoading) const Center(child: CircularProgressIndicator(color: Color(0xFFFFEA9E))),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: const [0.0, 0.764, 0.846, 0.887, 0.928, 0.964, 1.0],
          colors: [
            _background,
            _background.withValues(alpha: 0.3),
            _background.withValues(alpha: 0.2),
            _background.withValues(alpha: 0.15),
            _background.withValues(alpha: 0.1),
            _background.withValues(alpha: 0.05),
            _background.withValues(alpha: 0),
          ],
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            SizedBox(height: 12.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(Assets.homeHomeLogo, height: 44.h),
                  Row(
                    children: [
                      _buildLanguageChip(),
                      Gap(10.w),
                      Icon(Icons.search, color: _textWhite, size: 24.sp),
                      Gap(10.w),
                      Stack(
                        children: [
                          Icon(Icons.notifications_outlined, color: _textWhite, size: 24.sp),
                          Positioned(
                            right: 0,
                            top: 0,
                            child: Container(
                              width: 8.w,
                              height: 8.h,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFFD4271D),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
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

  Widget _buildMemberSection(SunnerProfile p) {
    return Column(
      children: [
        Container(
          width: 72.w,
          height: 72.h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xFF1A3A4A),
            image: p.avatarAsset != null ? DecorationImage(image: AssetImage(p.avatarAsset!), fit: BoxFit.cover) : null,
          ),
          child: p.avatarAsset == null
              ? Center(child: Text(p.name[0], style: TextStyle(color: _primaryGold, fontSize: 32.sp)))
              : null,
        ),
        Gap(24.h),
        Text(
          p.name,
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            color: _primaryGold,
            height: 24 / 18,
          ),
        ),
        Gap(4.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${p.employeeCode ?? 'CEVC3'}  ',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: _textWhite,
                height: 20 / 14,
                letterSpacing: 0.25,
              ),
            ),
            Container(
              width: 1.911.w,
              height: 1.911.h,
              decoration: const BoxDecoration(shape: BoxShape.circle, color: _textGray),
            ),
            Gap(4.w),
            _honorBadge(p.heroTitle ?? 'Rising Hero'),
          ],
        ),
      ],
    );
  }

  Widget _honorBadge(String title) {
    final isRising = title.contains('Rising');
    return Container(
      height: 12.h,
      padding: EdgeInsets.symmetric(horizontal: 6.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22.217.r),
        border: Border.all(color: _primaryGold, width: 0.309),
        gradient: LinearGradient(
          colors: [
            const Color(0xFF092432).withValues(alpha: 0.5),
            const Color(0xFF092432).withValues(alpha: 0.5),
          ],
        ),
      ),
      child: Center(
        child: Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: isRising ? 'Rising ' : 'Legend ',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 6.sp,
                  fontWeight: FontWeight.w700,
                  color: isRising ? const Color(0xFFCDFF60) : _primaryGold,
                  height: 10.019 / 6,
                  letterSpacing: 0.0376,
                  shadows: [const Shadow(color: Colors.black, offset: Offset(0, 0.238), blurRadius: 0.952)],
                ),
              ),
              TextSpan(
                text: 'Hero',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 6.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  height: 10.019 / 6,
                  letterSpacing: 0.0376,
                  shadows: [const Shadow(color: Colors.black, offset: Offset(0, 0.238), blurRadius: 0.952)],
                ),
              ),
            ],
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildIconCollection(SunnerProfile p) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              6,
              (i) => Padding(
                padding: EdgeInsets.only(right: i < 5 ? 14.w : 0),
                child: Container(
                  width: 32.w,
                  height: 32.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFF323231),
                    border: Border.all(color: _textWhite, width: 0.956),
                  ),
                ),
              ),
            ),
          ),
          Gap(12.h),
          Text(
            'Bộ sưu tập icon của tôi',
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: _textWhite,
              height: 16 / 12,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildDetailedStats(SunnerProfile p) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: _containerBg,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: _border, width: 0.794),
      ),
      child: Column(
        children: [
          _statRow('Số Kudos bạn nhận được:', '${p.kudosReceived}'),
          Gap(12.h),
          _statRow('Số Kudos bạn đã gửi:', '${p.kudosSent}'),
          Gap(12.h),
          _statRow('Số tim bạn nhận được:', '25'),
          Gap(12.h),
          Container(height: 0.794.h, color: _divider),
          Gap(12.h),
          _statRow('Số Secret Box bạn đã mở:', '25'),
          Gap(12.h),
          _statRow('Số Secret Box chưa mở:', '25'),
          Gap(12.h),
          Container(
            height: 40.h,
            decoration: BoxDecoration(
              color: _primaryGold,
              borderRadius: BorderRadius.circular(4.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Mở Secret Box',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: _background,
                    height: 20 / 14,
                  ),
                ),
                Gap(8.w),
                SvgPicture.asset(Assets.kudosGift, width: 24.sp),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _statRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 14.sp,
            fontWeight: FontWeight.w300,
            color: _textWhite,
            height: 20 / 14,
            letterSpacing: 0.25,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 14.sp,
            fontWeight: FontWeight.w700,
            color: _primaryGold,
            height: 20 / 14,
            letterSpacing: 0.25,
          ),
        ),
      ],
    );
  }

  Widget _buildKudosSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Sun* Annual Awards 2025',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: _textWhite,
                  height: 16 / 12,
                ),
              ),
              Gap(4.h),
              Container(height: 1, color: const Color(0xFF2E3940)),
              Gap(4.h),
              Text(
                'KUDOS',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w500,
                  color: _primaryGold,
                  height: 28 / 22,
                ),
              ),
              Gap(12.h),
              _buildDropdownFilter(),
            ],
          ),
        ),
        Gap(24.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: main.kudosList.isEmpty
              ? Padding(
                  padding: EdgeInsets.all(24.w),
                  child: Center(
                    child: Text(
                      'Chưa có Kudos',
                      style: TextStyle(color: _textGray, fontSize: 14.sp),
                    ),
                  ),
                )
              : Column(
                  children: main.kudosList
                      .map(
                        (item) => Padding(
                          padding: EdgeInsets.only(bottom: 24.h, left: 24, right: 24),
                          child: KudosHighlightCard(
                            item: item,
                            width: double.infinity,
                            onTap: () => main.onKudoTap(item),
                          ),
                        ),
                      )
                      .toList(),
                ),
        ),
      ],
    );
  }

  Widget _buildDropdownFilter() {
    final currentLabel = main.kudosFilter == 'sent' 
        ? 'Đã gửi (${main.sentCount})' 
        : 'Đã nhận (${main.receivedCount})';
    
    return InkWell(
      key: _dropdownButtonKey,
      onTap: _onDropdownTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: const Color(0x1AFFEA9E),
          borderRadius: BorderRadius.circular(4.r),
          border: Border.all(color: _border, width: 1),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              currentLabel,
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: _textWhite,
                height: 20 / 14,
                letterSpacing: 0.25,
              ),
            ),
            Gap(8.w),
            Icon(Icons.keyboard_arrow_down, color: _textWhite, size: 24.sp),
          ],
        ),
      ),
    );
  }

  Future<void> _onDropdownTap() async {
    final sentLabel = 'Đã gửi (${main.sentCount})';
    final receivedLabel = 'Đã nhận (${main.receivedCount})';
    final currentLabel = main.kudosFilter == 'sent' ? sentLabel : receivedLabel;
    
    final result = await showKudosDropdown(
      context: context,
      buttonKey: _dropdownButtonKey,
      options: [receivedLabel, sentLabel],
      selected: currentLabel,
    );
    
    if (result != null && mounted) {
      final newFilter = result.startsWith('Đã gửi') ? 'sent' : 'received';
      main.onFilterChange(newFilter);
    }
  }
}
