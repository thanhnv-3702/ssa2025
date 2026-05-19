import 'dart:async';

import 'package:base_core/presenter/base_screen_state.dart';
import 'package:flutter/material.dart';
import 'package:saa2025/pages/main_tab/main_tab_screen.dart';
import 'package:saa2025/pages/main_tab/main_tab_vm.dart';
import 'package:saa2025/pages/utils/event_bus/event_bus_util.dart';
import 'package:saa2025/pages/utils/mixin/ui_mixin.dart';

class MainTabState extends StatefulWidget {
  const MainTabState({super.key});

  @override
  State<MainTabState> createState() => MainTab();
}

class MainTab extends BaseScreenState<MainTabState, MainTabVm> with UIMixin {
  int currentIndex = 0;
  StreamSubscription? _subscription;

  void _setupEventBusListener() {
    _subscription?.cancel(); // Cancel existing subscription if any
    _subscription = eventBus.on().listen((event) {
      if (event is ChangeTabEvent) {
        setState(() {
          currentIndex = event.index;
        });
      }
    });
  }

  @override
  void beforeBuild() {
    super.beforeBuild();
    _setupEventBusListener();
  }

  @override
  void dispose() {
    super.dispose();
    _subscription?.cancel();
  }

  @override
  MainTabVm initViewModel() => MainTabVm();

  void onTabSelected(int index) {
    setState(() => currentIndex = index);
  }

  @override
  Widget initWidget(BuildContext context) => MainTabScreen(this, context).screen();
}
