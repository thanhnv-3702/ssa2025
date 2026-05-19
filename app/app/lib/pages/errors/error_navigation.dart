import 'package:flutter/material.dart';
import 'package:saa2025/pages/app_pages.locator.dart';
import 'package:saa2025/pages/app_pages.router.dart';
import 'package:saa2025/pages/errors/access_denied.dart';
import 'package:saa2025/pages/errors/not_found.dart';
import 'package:saa2025/pages/utils/saa_route_guard.dart';
import 'package:stacked_services/stacked_services.dart';

/// Navigate to 403 screen (stacked route or local push).
void openAccessDenied(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute<void>(builder: (_) => const AccessDeniedState()),
  );
}

void openNotFound(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute<void>(builder: (_) => const NotFoundState()),
  );
}

/// API / guard helper — same as [handleApiAccessDenied].
void openAccessDeniedFromApi() => handleApiAccessDenied();

/// Clears stack and shows main tab (Home).
void goToHomeFromError() {
  locator<NavigationService>().clearStackAndShow(Routes.mainTabState);
}
