import 'dart:async';

import 'package:base_core/presenter/base_screen_state.dart';
import 'package:flutter/material.dart';
import 'package:saa2025/pages/kudos/community_standards.dart';
import 'package:saa2025/pages/secret_box/secret_box_mock_data.dart';
import 'package:saa2025/pages/secret_box/secret_box_models.dart';
import 'package:saa2025/pages/secret_box/secret_box_screen.dart';
import 'package:saa2025/pages/secret_box/secret_box_vm.dart';
import 'package:saa2025/pages/utils/mixin/ui_mixin.dart';

/// Secret Box — MoMorph `kQk65hSYF2` + `KUmv414uC9`.
class SecretBoxState extends StatefulWidget {
  const SecretBoxState({super.key});

  @override
  State<StatefulWidget> createState() => SecretBoxPage();
}

class SecretBoxPage extends BaseScreenState<SecretBoxState, SecretBoxVm> with UIMixin {
  SecretBoxVisualState _visualState = SecretBoxVisualState.closed;
  int _unopenedCount = SecretBoxMockData.initialUnopenedCount;
  int _rewardIndex = 0;
  String? _lastRewardTitle;
  String? _lastRewardLabel;
  List<SecretBoxActivityItem> _activities = SecretBoxMockData.initialActivities();
  Timer? _openTimer;
  SecretBoxVisualState get visualState => _visualState;

  int get unopenedCount => _unopenedCount;

  String? get lastRewardTitle => _lastRewardTitle;

  String? get lastRewardLabel => _lastRewardLabel;

  List<SecretBoxActivityItem> get activities => _activities;

  @override
  SecretBoxVm initViewModel() => SecretBoxVm();

  @override
  Widget initWidget(BuildContext context) => SecretBoxScreen(this, context).screen();

  @override
  void dispose() {
    _openTimer?.cancel();
    super.dispose();
  }

  void onBack() => Navigator.pop(context);

  void onMarkAllRead() {
    setState(() {
      _activities = _activities.map((a) => _copyRead(a)).toList();
    });
  }

  SecretBoxActivityItem _copyRead(SecretBoxActivityItem item) {
    return SecretBoxActivityItem(
      id: item.id,
      type: item.type,
      body: item.body,
      timeLabel: item.timeLabel,
      isUnread: false,
      actionLabel: item.actionLabel,
    );
  }

  void onBoxTap() {
    if (_visualState == SecretBoxVisualState.opening || _visualState == SecretBoxVisualState.standby) {
      return;
    }
    if (_unopenedCount <= 0) return;

    setState(() => _visualState = SecretBoxVisualState.opening);

    _openTimer?.cancel();
    _openTimer = Timer(const Duration(milliseconds: 1200), () {
      if (!mounted) return;
      final reward = SecretBoxMockData.rewards[_rewardIndex % SecretBoxMockData.rewards.length];
      _rewardIndex++;

      setState(() {
        _unopenedCount = (_unopenedCount - 1).clamp(0, 99);
        _lastRewardTitle = reward.title;
        _lastRewardLabel = reward.prizeLabel;
        _visualState = SecretBoxVisualState.standby;
      });
    });
  }

  void onStandbyContinue() {
    if (!mounted) return;
    setState(() {
      _visualState = SecretBoxVisualState.closed;
      _lastRewardTitle = null;
      _lastRewardLabel = null;
    });
  }

  void onActivityTap(SecretBoxActivityItem item) {
    setState(() {
      _activities = _activities
          .map((a) => a.id == item.id ? _copyRead(a) : a)
          .toList();
    });

    if (item.type == SecretBoxActivityType.secretBoxEarned && _unopenedCount > 0) {
      onBoxTap();
    }
  }

  void onActivityActionTap(SecretBoxActivityItem item) {
    if (item.type == SecretBoxActivityType.kudosHidden) {
      Navigator.push(
        context,
        MaterialPageRoute<void>(builder: (_) => const CommunityStandardsState()),
      );
    }
  }
}
