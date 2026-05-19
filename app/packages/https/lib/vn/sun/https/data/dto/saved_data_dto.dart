import 'package:https/vn/sun/https/data/dto/base_dto.dart';

class SavedDataDto extends BaseDto<String> {
  String? key, data;

  SavedDataDto({required super.messageId});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['data'] = this.data;
    return data;
  }

  static SavedDataDto fromJson(Map<String, dynamic> json) {
    return SavedDataDto(
      messageId: [],
    );
  }

  @override
  String toString() {
    return '''
      key = $key
      data = $data
   ''';
  }
}
