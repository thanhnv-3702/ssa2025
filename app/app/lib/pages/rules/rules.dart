import 'package:base_core/presenter/base_screen_state.dart';
import 'package:flutter/material.dart';
import 'package:saa2025/pages/kudos/write_kudo.dart';
import 'package:saa2025/pages/rules/rules_vm.dart';
import 'package:saa2025/pages/utils/mixin/ui_mixin.dart';

import 'rules_screen.dart';

/// Thể lệ — Figma `3:22428` / MoMorph `zIuFaHAid4`.
class RulesState extends StatefulWidget {
  const RulesState({super.key});

  @override
  State<StatefulWidget> createState() => Rules();
}

class Rules extends BaseScreenState<RulesState, RulesVm> with UIMixin {
  @override
  RulesVm initViewModel() => RulesVm();

  @override
  Widget initWidget(BuildContext context) => RulesScreen(this, context).screen();

  void onBack() => Navigator.pop(context);

  void onWriteKudoTap() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => const WriteKudoState()),
    );
  }
}
