import 'package:base_core/common/base_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:saa2025/pages/secret_box/secret_box_models.dart';

class SecretBoxActivityTile extends StatelessWidget {
  const SecretBoxActivityTile({
    super.key,
    required this.item,
    this.onTap,
    this.onActionTap,
  });

  final SecretBoxActivityItem item;
  final VoidCallback? onTap;
  final VoidCallback? onActionTap;

  static const Color _accent = Color(0xFFFFE99E);
  static const Color _textOnDark = Color(0xFFFFFFFF);
  static const Color _divider = Color(0xFF2E3940);
  static const Color _muted = Color(0xFF999999);
  static const Color _unreadDot = Color(0xFFD4271D);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.h),
          decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: _divider)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _icon(),
              Gap(16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.body,
                      style: TextStyle(
                        fontFamily: item.isUnread ? BaseConst.fontBold : BaseConst.fontRegular,
                        fontSize: 14.sp,
                        height: 20 / 14,
                        letterSpacing: 0.25,
                        color: _textOnDark,
                      ),
                    ),
                    if (item.actionLabel != null) ...[
                      Gap(8.h),
                      TextButton(
                        onPressed: onActionTap,
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: Text(
                          item.actionLabel!,
                          style: TextStyle(
                            fontFamily: BaseConst.fontBold,
                            fontSize: 14.sp,
                            color: _accent,
                          ),
                        ),
                      ),
                    ],
                    Gap(8.h),
                    Text(
                      item.timeLabel,
                      style: TextStyle(
                        fontFamily: BaseConst.fontRegular,
                        fontSize: 12.sp,
                        color: _muted,
                      ),
                    ),
                  ],
                ),
              ),
              if (item.isUnread)
                Container(
                  width: 8.w,
                  height: 8.w,
                  margin: EdgeInsets.only(top: 4.h),
                  decoration: const BoxDecoration(
                    color: _unreadDot,
                    shape: BoxShape.circle,
                  ),
                ),
            ],
          ),
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
      case SecretBoxActivityType.badgeComplete:
        icon = Icons.emoji_events_outlined;
    }
    return Icon(icon, color: _accent, size: 24.sp);
  }
}
