import 'package:flutter_test/flutter_test.dart';

// MoMorph: TC_LOGIN_ACC_001 (splash → login visible)
import 'package:integration_test/integration_test.dart';
import 'package:saa2025/main.dart' as app;

/// Smoke: app khởi động và hiển thị Login (mock auth).
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('SAA app launches to login screen', (tester) async {
    app.main();
    await tester.pumpAndSettle(const Duration(seconds: 4));

    expect(find.textContaining('LOGIN With Google'), findsOneWidget);
    expect(find.textContaining('SAA 2025'), findsWidgets);
  });
}
