import 'package:base_core/presenter/base_screen_state.dart';
import 'package:flutter/material.dart';
import 'package:saa2025/pages/notification/notification_list_screen.dart';
import 'package:saa2025/pages/notification/notification_list_vm.dart';
import 'package:saa2025/pages/notification/notification_models.dart';
import 'package:saa2025/pages/utils/mixin/ui_mixin.dart';
import 'package:saa2025/services/notification_badge_service.dart';

class NotificationListState extends StatefulWidget {
  const NotificationListState({super.key});

  @override
  State<StatefulWidget> createState() => NotificationList();
}

class NotificationList extends BaseScreenState<NotificationListState, NotificationListVm> with UIMixin {
  List<SaaNotificationItem> get items => vm.items;

  bool get isEmpty => !vm.isLoading && items.isEmpty;

  bool get isLoading => vm.isLoading;

  @override
  NotificationListVm initViewModel() => NotificationListVm();

  @override
  void beforeBuild() {
    super.beforeBuild();
    vm.load();
  }

  @override
  Widget initWidget(BuildContext context) => NotificationListScreen(this, context).screen();

  void onBackPressed() {
    NotificationBadgeService.instance.refresh();
    navigator.back();
  }

  void onNotificationTap(SaaNotificationItem item) => vm.markRead(item.id);

  void onMarkAllRead() => vm.markAllRead();
}
