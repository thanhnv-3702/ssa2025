import 'package:base_core/common/base_const.dart';
import 'package:base_core/presenter/base_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:saa2025/pages/notification/notification_list.dart';
import 'package:saa2025/pages/notification/notification_models.dart';
import 'package:saa2025/pages/widgets/saa_app_header.dart';
import 'package:saa2025/theme/saa_design_tokens.dart';

/// Notifications — MoMorph `_b68CBWKl5`.
class NotificationListScreen extends BaseScreen<NotificationList> {
  NotificationListScreen(super.main, super.context);

  static const Color _textOnDark = SaaDesignTokens.textOnDark;

  @override
  Widget screen() {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: SaaDesignTokens.background,
        body: Column(
          children: [
            SaaAppHeader(
              languageCode: 'VN',
              onLanguageTap: () {},
              showBack: true,
              onBack: main.onBackPressed,
              title: 'Thông báo',
            ),
            if (main.isLoading)
              const Expanded(child: Center(child: CircularProgressIndicator(color: SaaDesignTokens.accent))),
            if (!main.isLoading && !main.isEmpty)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: main.onMarkAllRead,
                    child: Text(
                      'Đánh dấu đã đọc',
                      style: TextStyle(
                        fontFamily: BaseConst.fontMedium,
                        fontSize: 13.sp,
                        color: SaaDesignTokens.accent,
                      ),
                    ),
                  ),
                ),
              ),
            if (!main.isLoading) Expanded(child: main.isEmpty ? _emptyState() : _list()),
          ],
        ),
      ),
    );
  }

  Widget _emptyState() {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.notifications_none, size: 48.sp, color: _textOnDark.withValues(alpha: 0.4)),
            Gap(16.h),
            Text(
              'Chưa có thông báo',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: BaseConst.fontSemiBold,
                fontSize: 18.sp,
                color: _textOnDark,
              ),
            ),
            Gap(8.h),
            Text(
              'Các cập nhật về Kudos, giải thưởng và sự kiện SAA sẽ hiển thị tại đây.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: BaseConst.fontLight,
                fontSize: 14.sp,
                height: 22 / 14,
                color: _textOnDark.withValues(alpha: 0.75),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _list() {
    return ListView.separated(
      padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 24.h),
      itemCount: main.items.length,
      separatorBuilder: (_, __) => Gap(8.h),
      itemBuilder: (_, index) => _notificationTile(main.items[index]),
    );
  }

  Widget _notificationTile(SaaNotificationItem item) {
    return Material(
      color: item.isRead ? Colors.white.withValues(alpha: 0.04) : Colors.white.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(8.r),
      child: InkWell(
        onTap: () => main.onNotificationTap(item),
        borderRadius: BorderRadius.circular(8.r),
        child: Padding(
          padding: EdgeInsets.all(12.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _typeIcon(item.type),
              Gap(12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            item.title,
                            style: TextStyle(
                              fontFamily: BaseConst.fontSemiBold,
                              fontSize: 14.sp,
                              color: _textOnDark,
                            ),
                          ),
                        ),
                        if (!item.isRead)
                          Container(
                            width: 8.w,
                            height: 8.w,
                            decoration: const BoxDecoration(
                              color: Color(0xFFE53935),
                              shape: BoxShape.circle,
                            ),
                          ),
                      ],
                    ),
                    Gap(4.h),
                    Text(
                      item.body,
                      style: TextStyle(
                        fontFamily: BaseConst.fontLight,
                        fontSize: 13.sp,
                        height: 18 / 13,
                        color: _textOnDark.withValues(alpha: 0.8),
                      ),
                    ),
                    Gap(6.h),
                    Text(
                      item.timeLabel,
                      style: TextStyle(
                        fontFamily: BaseConst.fontLight,
                        fontSize: 11.sp,
                        color: _textOnDark.withValues(alpha: 0.5),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _typeIcon(SaaNotificationType type) {
    final IconData icon;
    switch (type) {
      case SaaNotificationType.kudos:
        icon = Icons.favorite_border;
      case SaaNotificationType.award:
        icon = Icons.emoji_events_outlined;
      case SaaNotificationType.system:
        icon = Icons.campaign_outlined;
    }
    return Container(
      width: 40.w,
      height: 40.w,
      decoration: BoxDecoration(
        color: SaaDesignTokens.accent.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Icon(icon, color: SaaDesignTokens.accent, size: 22.sp),
    );
  }
}
