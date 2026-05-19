import 'base_dto.dart';

abstract class DataDto<T> extends BaseDto<T> {
  DataDto({
    super.code,
    super.message,
    required super.messageId,
    super.data,
  });

  T? initData(dynamic json);

  @override
  Map<String, dynamic> toJson() {
    final map = super.toJson();
    // Override data serialization if data has toJson method
    if (data != null) {
      try {
        final toJsonMethod = (data as dynamic).toJson;
        if (toJsonMethod != null) {
          map['data'] = toJsonMethod();
        }
      } catch (e) {
        // Use default serialization
        map['data'] = data;
      }
    }
    return map;
  }

  @override
  String toString() {
    return '''
DataDto:
  code: $code
  message: $message
  messageId: $messageId
  data: $data
  hasErrors: $hasErrors
''';
  }
}
