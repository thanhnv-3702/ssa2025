import 'package:flutter_test/flutter_test.dart';

/// Tap bottom nav item by label (SAA 2025 / Awards / Kudos / Profile).
Future<void> tapBottomNav(WidgetTester tester, String label) async {
  final matches = find.text(label);
  expect(matches, findsWidgets);
  await tester.tap(matches.last);
  await tester.pumpAndSettle();
}

/// Mock login when splash lands on Login.
Future<void> mockLoginIfNeeded(WidgetTester tester) async {
  await tester.pumpAndSettle(const Duration(seconds: 4));
  final loginBtn = find.textContaining('LOGIN With Google');
  if (loginBtn.evaluate().isEmpty) return;
  await tester.tap(loginBtn);
  await tester.pumpAndSettle(const Duration(seconds: 6));
}
