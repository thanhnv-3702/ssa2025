import 'package:flutter/material.dart';
import 'package:saa2025/pages/awards/awards_mock_data.dart';
import 'package:saa2025/pages/rules/rules_vm.dart';
import 'package:saa2025/pages/utils/mixin/ui_mixin.dart';
import 'package:base_core/presenter/base_screen_state.dart';

import 'rules_screen.dart';

/// Thể lệ — MoMorph `zIuFaHAid4`.
class RulesState extends StatefulWidget {
  const RulesState({super.key});

  @override
  State<StatefulWidget> createState() => Rules();
}

class Rules extends BaseScreenState<RulesState, RulesVm> with UIMixin {
  String get intro => AwardsMockData.rulesIntro;

  List<({String title, String body})> get sections => AwardsMockData.rulesSections;

  @override
  RulesVm initViewModel() => RulesVm();

  @override
  Widget initWidget(BuildContext context) => RulesScreen(this, context).screen();

  void onBack() => Navigator.pop(context);
}
