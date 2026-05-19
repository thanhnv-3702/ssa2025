import 'package:https/vn/sun/https/data/remote/api_http_exception.dart';
import 'package:saa2025/pages/utils/saa_route_guard.dart';

/// Maps API HTTP errors to in-app error screens.
class SaaApiGuard {
  SaaApiGuard._();

  static bool isForbidden(Object error) =>
      error is ApiHttpException && error.isForbidden;

  static bool isUnauthorized(Object error) =>
      error is ApiHttpException && error.isUnauthorized;

  static void handleIfForbidden(Object error) {
    if (isForbidden(error)) {
      handleApiAccessDenied();
    }
  }

  /// Returns true when caller should stop and not use mock fallback.
  static bool handleAuthErrors(Object error) {
    if (isForbidden(error)) {
      handleApiAccessDenied();
      return true;
    }
    if (isUnauthorized(error)) {
      return true;
    }
    return false;
  }
}
