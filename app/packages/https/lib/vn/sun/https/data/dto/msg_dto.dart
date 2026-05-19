import 'package:https/vn/sun/https/data/dto/base_dto.dart';

/// Message DTO with BaseDto structure
///
/// Response structure:
/// {
///   "code": "400",
///   "message": "ABC",
///   "message_id": ["error_01"],
///   "data": "{}"
/// }
///
/// Used for API responses that only contain a message/status without structured data
class MsgDto extends BaseDto<String> {
  MsgDto({
    super.code,
    super.message,
    required super.messageId,
    super.data,
  });

  /// Factory constructor from full API response
  factory MsgDto.fromJson(Map<String, dynamic> json) {
    return MsgDto(
      code: BaseDto.parseCode(json),
      message: BaseDto.parseMessage(json),
      messageId: BaseDto.parseMessageId(json),
      data: json['data'] != null ? (json['data'] is String ? json['data'] as String : json['data'].toString()) : null,
    );
  }

  /// Factory constructor from old format (for backward compatibility)
  /// @deprecated Use fromJson instead
  factory MsgDto.fromOldJson(Map<String, dynamic> json) {
    // If it looks like old format (has success/message/code), convert
    if (json.containsKey('success') || json.containsKey('message')) {
      final message = json['message']?.toString() ?? '';
      return MsgDto(
        code: json['code']?.toString(),
        message: message,
        messageId: [],
        data: message,
      );
    }
    // Otherwise, treat as full response
    return MsgDto.fromJson(json);
  }

  /// Legacy constructor for backward compatibility
  /// @deprecated Use fromJson instead
  MsgDto.legacy({
    required String? success,
    required String? msg,
    required int? code,
  }) : super(
          code: code?.toString(),
          message: msg,
          messageId: [],
          data: msg,
        );

  @override
  Map<String, dynamic> toJson() {
    final map = super.toJson();
    return map;
  }

  /// Get message from data or message field
  String? get messageText => data ?? message;

  @override
  String toString() {
    return '''MsgDto: 
  code: $code
  message: $message
  messageId: $messageId
  data: $data
  hasErrors: $hasErrors
  messageText: $messageText
''';
  }
}
