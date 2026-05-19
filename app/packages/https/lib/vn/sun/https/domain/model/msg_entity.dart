import 'package:https/vn/sun/https/data/dto/msg_dto.dart';

class MsgEntity {
  final bool success;
  final String msg;
  final int code;

  MsgEntity(this.success, this.msg, this.code);

  static MsgEntity toEntity(MsgDto dto) {
    final bool successValue =
        (dto.code == '200' || (dto.code != null && int.tryParse(dto.code ?? '0') == 200)) && !dto.hasErrors;
    final String msgValue = dto.message ?? dto.messageText ?? 'N/A';
    final int codeValue = dto.code != null ? (int.tryParse(dto.code!) ?? -1) : -1;

    return MsgEntity(successValue, msgValue, codeValue);
  }

  @override
  String toString() {
    return '''Entity: success = $success message = $msg code = $code ''';
  }
}
