import 'package:base_core/common/base_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:saa2025/generated/app_localizations.dart';
import 'package:saa2025/pages/kudos/kudos_models.dart';
import 'package:saa2025/theme/app_colors.dart';

import '../../../generated/assets.dart';

/// Kudo highlight card — MoMorph `mms_B.3_KUDO - Highlight`.
class KudosHighlightCard extends StatelessWidget {
  const KudosHighlightCard({
    super.key,
    required this.item,
    this.onTap,
    this.width,
  });

  final KudoItem item;
  final VoidCallback? onTap;
  final double? width;

  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width ?? 280.w,
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: AppColors.kudosCardBackground,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: AppColors.accentGold, width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildPeopleRow(tr),
            Gap(8.h),
            Container(height: 0.463, color: AppColors.accentGold),
            Gap(8.h),
            _buildContent(),
            Gap(8.h),
            Container(height: 0.463, color: AppColors.accentGold),
            Gap(8.h),
            _buildActions(tr),
          ],
        ),
      ),
    );
  }

  Widget _buildPeopleRow(AppLocalizations tr) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Sender info
        _personInfo(
          name: item.isAnonymous ? tr.kudoAnonymousSender : item.senderName,
          badge: 'CECV10',
          honor: 'Rising Hero',
          avatarAsset: item.senderAvatarAsset,
        ),
        Gap(8.w),
        // Arrow
        Padding(
          padding: EdgeInsets.only(top: 7.h),
          child: Icon(Icons.arrow_forward, size: 16.w, color: AppColors.textBlack),
        ),
        Gap(8.w),
        // Receiver info
        _personInfo(
          name: item.receiverName,
          badge: 'CECV10',
          honor: 'Legend Hero',
          avatarAsset: item.receiverAvatarAsset,
        ),
      ],
    );
  }

  Widget _personInfo({
    required String name,
    required String badge,
    required String honor,
    String? avatarAsset,
  }) {
    return Column(
      children: [
        // Avatar
        Container(
          width: 24.w,
          height: 24.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.kudosCardAvatar,
            image: avatarAsset != null ? DecorationImage(image: AssetImage(avatarAsset), fit: BoxFit.cover) : null,
          ),
          child: avatarAsset == null
              ? Center(child: Text(name[0], style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w600)))
              : null,
        ),
        Gap(8.h),
        // Name and badges
        SizedBox(
          width: 109.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(
                  fontFamily: BaseConst.fontRegular,
                  fontSize: 10.sp,
                  height: 16 / 10,
                  color: AppColors.textBlack,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Gap(4.h),
              Row(
                children: [
                  Text(
                    badge,
                    style: TextStyle(
                      fontFamily: BaseConst.fontMedium,
                      fontSize: 10.sp,
                      height: 9.257 / 10,
                      letterSpacing: 0.0463,
                      color: AppColors.gray,
                    ),
                  ),
                  Gap(4.w),
                  Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.gray,
                    ),
                  ),
                  Gap(4.w),
                  _honorBadge(honor),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _honorBadge(String text) {
    // Parse badge text to get type and title
    final parts = text.split(' ');
    final badgeType = parts.isNotEmpty ? parts[0] : '';
    final badgeTitle = parts.length > 1 ? parts.sublist(1).join(' ') : '';

    // Determine colors based on badge type
    final isLegend = badgeType.toLowerCase() == 'legend';
    final typeColor = isLegend ? AppColors.accentGold : AppColors.risingHero;

    return Container(
      height: 9.h,
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22.r),
        border: Border.all(color: AppColors.accentGold, width: 0.231),
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            AppColors.honorBadgeDark.withValues(alpha: 0.9),
            AppColors.honorBadgeDark.withValues(alpha: 0.7),
            AppColors.honorBadgeDark.withValues(alpha: 0.5),
          ],
        ),
      ),
      alignment: Alignment.center,
      child: Text.rich(
        TextSpan(
          style: TextStyle(
            fontFamily: BaseConst.fontBold,
            fontSize: 6.sp,
            height: 7.515 / 6,
            letterSpacing: 0.0376,
            shadows: const [
              Shadow(color: AppColors.black, offset: Offset(0, 0.179), blurRadius: 0.714),
            ],
          ),
          children: [
            TextSpan(
              text: '$badgeType ',
              style: TextStyle(color: typeColor),
            ),
            TextSpan(
              text: badgeTitle,
              style: const TextStyle(color: AppColors.textPrimary),
            ),
          ],
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // Timestamp
        Text(
          item.postedAt,
          style: TextStyle(
            fontFamily: BaseConst.fontMedium,
            fontSize: 10.sp,
            height: 11.109 / 10,
            letterSpacing: 0.2314,
            color: AppColors.gray,
          ),
        ),
        Gap(8.h),
        // Title
        Text(
          item.title,
          style: TextStyle(
            fontFamily: BaseConst.fontBold,
            fontSize: 10.sp,
            height: 11.109 / 10,
            letterSpacing: 0.2314,
            color: AppColors.textBlack,
          ),
          textAlign: TextAlign.center,
        ),
        Gap(8.h),
        // Message box
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(4.w),
          decoration: BoxDecoration(
            color: AppColors.accentHighlight40,
            borderRadius: BorderRadius.circular(5.554.r),
            border: Border.all(color: AppColors.accentGold, width: 0.463),
          ),
          child: Text(
            item.message,
            style: TextStyle(
              fontFamily: BaseConst.fontRegular,
              fontSize: 10.sp,
              height: 14 / 10,
              color: AppColors.textBlack,
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.justify,
          ),
        ),
        Gap(8.h),
        // Hashtags
        if (item.hashtags.isNotEmpty)
          Text(
            item.hashtags.join(' '),
            style: TextStyle(
              fontFamily: BaseConst.fontRegular,
              fontSize: 10.sp,
              height: 11.109 / 10,
              letterSpacing: 0.2314,
              color: AppColors.error,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
      ],
    );
  }

  Widget _buildActions(AppLocalizations tr) {
    return Row(
      children: [
        // Hearts
        Row(
          children: [
            Text(
              '${item.likeCount}',
              style: TextStyle(
                fontFamily: BaseConst.fontRegular,
                fontSize: 10.sp,
                height: 14.811 / 10,
                color: AppColors.textBlack,
              ),
            ),
            Gap(1.851.w),
            Icon(Icons.favorite, color: AppColors.likeActive, size: 16.w),
          ],
        ),
        const Spacer(),
        // Action buttons
        Row(
          children: [
            _actionButton(tr.copyLink, Assets.kudosLink),
            Gap(3.703.w),
            _actionButton(tr.kudoViewDetailsAction, Assets.kudosArrowCross),
          ],
        ),
      ],
    );
  }

  Widget _actionButton(String label, String icon) {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2.r),
      ),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(
              fontFamily: BaseConst.fontMedium,
              fontSize: 10.sp,
              height: 11.109 / 10,
              letterSpacing: 0.0694,
              color: AppColors.textBlack,
            ),
          ),
          Gap(4.w),
          SvgPicture.asset(icon, width: 16.w),
        ],
      ),
    );
  }
}

/// Compact card for ALL KUDOS list.
class KudosListTileCard extends StatelessWidget {
  const KudosListTileCard({super.key, required this.item, this.onTap});

  final KudoItem item;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: KudosHighlightCard(item: item, onTap: onTap),
    );
  }
}
