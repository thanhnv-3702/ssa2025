import 'package:base_core/presenter/base_screen_state.dart';
import 'package:flutter/material.dart';
import 'package:saa2025/pages/kudos/kudos_models.dart';
import 'package:saa2025/pages/kudos/preview_kudo_screen.dart';
import 'package:saa2025/pages/kudos/preview_kudo_vm.dart';
import 'package:saa2025/pages/utils/extension.dart';
import 'package:saa2025/pages/utils/mixin/ui_mixin.dart';
import 'package:saa2025/pages/utils/utils.dart';

class PreviewKudoState extends StatefulWidget {
  const PreviewKudoState({
    super.key,
    required this.draft,
    this.onConfirmSend,
  });

  final KudoDraft draft;
  final Future<bool> Function()? onConfirmSend;

  @override
  State<StatefulWidget> createState() => PreviewKudo();
}

class PreviewKudo extends BaseScreenState<PreviewKudoState, PreviewKudoVm> with UIMixin {
  KudoDraft get draft => widget.draft;

  KudoItem get previewItem => draft.toPreviewItem();

  bool _isSending = false;

  bool get isSending => _isSending;

  @override
  PreviewKudoVm initViewModel() => PreviewKudoVm();

  @override
  Widget initWidget(BuildContext context) => PreviewKudoScreen(this, context).screen();

  void onBack() => Navigator.of(context).pop();

  Future<void> onSendTap() async {
    if (_isSending) return;
    setState(() => _isSending = true);
    try {
      final ok = await widget.onConfirmSend?.call() ?? false;
      if (!ok) return;
      if (!mounted) return;
      Utils.showToast(tr.previewKudoSendSuccessToast);
      Navigator.of(context).pop(true);
    } finally {
      if (mounted) setState(() => _isSending = false);
    }
  }
}
