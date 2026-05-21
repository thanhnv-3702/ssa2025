import 'package:base_core/presenter/base_screen_state.dart';
import 'package:flutter/material.dart';
import 'package:saa2025/pages/kudos/kudos_models.dart';
import 'package:saa2025/pages/kudos/kudos_utils.dart';
import 'package:saa2025/pages/kudos/view_kudo_screen.dart';
import 'package:saa2025/pages/kudos/view_kudo_vm.dart';
import 'package:saa2025/pages/utils/mixin/ui_mixin.dart';

class ViewKudoState extends StatefulWidget {
  const ViewKudoState({super.key, required this.kudo});

  final KudoItem kudo;

  @override
  State<StatefulWidget> createState() => ViewKudo();
}

class ViewKudo extends BaseScreenState<ViewKudoState, ViewKudoVm> with UIMixin {
  KudoItem get kudo => widget.kudo;
  bool isLiked = false;
  int likeCount = 0;

  @override
  void beforeBuild() {
    likeCount = kudo.likeCount;
  }

  @override
  ViewKudoVm initViewModel() => ViewKudoVm();

  @override
  Widget initWidget(BuildContext context) => ViewKudoScreen(this, context).screen();

  void onBack() => Navigator.of(context).pop();

  void onLikeTap() {
    setState(() {
      isLiked = !isLiked;
      likeCount += isLiked ? 1 : -1;
    });
  }

  void onCopyLinkTap() => KudosUtils.copyKudoLink(kudo.id);
}
