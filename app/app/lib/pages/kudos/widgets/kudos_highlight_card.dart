import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:saa2025/pages/kudos/kudos_models.dart';

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
  static const Color _accent = Color(0xFF00101A);
  static const Color _accentGold = Color(0xFFB8860B);
  static const Color _textMuted = Color(0x9900101A);
  static const Color _border = Color(0xFFFFEA9E);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width ?? 320.w,
        decoration: BoxDecoration(
          color: _cardBg,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: _border, width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildPeopleRow(),
            Divider(height: 1, color: _accent.withValues(alpha: 0.12)),
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: TextStyle(
                      color: _accent,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                    ),
                  ),
                  Gap(8.h),
                  Text(
                    item.message,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: _accent, fontSize: 13.sp, height: 1.4),
                  ),
                  if (item.hashtags.isNotEmpty) ...[
                    Gap(8.h),
                    Wrap(
                      spacing: 6.w,
                      children: item.hashtags
                          .map(
                            (tag) => Text(
                              tag,
                              style: TextStyle(color: _accentGold, fontSize: 12.sp),
                            ),
                          )
                          .toList(),
                    ),
                  ],
                  Gap(12.h),
                  Row(
                    children: [
                      _actionChip(Icons.favorite_border, '${item.likeCount}'),
                      Gap(16.w),
                      _actionChip(Icons.chat_bubble_outline, '${item.commentCount}'),
                      const Spacer(),
                      Text(item.postedAt, style: TextStyle(color: _textMuted, fontSize: 11.sp)),
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

  Widget _buildPeopleRow() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Row(
        children: [
          _avatar(item.senderAvatarAsset, item.isAnonymous ? '?' : item.senderName[0]),
          Gap(8.w),
          Icon(Icons.arrow_forward, color: _accentGold, size: 16.sp),
          Gap(8.w),
          _avatar(item.receiverAvatarAsset, item.receiverName[0]),
          Gap(12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.isAnonymous ? 'Ẩn danh' : item.senderName,
                  style: TextStyle(color: _accent, fontSize: 12.sp, fontWeight: FontWeight.w600),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  '→ ${item.receiverName}',
                  style: TextStyle(color: _textMuted, fontSize: 11.sp),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _avatar(String? asset, String fallback) {
    return CircleAvatar(
      radius: 20.r,
      backgroundColor: const Color(0xFFE8E0C8),
      backgroundImage: asset != null ? AssetImage(asset) : null,
      child: asset == null ? Text(fallback, style: TextStyle(color: _accentGold, fontSize: 14.sp)) : null,
    );
  }

  Widget _actionChip(IconData icon, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: _textMuted, size: 16.sp),
        Gap(4.w),
        Text(label, style: TextStyle(color: _textMuted, fontSize: 12.sp)),
      ],
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
