import 'package:flutter_test/flutter_test.dart';
import 'package:saa2025/data/parsers/notifications_json_parser.dart';
import 'package:saa2025/pages/notification/notification_models.dart';

void main() {
  test('parseList unwraps data.items', () {
    final json = {
      'data': {
        'items': [
          {
            'id': 'n1',
            'title': 'Kudos mới',
            'body': 'Hello',
            'type': 'kudos',
            'is_read': false,
            'time_label': '5 phút trước',
          },
        ],
      },
    };
    final list = NotificationsJsonParser.parseList(json);
    expect(list, hasLength(1));
    expect(list.first.id, 'n1');
    expect(list.first.type, SaaNotificationType.kudos);
    expect(list.first.isRead, isFalse);
  });
}
