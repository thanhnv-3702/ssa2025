import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:saa2025/main.dart' as app;

import 'integration_nav.dart';

/// MoMorph: TC_NOTFOUND_FUN_003 (via search empty → Not Found)
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('search with no results shows not found screen', (tester) async {
    app.main();
    await mockLoginIfNeeded(tester);

    await tapBottomNav(tester, 'Kudos');
    await tester.scrollUntilVisible(
      find.text('Tìm kiếm Sunner'),
      400,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(find.text('Tìm kiếm Sunner'));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField), 'zzzznonexistent999xyz');
    await tester.pump();
    await tester.pumpAndSettle(const Duration(seconds: 2));

    expect(find.text('NOT FOUND'), findsOneWidget);
  });
}
