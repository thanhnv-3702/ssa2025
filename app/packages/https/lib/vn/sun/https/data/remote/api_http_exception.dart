/// HTTP failure from [AppAPI] with status code (for 403 / 404 handling in app).
class ApiHttpException implements Exception {
  ApiHttpException({
    required this.statusCode,
    this.body,
    this.message,
  });

  final int statusCode;
  final dynamic body;
  final String? message;

  bool get isForbidden => statusCode == 403;
  bool get isNotFound => statusCode == 404;
  bool get isUnauthorized => statusCode == 401;

  @override
  String toString() => 'ApiHttpException($statusCode): ${message ?? body}';
}
