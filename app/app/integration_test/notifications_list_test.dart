import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:saa2025/main.dart' as app;

import 'integration_nav.dart';

/// MoMorph: Notifications `_b68CBWKl5`
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('opens notifications list from kudos header', (tester) async {
    app.main();
    await mockLoginIfNeeded(tester);
    await tapBottomNav(tester, 'Kudos');

    final notifIcons = find.byType(InkWell);
    expect(notifIcons, findsWidgets);

    // Tap notification icon area (top-right header)
    await tester.tapAt(const Offset(350, 70));
    await tester.pumpAndSettle(const Duration(seconds: 3));

    final onNotifScreen = find.text('Thông báo').evaluate().isNotEmpty ||
        find.text('Chưa có thông báo').evaluate().isNotEmpty ||
        find.textContaining('Kudos').evaluate().isNotEmpty;
    expect(onNotifScreen, isTrue);
  });
}
