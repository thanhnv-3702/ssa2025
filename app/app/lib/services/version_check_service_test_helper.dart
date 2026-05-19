import 'package:base_core/common/config.dart';
import 'package:saa2025/services/version_check_service.dart';

/// Helper class để test version check mà không cần Firebase Remote Config
/// Chỉ dùng cho development/testing
class VersionCheckServiceTestHelper {
  /// Mock version check result để test UI
  static VersionCheckResult getMockUpdateAvailable() {
    return VersionCheckResult(
      hasUpdate: true,
      currentVersion: '1.0.1',
      latestVersion: '1.0.2',
      downloadUrl: 'https://example.com/app-release.apk',
      // Thay bằng URL thật
      isRequired: false,
      changelog: '• Bug fixes\n• Performance improvements\n• New features added',
    );
  }

  /// Mock force update
  static VersionCheckResult getMockForceUpdate() {
    return VersionCheckResult(
      hasUpdate: true,
      currentVersion: '1.0.1',
      latestVersion: '1.0.2',
      downloadUrl: 'https://example.com/app-release.apk',
      // Thay bằng URL thật
      isRequired: true,
      changelog: 'Critical security update. Please update immediately.',
    );
  }

  /// Mock no update
  static VersionCheckResult getMockNoUpdate() {
    return VersionCheckResult(
      hasUpdate: false,
      currentVersion: '1.0.1',
      latestVersion: '1.0.1',
      downloadUrl: '',
      isRequired: false,
      changelog: '',
    );
  }

  /// Print current app version để verify
  static Future<void> printCurrentVersion() async {
    final service = VersionCheckService();
    final currentVersion = await service.getCurrentVersion();
    logger.d('Current app version: $currentVersion');
  }
}
