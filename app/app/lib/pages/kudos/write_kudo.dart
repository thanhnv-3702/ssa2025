import 'package:base_core/presenter/base_screen_state.dart';
import 'package:flutter/material.dart';
import 'package:saa2025/pages/kudos/community_standards.dart';
import 'package:saa2025/pages/kudos/kudos_models.dart';
import 'package:saa2025/pages/kudos/kudos_utils.dart';
import 'package:saa2025/pages/kudos/preview_kudo.dart';
import 'package:saa2025/pages/kudos/widgets/kudos_hashtag_sheet.dart';
import 'package:saa2025/pages/kudos/widgets/kudos_recipient_sheet.dart';
import 'package:saa2025/pages/kudos/write_kudo_screen.dart';
import 'package:saa2025/pages/kudos/write_kudo_vm.dart';
import 'package:saa2025/pages/utils/extension.dart';
import 'package:saa2025/pages/utils/mixin/ui_mixin.dart';
import 'package:saa2025/pages/utils/utils.dart';
import 'package:saa2025/theme/app_colors.dart';

/// Viết Kudo — MoMorph screen `7fFAb-K35a` (+ lỗi `0le8xKnFE_`).
class WriteKudoState extends StatefulWidget {
  const WriteKudoState({super.key, this.initialRecipient});

  final SunnerProfile? initialRecipient;

  @override
  State<StatefulWidget> createState() => WriteKudo();
}

class WriteKudo extends BaseScreenState<WriteKudoState, WriteKudoVm> with UIMixin {
  final TextEditingController recipientController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController messageController = TextEditingController();
  final List<String> hashtags = [];
  final List<int> attachedImages = [];
  bool sendAnonymous = false;
  bool showValidationError = false;
  SunnerProfile? selectedRecipient;

  static const int maxImages = 5;

  @override
  WriteKudoVm initViewModel() => WriteKudoVm();

  @override
  void beforeBuild() {
    if (widget.initialRecipient != null) {
      selectedRecipient = widget.initialRecipient;
      recipientController.text = widget.initialRecipient!.name;
    }
  }

  @override
  Widget initWidget(BuildContext context) => WriteKudoScreen(this, context).screen();

  void onBack() => Navigator.of(context).pop();

  void onCancelTap() {
    final hasContent = recipientController.text.isNotEmpty ||
        titleController.text.isNotEmpty ||
        messageController.text.isNotEmpty ||
        hashtags.isNotEmpty ||
        attachedImages.isNotEmpty;
    if (!hasContent) {
      onBack();
      return;
    }
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.fieldBackground,
        title: Text(tr.writeKudoCancelDialogTitle, style: const TextStyle(color: AppColors.textPrimary)),
        content: Text(
          tr.writeKudoCancelDialogMessage,
          style: const TextStyle(color: AppColors.textMuted),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: Text(tr.writeKudoCancelDialogContinue)),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              onBack();
            },
            child: Text(tr.writeKudoCancelDialogConfirm, style: const TextStyle(color: AppColors.accent)),
          ),
        ],
      ),
    );
  }

  Future<void> onCommunityStandardsTap() async {
    await Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => const CommunityStandardsState()),
    );
  }

  void onAddImageTap() {
    if (attachedImages.length >= maxImages) {
      Utils.showToast(tr.writeKudoMaxImagesToast(maxImages));
      return;
    }
    setState(() => attachedImages.add(attachedImages.length + 1));
  }

  void onRemoveImage(int index) {
    setState(() => attachedImages.removeAt(index));
  }

  Future<void> onRecipientTap() async {
    final picked = await showKudosRecipientSheet(context);
    if (picked != null) {
      selectedRecipient = picked;
      recipientController.text = picked.name;
      setState(() => showValidationError = false);
    }
  }

  Future<void> onAddHashtagTap() async {
    await showKudosHashtagSheet(
      context: context,
      selected: hashtags,
      onChanged: (updated) {
        hashtags
          ..clear()
          ..addAll(updated);
        setState(() => showValidationError = false);
      },
    );
  }

  void onRemoveHashtag(int index) {
    hashtags.removeAt(index);
    setState(() {});
  }

  void onFormatBold() => KudosUtils.applyTextWrapper(controller: messageController, wrapper: '**');

  void onFormatItalic() => KudosUtils.applyTextWrapper(controller: messageController, wrapper: '_');

  void onFormatStrike() => KudosUtils.applyTextWrapper(controller: messageController, wrapper: '~~');

  void onFormatQuote() {
    final text = messageController.text;
    final sel = messageController.selection;
    if (!sel.isValid) return;
    final lineStart = text.lastIndexOf('\n', sel.start - 1) + 1;
    messageController.text = text.replaceRange(lineStart, lineStart, '> ');
    setState(() {});
  }

  KudoDraft? _buildDraft() {
    if (selectedRecipient == null && recipientController.text.trim().isEmpty) {
      return null;
    }
    final recipient = selectedRecipient ??
        SunnerProfile(
          id: 'unknown',
          name: recipientController.text.trim(),
          department: '',
        );
    return KudoDraft(
      recipient: recipient,
      title: titleController.text.trim(),
      message: messageController.text.trim(),
      hashtags: List.from(hashtags),
      isAnonymous: sendAnonymous,
      imageCount: attachedImages.length,
    );
  }

  bool _validate({bool forPreview = false}) {
    final missingRecipient = recipientController.text.trim().isEmpty;
    final missingMessage = messageController.text.trim().isEmpty;
    final missingHashtags = hashtags.isEmpty;

    if (missingRecipient || missingMessage || missingHashtags) {
      if (!forPreview) setState(() => showValidationError = true);
      return false;
    }
    if (titleController.text.trim().isEmpty) {
      Utils.showToast(tr.writeKudoTitleRequiredToast);
      return false;
    }
    setState(() => showValidationError = false);
    return true;
  }

  Future<void> onPreviewTap() async {
    if (!_validate(forPreview: true)) return;
    final draft = _buildDraft();
    if (draft == null) return;
    final sent = await Navigator.of(context).push<bool>(
      MaterialPageRoute(
        builder: (_) => PreviewKudoState(
          draft: draft,
          onConfirmSend: () => _submitDraft(draft),
        ),
      ),
    );
    if (sent == true && mounted) onBack();
  }

  Future<void> onSendTap() async {
    if (!_validate() || vm.isSubmitting) return;
    final draft = _buildDraft();
    if (draft == null) return;
    final ok = await _submitDraft(draft);
    if (ok && mounted) {
      Utils.showToast(tr.writeKudoSendSuccessToast);
      Navigator.of(context).pop();
    }
  }

  Future<bool> _submitDraft(KudoDraft draft) => vm.submitKudo(draft);

  void onAnonymousChanged(bool value) => setState(() => sendAnonymous = value);

  void dismissValidationError() => setState(() => showValidationError = false);

  @override
  void dispose() {
    recipientController.dispose();
    titleController.dispose();
    messageController.dispose();
    super.dispose();
  }
}
