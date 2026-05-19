import 'package:base_core/presenter/base_screen_state.dart';
import 'package:flutter/material.dart';
import 'package:saa2025/pages/kudos/kudos_all_screen.dart';
import 'package:saa2025/pages/kudos/kudos_all_vm.dart';
import 'package:saa2025/pages/kudos/kudos_models.dart';
import 'package:saa2025/pages/kudos/kudos_navigation.dart';
import 'package:saa2025/pages/utils/mixin/ui_mixin.dart';

/// All Kudos list — MoMorph screen `j_a2GQWKDJ`.
class KudosAllState extends StatefulWidget {
  const KudosAllState({super.key});

  @override
  State<StatefulWidget> createState() => KudosAll();
}

class KudosAll extends BaseScreenState<KudosAllState, KudosAllVm> with UIMixin {
  List<KudoItem> get items => vm.items;

  @override
  KudosAllVm initViewModel() => KudosAllVm();

  @override
  void beforeBuild() => vm.load();

  @override
  Widget initWidget(BuildContext context) => KudosAllScreen(this, context).screen();

  void onBack() => Navigator.of(context).pop();

  void onKudoTap(KudoItem item) => openKudoDetail(context, item);
}
