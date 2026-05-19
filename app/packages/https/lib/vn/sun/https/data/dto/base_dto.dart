/// Base DTO with generic type for API responses
///
/// Response structure:
/// {
///   "code": "400",
///   "message": "ABC",
///   "message_id": ["error_01"],
///   "data": "{}"
/// }
///
/// Generic type TData represents the type of data in the response
/// The data field will be handled specifically in child classes
abstract class BaseDto<TData> {
  /// HTTP status code returned by the API
  String? code;

  /// Message returned by the API
  String? message;

  /// List of error message IDs returned by the API
  List<String> messageId;

  /// The actual data payload (type defined by TData)
  /// Will be handled specifically in child classes
  TData? data;

  BaseDto({
    this.code,
    this.message,
    required this.messageId,
    this.data,
  });

  /// Convert to JSON map
  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'message': message,
      'message_id': messageId,
      'data': _dataToJson(data),
    };
  }

  /// Helper method to convert data to JSON
  /// Subclasses can override this to provide custom serialization
  dynamic _dataToJson(TData? data) {
    if (data == null) return null;
    // If data has a toJson method, call it
    if (data is Map) return data;
    if (data is List) return data;
    // Try to call toJson if available (using reflection-like approach)
    try {
      final toJsonMethod = (data as dynamic).toJson;
      if (toJsonMethod != null) {
        return toJsonMethod();
      }
    } catch (e) {
      // Ignore if toJson doesn't exist
    }
    return data.toString();
  }

  /// Check if response has any errors
  bool get hasErrors => messageId.isNotEmpty;

  /// Get error message from message_id or message field
  String get errorMessage {
    if (hasErrors) {
      return messageId.join(', ');
    }
    return message ?? '';
  }

  /// Check if response is successful (no errors)
  bool get isSuccess => !hasErrors;

  @override
  String toString() {
    return '''
BaseDto:
  code: $code
  message: $message
  messageId: $messageId
  data: $data
  hasErrors: $hasErrors
''';
  }

  /// Parse message_id from JSON
  static List<String> parseMessageId(Map<String, dynamic> json) {
    try {
      if (json['message_id'] == null) {
        return <String>[];
      }
      final messageId = json['message_id'];
      if (messageId is List) {
        return messageId.map((e) => e.toString()).toList();
      }
      // If message_id is not a List, return empty list
      return <String>[];
    } catch (e) {
      // If parsing fails, return empty list
      return <String>[];
    }
  }

  /// Parse code from JSON
  static String? parseCode(Map<String, dynamic> json) {
    return json['code']?.toString();
  }

  /// Parse message from JSON
  static String? parseMessage(Map<String, dynamic> json) {
    return json['message']?.toString();
  }
}
