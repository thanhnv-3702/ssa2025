class ErrorDto{
  String? message;
  List<dynamic>? messageId;
  String? code;

  ErrorDto({this.message, this.messageId, this.code});

  static ErrorDto fromJson(Map<String, dynamic> json) {
    return ErrorDto(
      message: json['message'],
      messageId: json['message_id'],
      code: json['code'],
    );
  }

  @override
  String toString() {
    return 'code: $code, message: $message, message_id: $messageId';
  }

  static ErrorDto fromText(String txt) {
    return ErrorDto(
      message: txt,
      messageId: ['app_error_999'],
      code: '400',
    );
  }
}
