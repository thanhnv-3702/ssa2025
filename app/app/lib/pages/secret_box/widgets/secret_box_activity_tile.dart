import 'package:base_core/common/base_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:saa2025/pages/secret_box/secret_box_models.dart';
import 'package:saa2025/theme/app_colors.dart';

/// Single row in Figma `3:20868` Notification list.
class SecretBoxActivityTile extends StatelessWidget {
  const SecretBoxActivityTile({
    super.key,
    required this.item,
    this.onTap,
    this.onActionTap,
    this.showBottomBorder = true,
  });

  final SecretBoxActivityItem item;
  final VoidCallback? onTap;
  final VoidCallback? onActionTap;
  final bool showBottomBorder;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            border: showBottomBorder
                ? const Border(bottom: BorderSide(color: AppColors.divider))
                : null,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _icon(),
              Gap(16.w),
              Expanded(child: _content()),
              if (item.isUnread) ...[
                Gap(8.w),
                Container(
                  width: 8.w,
                  height: 8.w,
                  decoration: const BoxDecoration(
                    color: AppColors.unreadDot,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _content() {
    final bodyStyle = TextStyle(
      fontFamily: item.isUnread ? BaseConst.fontBold : BaseConst.fontRegular,
      fontSize: 14.sp,
      height: 20 / 14,
      letterSpacing: 0.25,
      color: AppColors.textOnDark,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...item.body.split('\n').map(
              (line) => Text(line, style: bodyStyle),
            ),
        if (item.actionLabel != null) ...[
          Gap(8.h),
          _actionLink(),
        ],
        Gap(8.h),
        Text(
          item.timeLabel,
          style: TextStyle(
            fontFamily: BaseConst.fontRegular,
            fontSize: 12.sp,
            height: 16 / 12,
            color: AppColors.gray,
          ),
        ),
      ],
    );
  }

  Widget _actionLink() {
    if (item.communityLinkAction) {
      return GestureDetector(
        onTap: onActionTap,
        behavior: HitTestBehavior.opaque,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              item.actionLabel!,
              style: TextStyle(
                fontFamily: BaseConst.fontMedium,
                fontSize: 14.sp,
                height: 20 / 14,
                color: AppColors.textPrimary,
                decoration: TextDecoration.underline,
                decorationColor: AppColors.textPrimary,
              ),
            ),
            Gap(4.w),
            Icon(Icons.open_in_new, size: 24.sp, color: AppColors.textPrimary),
          ],
        ),
      );
    }

    return GestureDetector(
      onTap: onActionTap,
      behavior: HitTestBehavior.opaque,
      child: Text(
        item.actionLabel!,
        style: TextStyle(
          fontFamily: BaseConst.fontBold,
          fontSize: 14.sp,
          height: 20 / 14,
          color: AppColors.accent,
        ),
      ),
    );
  }

  Widget _icon() {
    final IconData icon;
    switch (item.type) {
      case SecretBoxActivityType.kudosReceived:
        icon = Icons.favorite;
      case SecretBoxActivityType.kudosLiked:
        icon = Icons.thumb_up_alt_outlined;
      case SecretBoxActivityType.secretBoxEarned:
        icon = Icons.card_giftcard;
      case SecretBoxActivityType.levelUp:
        icon = Icons.trending_up;
      case SecretBoxActivityType.kudosHidden:
        icon = Icons.visibility_off_outlined;
      case SecretBoxActivityType.kudosModerationReview:
        icon = Icons.rate_review_outlined;
      case SecretBoxActivityType.badgeComplete:
        icon = Icons.emoji_events_outlined;
    }
    return SizedBox(
      width: 24.w,
      height: 24.w,
      child: Icon(icon, color: AppColors.accent, size: 24.sp),
    );
  }
}
