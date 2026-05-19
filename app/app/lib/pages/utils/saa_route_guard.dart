import 'package:flutter/material.dart';
import 'package:saa2025/pages/app_pages.locator.dart';
import 'package:saa2025/pages/app_pages.router.dart';
import 'package:saa2025/pages/errors/access_denied.dart';
import 'package:saa2025/pages/errors/not_found.dart';
import 'package:stacked_services/stacked_services.dart';

/// Wraps [StackedRouter] — unknown routes → Not Found; optional 403 guard.
Route<dynamic>? saaOnGenerateRoute(RouteSettings settings) {
  final name = settings.name ?? '';

  if (_isForbiddenRoute(name)) {
    return MaterialPageRoute<void>(
      settings: settings,
      builder: (_) => const AccessDeniedState(),
    );
  }

  final stacked = StackedRouter().onGenerateRoute(settings);
  if (stacked != null) return stacked;

  return MaterialPageRoute<void>(
    settings: settings,
    builder: (_) => const NotFoundState(),
  );
}

bool _isForbiddenRoute(String name) {
  const forbidden = <String>{
    '/admin',
    '/protected',
  };
  return forbidden.any((p) => name == p || name.startsWith('$p/'));
}

/// Call when API returns HTTP 403.
void handleApiAccessDenied() {
  locator<NavigationService>().navigateTo(Routes.accessDeniedState);
}
