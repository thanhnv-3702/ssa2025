import 'package:base_core/common/base_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:saa2025/pages/kudos/kudos_models.dart';

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

  static const Color _cardBg = Color(0xFFFFF8E1);
  static const Color _textBlack = Color(0xFF00101A);
  static const Color _textGray = Color(0xFF999999);
  static const Color _textError = Color(0xFFD4271D);
  static const Color _borderGold = Color(0xFFFFEA9E);
  static const Color _messageBg = Color(0x66FFEA9E); // 40% opacity

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width ?? 280.w,
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: _cardBg,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: _borderGold, width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildPeopleRow(),
            Gap(8.h),
            Container(height: 0.463, color: _borderGold),
            Gap(8.h),
            _buildContent(),
            Gap(8.h),
            Container(height: 0.463, color: _borderGold),
            Gap(8.h),
            _buildActions(),
          ],
        ),
      ),
    );
  }

  Widget _buildPeopleRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Sender info
        _personInfo(
          name: item.isAnonymous ? 'Ẩn danh' : item.senderName,
          badge: 'CECV10',
          honor: 'Rising Hero',
          avatarAsset: item.senderAvatarAsset,
        ),
        Gap(8.w),
        // Arrow
        Padding(
          padding: EdgeInsets.only(top: 7.h),
          child: Icon(Icons.arrow_forward, size: 16.w, color: _textBlack),
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
            color: const Color(0xFFE8E0C8),
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
                  color: _textBlack,
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
                      color: _textGray,
                    ),
                  ),
                  Gap(4.w),
                  Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: _textGray,
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
    final typeColor = isLegend ? const Color(0xFFFFEA9E) : const Color(0xFFCDFF60);

    return Container(
      height: 9.h,
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22.r),
        border: Border.all(color: _borderGold, width: 0.231),
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            const Color(0xFF092432).withValues(alpha: 0.9),
            const Color(0xFF092432).withValues(alpha: 0.7),
            const Color(0xFF092432).withValues(alpha: 0.5),
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
              Shadow(color: Colors.black, offset: Offset(0, 0.179), blurRadius: 0.714),
            ],
          ),
          children: [
            TextSpan(
              text: '$badgeType ',
              style: TextStyle(color: typeColor),
            ),
            TextSpan(
              text: badgeTitle,
              style: const TextStyle(color: Colors.white),
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
            color: _textGray,
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
            color: _textBlack,
          ),
          textAlign: TextAlign.center,
        ),
        Gap(8.h),
        // Message box
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(4.w),
          decoration: BoxDecoration(
            color: _messageBg,
            borderRadius: BorderRadius.circular(5.554.r),
            border: Border.all(color: _borderGold, width: 0.463),
          ),
          child: Text(
            item.message,
            style: TextStyle(
              fontFamily: BaseConst.fontRegular,
              fontSize: 10.sp,
              height: 14 / 10,
              color: _textBlack,
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
              color: _textError,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
      ],
    );
  }

  Widget _buildActions() {
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
                color: _textBlack,
              ),
            ),
            Gap(1.851.w),
            Icon(Icons.favorite, color: Colors.red, size: 16.w),
          ],
        ),
        const Spacer(),
        // Action buttons
        Row(
          children: [
            _actionButton('Copy Link', Assets.kudosLink),
            Gap(3.703.w),
            _actionButton('Xem chi tiết', Assets.kudosArrowCross),
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
              color: _textBlack,
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
