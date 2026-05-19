import 'package:flutter/material.dart';
import 'package:saa2025/services/notification_badge_service.dart';

/// Subscribes to [NotificationBadgeService] for header unread dot.
mixin NotificationBadgeMixin<T extends StatefulWidget> on State<T> {
  VoidCallback? _badgeListener;

  bool get hasUnreadNotifications => NotificationBadgeService.instance.hasUnread;

  void initNotificationBadge() {
    _badgeListener ??= () {
      if (mounted) setState(() {});
    };
    NotificationBadgeService.instance.addListener(_badgeListener!);
    NotificationBadgeService.instance.refresh();
  }

  void disposeNotificationBadge() {
    if (_badgeListener != null) {
      NotificationBadgeService.instance.removeListener(_badgeListener!);
    }
  }
}
