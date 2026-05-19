import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:saa2025/main.dart' as app;

/// MoMorph: TC_LOGIN_FUN_007, TC_LOGIN_FUN_012
/// E2E mock: Login → MainTab (cần SAA_AUTH_MOCK=true trong .env).
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('mock Google login reaches main tab', (tester) async {
    app.main();
    await tester.pumpAndSettle(const Duration(seconds: 4));

    final loginBtn = find.textContaining('LOGIN With Google');
    if (loginBtn.evaluate().isEmpty) {
      // Already logged in from previous session
      expect(find.byType(BottomNavigationBar), findsOneWidget);
      return;
    }

    await tester.tap(loginBtn);
    await tester.pump();
    await tester.pumpAndSettle(const Duration(seconds: 6));

    expect(find.byType(BottomNavigationBar), findsOneWidget);
  });
}
