import 'package:base_core/presenter/viewmodel/base_vm.dart';
import 'package:saa2025/data/repositories/repository_provider.dart';
import 'package:saa2025/pages/notification/notification_models.dart';
import 'package:saa2025/pages/utils/mixin/vm_mixin.dart';
import 'package:saa2025/services/notification_badge_service.dart';

class NotificationListVm extends AppBaseViewModel with ViewModelMixin {
  List<SaaNotificationItem> items = [];
  bool isLoading = true;

  Future<void> load() async {
    isLoading = true;
    notifyListeners();
    try {
      items = await RepositoryProvider.notifications.fetchNotifications();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void markRead(String id) {
    RepositoryProvider.notificationsMock?.markRead(id);
    items = items.map((n) => n.id == id ? n.copyWith(isRead: true) : n).toList();
    NotificationBadgeService.instance.refresh();
    notifyListeners();
  }

  void markAllRead() {
    RepositoryProvider.notificationsMock?.markAllRead();
    items = items.map((n) => n.copyWith(isRead: true)).toList();
    NotificationBadgeService.instance.refresh();
    notifyListeners();
  }
}
