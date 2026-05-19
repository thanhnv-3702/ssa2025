/// Result of POST `/apis/default/api/kudos`.
class SubmitKudoResult {
  const SubmitKudoResult({
    required this.success,
    this.kudoId,
    this.message,
  });

  final bool success;
  final String? kudoId;
  final String? message;
}
