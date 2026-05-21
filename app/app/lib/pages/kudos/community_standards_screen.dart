import 'package:base_core/presenter/base_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:saa2025/generated/assets.dart';
import 'package:saa2025/pages/kudos/community_standards.dart';
import 'package:saa2025/pages/utils/extension.dart';
import 'package:saa2025/theme/app_colors.dart';

/// Tiêu chuẩn cộng đồng — MoMorph `xms7csmDhD`.
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
        appBar: AppBar(
          backgroundColor: AppColors.background,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: AppColors.textPrimary),
            onPressed: main.onBack,
          ),
          title: Text(
            tr.communityStandardsTitle,
            style: TextStyle(color: AppColors.textPrimary, fontSize: 17.sp, fontWeight: FontWeight.w600),
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
                        color: AppColors.kudosCardBackground,
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(color: AppColors.accentBorder20),
                      ),
                      alignment: Alignment.center,
                      child: SvgPicture.asset(
                        Assets.kudosKudosLogo,
                        width: 160.w,
                      ),
                    ),
                    Gap(24.h),
                    _section(tr.communityStandardsSectionTitle, main.intro, main.communityRules),
                    Gap(16.h),
                    Divider(color: AppColors.white15),
                    Gap(16.h),
                    _section(tr.privacyStandardsSectionTitle, null, main.privacyRules),
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
          style: TextStyle(color: AppColors.accent, fontSize: 18.sp, fontWeight: FontWeight.w800),
        ),
        if (intro != null) ...[
          Gap(12.h),
          Text(intro, style: TextStyle(color: AppColors.textPrimary, fontSize: 14.sp, height: 1.5)),
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
                  decoration: const BoxDecoration(color: AppColors.accent, shape: BoxShape.circle),
                ),
                Gap(10.w),
                Expanded(
                  child: Text(
                    rule,
                    style: TextStyle(color: AppColors.textMuted, fontSize: 14.sp, height: 1.45),
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
