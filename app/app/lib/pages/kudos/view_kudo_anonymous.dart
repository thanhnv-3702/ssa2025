import 'package:base_core/presenter/base_screen_state.dart';
import 'package:flutter/material.dart';
import 'package:saa2025/pages/kudos/kudos_models.dart';
import 'package:saa2025/pages/kudos/kudos_utils.dart';
import 'package:saa2025/pages/kudos/view_kudo_anonymous_screen.dart';
import 'package:saa2025/pages/kudos/view_kudo_anonymous_vm.dart';
import 'package:saa2025/pages/utils/mixin/ui_mixin.dart';

/// View kudo ẩn danh — MoMorph screen `5C2BL6GYXL`.
class ViewKudoAnonymousState extends StatefulWidget {
  const ViewKudoAnonymousState({super.key, required this.kudo});

  final KudoItem kudo;

  @override
  State<StatefulWidget> createState() => ViewKudoAnonymous();
}

class ViewKudoAnonymous extends BaseScreenState<ViewKudoAnonymousState, ViewKudoAnonymousVm>
    with UIMixin {
  KudoItem get kudo => widget.kudo;
  bool isLiked = false;
  late int likeCount;

  @override
  void beforeBuild() {
    likeCount = kudo.likeCount;
  }

  @override
  ViewKudoAnonymousVm initViewModel() => ViewKudoAnonymousVm();

  @override
  Widget initWidget(BuildContext context) => ViewKudoAnonymousScreen(this, context).screen();

  void onBack() => Navigator.of(context).pop();

  void onLikeTap() {
    setState(() {
      isLiked = !isLiked;
      likeCount += isLiked ? 1 : -1;
    });
  }

  void onCopyLinkTap() => KudosUtils.copyKudoLink(kudo.id);
}
