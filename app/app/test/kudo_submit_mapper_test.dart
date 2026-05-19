import 'package:flutter_test/flutter_test.dart';
import 'package:saa2025/data/kudo_submit_mapper.dart';
import 'package:saa2025/data/parsers/kudos_json_parser.dart';
import 'package:saa2025/pages/kudos/kudos_models.dart';

void main() {
  test('KudoSubmitMapper maps draft to API body', () {
    const draft = KudoDraft(
      recipient: SunnerProfile(id: 's1', name: 'A', department: 'DEV'),
      title: 'Star',
      message: 'Thanks',
      hashtags: ['#team'],
      isAnonymous: true,
      imageCount: 2,
    );
    final body = KudoSubmitMapper.toJson(draft);
    expect(body['recipient_id'], 's1');
    expect(body['is_anonymous'], isTrue);
    expect(body['hashtags'], ['#team']);
    expect(body['image_count'], 2);
  });

  test('parseSubmitResult reads kudo_id', () {
    final result = KudosJsonParser.parseSubmitResult({
      'data': {'id': 'k99', 'success': true},
    });
    expect(result.success, isTrue);
    expect(result.kudoId, 'k99');
  });
}
