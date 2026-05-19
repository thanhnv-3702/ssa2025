import 'package:saa2025/pages/kudos/kudos_models.dart';

/// Maps [KudoDraft] → SAA POST `/kudos` body.
abstract final class KudoSubmitMapper {
  static Map<String, dynamic> toJson(KudoDraft draft) {
    return {
      'recipient_id': draft.recipient.id,
      'recipient_name': draft.recipient.name,
      'title': draft.title,
      'message': draft.message,
      'hashtags': draft.hashtags,
      'is_anonymous': draft.isAnonymous,
      'image_count': draft.imageCount,
    };
  }
}
