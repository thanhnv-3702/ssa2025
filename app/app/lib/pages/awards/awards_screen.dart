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
import 'package:saa2025/pages/utils/extension.dart';
import 'package:saa2025/theme/app_colors.dart';

/// Awards tab — iOS detail screen with dropdown selector (Figma `6885:10265`).
class AwardsScreen extends BaseScreen<Awards> {
  AwardsScreen(super.main, super.context);

  @override
  Widget screen() {
    final award = main.selectedAward;

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
                  const Divider(color: AppColors.divider, height: 1),
                  Gap(16.h),
                  AwardInfoBlocks.prizeQuantityBlock(tr, award),
                  Gap(16.h),
                  const Divider(color: AppColors.divider, height: 1),
                  Gap(16.h),
                  for (var i = 0; i < award.prizeValues.length; i++) ...[
                    if (i > 0) ...[
                      AwardInfoBlocks.orDivider(tr),
                      Gap(8.h),
                    ],
                    AwardInfoBlocks.prizeValueBlock(tr, award.prizeValues[i]),
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
                      decoration: const BoxDecoration(color: AppColors.notificationDot, shape: BoxShape.circle),
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
            AppColors.textPrimary,
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
        Text(tr.awardsRecognitionSystemEyebrow, style: HomeStyles.sectionEyebrow),
        Gap(8.h),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(Assets.kudosKudosLogo, width: 30.w, height: 39.h),
            Gap(8.w),
            Text(tr.awardsKudosBrand, style: HomeStyles.sectionTitle.copyWith(fontSize: 39.sp)),
          ],
        ),
        Gap(16.h),
        Text(tr.awardsEventEyebrow, style: HomeStyles.sectionEyebrow),
        Gap(4.h),
        Container(height: 1, color: AppColors.divider),
        Gap(4.h),
        Text(tr.awardsSystemTitle, style: HomeStyles.sectionTitle),
      ],
    );
  }

  Widget _buildAwardDropdown() {
    return Container(
      width: 160,
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: AppColors.accentSurface10,
        border: Border.all(color: AppColors.borderMuted),
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
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            Icon(Icons.keyboard_arrow_down, color: AppColors.textPrimary, size: 24.sp),
          ],
        ),
      ),
    );
  }

  Widget _buildKudosPromo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(tr.awardsKudosMovementEyebrow, style: HomeStyles.sectionEyebrow),
        Gap(4.h),
        Container(height: 1, color: AppColors.divider),
        Gap(4.h),
        Text(tr.awardsKudosTitle, style: HomeStyles.sectionTitle),
      ],
    );
  }
}
