import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:saa2025/main.dart' as app;

import 'integration_nav.dart';

/// MoMorph: TC_SB_FUN_001, TC_SB_FUN_002
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('secret box open flow when unopened count > 0', (tester) async {
    app.main();
    await mockLoginIfNeeded(tester);

    await tapBottomNav(tester, 'Awards');
    await tester.tap(find.text('SECRET BOX'));
    await tester.pumpAndSettle(const Duration(seconds: 2));

    expect(find.textContaining('KHÁM PHÁ SECRET BOX'), findsOneWidget);

    await tester.tap(find.byType(GestureDetector).first);
    await tester.pump();
    await tester.pumpAndSettle(const Duration(seconds: 3));

    final continueBtn = find.text('Tiếp tục');
    if (continueBtn.evaluate().isNotEmpty) {
      await tester.tap(continueBtn);
      await tester.pumpAndSettle(const Duration(seconds: 2));
      expect(find.textContaining('KHÁM PHÁ SECRET BOX'), findsOneWidget);
    }
  });
}
