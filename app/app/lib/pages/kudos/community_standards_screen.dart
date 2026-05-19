import 'package:base_core/presenter/base_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:saa2025/generated/assets.dart';
import 'package:saa2025/pages/kudos/community_standards.dart';

/// Tiêu chuẩn cộng đồng — MoMorph `xms7csmDhD`.
class CommunityStandardsScreen extends BaseScreen<CommunityStandards> {
  CommunityStandardsScreen(super.main, super.context);

  static const Color _background = Color(0xFF00101A);
  static const Color _accent = Color(0xFFFFE99E);
  static const Color _cardBg = Color(0xFF0A1F2E);
  static const Color _textMuted = Color(0xB3FFFFFF);

  @override
  Widget screen() {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: _background,
        appBar: AppBar(
          backgroundColor: _background,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: main.onBack,
          ),
          title: Text(
            'Tiêu chuẩn',
            style: TextStyle(color: Colors.white, fontSize: 17.sp, fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
        ),
        body: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: 200.h,
              child: Image.asset(Assets.homeHomeBg, fit: BoxFit.cover),
            ),
            SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      height: 120.h,
                      decoration: BoxDecoration(
                        color: _cardBg,
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(color: const Color(0x33FFE99E)),
                      ),
                      alignment: Alignment.center,
                      child: SvgPicture.asset(
                        Assets.kudosKudosLogo,
                        width: 160.w,
                      ),
                    ),
                    Gap(24.h),
                    _section('Tiêu chuẩn cộng đồng', main.intro, main.communityRules),
                    Gap(16.h),
                    Divider(color: Colors.white.withValues(alpha: 0.15)),
                    Gap(16.h),
                    _section('Tiêu chuẩn bảo mật', null, main.privacyRules),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _section(String title, String? intro, List<String> bullets) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(color: _accent, fontSize: 18.sp, fontWeight: FontWeight.w800),
        ),
        if (intro != null) ...[
          Gap(12.h),
          Text(intro, style: TextStyle(color: Colors.white, fontSize: 14.sp, height: 1.5)),
        ],
        Gap(12.h),
        ...bullets.map(
          (rule) => Padding(
            padding: EdgeInsets.only(bottom: 10.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 6.h),
                  width: 6.w,
                  height: 6.w,
                  decoration: const BoxDecoration(color: _accent, shape: BoxShape.circle),
                ),
                Gap(10.w),
                Expanded(
                  child: Text(
                    rule,
                    style: TextStyle(color: _textMuted, fontSize: 14.sp, height: 1.45),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
