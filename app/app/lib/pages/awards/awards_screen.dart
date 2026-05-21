import 'package:base_core/presenter/base_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:saa2025/generated/assets.dart';
import 'package:saa2025/pages/awards/awards.dart';
import 'package:saa2025/pages/awards/widgets/award_info_blocks.dart';
import 'package:saa2025/pages/awards/widgets/award_kudos_promo.dart';
import 'package:saa2025/pages/awards/widgets/award_picture_card.dart';
import 'package:saa2025/pages/home/home_styles.dart';

/// Awards tab — iOS detail screen with dropdown selector (Figma `6885:10265`).
class AwardsScreen extends BaseScreen<Awards> {
  AwardsScreen(super.main, super.context);

  @override
  Widget screen() {
    final award = main.selectedAward;

    return AnnotatedRegion(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: HomeStyles.background,
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
            SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(20.w, 56.h, 20.w, 100.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  Gap(24.h),
                  _buildPageTitle(),
                  Gap(16.h),
                  _buildAwardDropdown(),
                  Gap(24.h),
                  Center(
                    child: AwardPictureCard(
                      imageAsset: award.imageAsset,
                      title: award.title,
                      size: 200,
                    ),
                  ),
                  Gap(24.h),
                  AwardInfoBlocks.descriptionBlock(
                    title: award.displayTitle,
                    description: award.longDescription,
                  ),
                  Gap(16.h),
                  const Divider(color: HomeStyles.divider, height: 1),
                  Gap(16.h),
                  AwardInfoBlocks.prizeQuantityBlock(award),
                  Gap(16.h),
                  const Divider(color: HomeStyles.divider, height: 1),
                  Gap(16.h),
                  for (var i = 0; i < award.prizeValues.length; i++) ...[
                    if (i > 0) ...[
                      AwardInfoBlocks.orDivider(),
                      Gap(8.h),
                    ],
                    AwardInfoBlocks.prizeValueBlock(award.prizeValues[i]),
                  ],
                  Gap(32.h),
                  _buildKudosPromo(),
                  Gap(16.h),
                  AwardKudosPromo(onDetailTap: main.onKudosDetailTap),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset(Assets.homeHomeLogo, width: 48.w, height: 44.h),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _iconButton(Assets.homeHomeIcSearch, main.onSearchTap),
            Gap(8.w),
            Stack(
              alignment: Alignment.topRight,
              clipBehavior: Clip.none,
              children: [
                _iconButton(Assets.homeHomeIcNotification, main.onNotificationTap),
                if (main.hasUnreadNotifications)
                  Transform.translate(
                    offset: Offset(-4, 2),
                    child: Container(
                      width: 8.w,
                      height: 8.h,
                      decoration: const BoxDecoration(color: HomeStyles.notificationDot, shape: BoxShape.circle),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _iconButton(String asset, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Padding(
        padding: EdgeInsets.all(4.w),
        child: SvgPicture.asset(
          asset,
          colorFilter: ColorFilter.mode(
            Colors.white,
            BlendMode.srcIn,
          ),
          width: 24.w,
          height: 24.w,
        ),
      ),
    );
  }

  Widget _buildPageTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Hệ thống ghi nhận và cảm ơn', style: HomeStyles.sectionEyebrow),
        Gap(8.h),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(Assets.kudosKudosLogo, width: 30.w, height: 39.h),
            Gap(8.w),
            Text('KUDOS', style: HomeStyles.sectionTitle.copyWith(fontSize: 39.sp)),
          ],
        ),
        Gap(16.h),
        Text('Sun* Annual Awards 2025', style: HomeStyles.sectionEyebrow),
        Gap(4.h),
        Container(height: 1, color: HomeStyles.divider),
        Gap(4.h),
        Text('Hệ thống giải thưởng\nSAA 2025', style: HomeStyles.sectionTitle),
      ],
    );
  }

  Widget _buildAwardDropdown() {
    return Container(
      width: 160,
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: HomeStyles.accentSurface10,
        border: Border.all(color: HomeStyles.borderMuted),
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: InkWell(
        onTap: main.onDropdownTap,
        borderRadius: BorderRadius.circular(4.r),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                main.selectedAward.title,
                style: TextStyle(
                  fontFamily: 'PlusJakartaSans-Regular',
                  fontSize: 14.sp,
                  height: 20 / 14,
                  letterSpacing: 0.25,
                  color: HomeStyles.textPrimary,
                ),
              ),
            ),
            Icon(Icons.keyboard_arrow_down, color: HomeStyles.textPrimary, size: 24.sp),
          ],
        ),
      ),
    );
  }

  Widget _buildKudosPromo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Phong trào ghi nhận', style: HomeStyles.sectionEyebrow),
        Gap(4.h),
        Container(height: 1, color: HomeStyles.divider),
        Gap(4.h),
        Text('Sun* Kudos', style: HomeStyles.sectionTitle),
      ],
    );
  }
}
