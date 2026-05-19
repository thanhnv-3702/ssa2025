import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:saa2025/pages/utils/utils.dart';

class KudosUtils {
  KudosUtils._();

  static Future<void> copyKudoLink(String kudoId) async {
    final link = 'https://saa2025.sun-asterisk.com/kudos/$kudoId';
    await Clipboard.setData(ClipboardData(text: link));
    Utils.showToast('Đã sao chép link');
  }

  /// Wraps selected text in [messageController] with [wrapper] (e.g. **).
  static void applyTextWrapper({
    required TextEditingController controller,
    required String wrapper,
  }) {
    final selection = controller.selection;
    if (!selection.isValid || selection.start == selection.end) {
      Utils.showToast('Chọn đoạn chữ cần định dạng');
      return;
    }
    final text = controller.text;
    final selected = text.substring(selection.start, selection.end);
    final wrapped = '$wrapper$selected$wrapper';
    controller.value = controller.value.copyWith(
      text: text.replaceRange(selection.start, selection.end, wrapped),
      selection: TextSelection.collapsed(offset: selection.end + wrapper.length * 2),
    );
  }
}
