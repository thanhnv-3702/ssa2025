import 'package:flutter/foundation.dart';
import 'package:saa2025/data/repositories/repository_provider.dart';

/// Shared unread badge state for Home / Kudos / Awards headers.
class NotificationBadgeService extends ChangeNotifier {
  NotificationBadgeService._();

  static final NotificationBadgeService instance = NotificationBadgeService._();

  bool _hasUnread = false;
  int _count = 0;

  bool get hasUnread => _hasUnread;

  int get count => _count;

  Future<void> refresh() async {
    try {
      _count = await RepositoryProvider.notifications.unreadCount();
      _hasUnread = _count > 0;
    } catch (_) {
      // Keep previous badge on transient errors.
    }
    notifyListeners();
  }

  void clearBadge() {
    _hasUnread = false;
    _count = 0;
    notifyListeners();
  }
}
