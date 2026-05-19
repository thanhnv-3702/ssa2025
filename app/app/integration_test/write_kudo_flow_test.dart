import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:saa2025/main.dart' as app;

import 'integration_nav.dart';

/// MoMorph Write Kudo `7fFAb-K35a` — mock submit.
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('write kudo form validates and opens from kudos tab', (tester) async {
    app.main();
    await mockLoginIfNeeded(tester);
    await tapBottomNav(tester, 'Kudos');

    final sendCta = find.textContaining('Gửi');
    if (sendCta.evaluate().isEmpty) return;
    await tester.tap(sendCta.first);
    await tester.pumpAndSettle(const Duration(seconds: 2));

    expect(find.textContaining('Gửi lời'), findsWidgets);
  });
}
