import 'package:base_core/common/config.dart';
import 'package:dio/dio.dart';
import 'package:package_info_plus/package_info_plus.dart';

class VersionCheckService {
  Future<String> getCurrentVersion() async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      return packageInfo.version;
    } catch (e) {
      logger.e('VersionCheckService: Failed to get current version: $e');
      return '1.0.0';
    }
  }

  /// Compare versions and check if update is available
  Future<VersionCheckResult> checkForUpdate() async {
    try {
      final currentVersion = await getCurrentVersion();
      final latestVersion = await getLatestVersion();

      logger.d('VersionCheckService: Current version: $currentVersion, Latest version: $latestVersion');

      if (latestVersion.isEmpty) {
        return VersionCheckResult(
          hasUpdate: false,
          currentVersion: currentVersion,
          latestVersion: '',
          downloadUrl: '',
          isRequired: false,
          changelog: '',
        );
      }

      final hasUpdate = _compareVersions(currentVersion, latestVersion) < 0;
      final downloadUrl =
          'https://drive.usercontent.google.com/download?id=131F3uqDJyUTIQ7707Yp_meSvHQnjhojI&export=download&confirm=t';
      final isRequired = true;

      return VersionCheckResult(
        hasUpdate: hasUpdate,
        currentVersion: currentVersion,
        latestVersion: latestVersion,
        downloadUrl: downloadUrl,
        isRequired: isRequired,
        changelog: 'N/A',
      );
    } catch (e) {
      logger.e('VersionCheckService: Error checking for update: $e');
      return VersionCheckResult(
        hasUpdate: false,
        currentVersion: await getCurrentVersion(),
        latestVersion: '',
        downloadUrl: '',
        isRequired: false,
        changelog: '',
      );
    }
  }

  /// Compare two version strings (e.g., "1.0.1" vs "1.0.2")
  /// Returns: -1 if version1 < version2, 0 if equal, 1 if version1 > version2
  int _compareVersions(String version1, String version2) {
    final v1Parts = version1.split('.').map((e) => int.tryParse(e) ?? 0).toList();
    final v2Parts = version2.split('.').map((e) => int.tryParse(e) ?? 0).toList();

    // Pad with zeros to make same length
    while (v1Parts.length < v2Parts.length) {
      v1Parts.add(0);
    }
    while (v2Parts.length < v1Parts.length) {
      v2Parts.add(0);
    }

    for (int i = 0; i < v1Parts.length; i++) {
      if (v1Parts[i] < v2Parts[i]) return -1;
      if (v1Parts[i] > v2Parts[i]) return 1;
    }
    return 0;
  }

  /// Get latest version from Google Drive link
  /// Downloads content from: https://drive.usercontent.google.com/uc?id=1aGQGiFxMUk4qWmLJj3Ri2DA5wD_uAAtW&export=download
  /// Returns version string (e.g., "1.0.1") or empty string on error
  Future<String> getLatestVersion() async {
    const versionUrl = 'https://drive.usercontent.google.com/uc?id=1jPZCALC2PeP3HCemBdbmXPa4OY4x5xmc&export=download';
    try {
      final dio = Dio(
        BaseOptions(
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
          responseType: ResponseType.plain,
        ),
      );

      final response = await dio.get<String>(versionUrl);

      if (response.data != null && response.data!.isNotEmpty) {
        final version = response.data!.trim();
        logger.d('VersionCheckService: Latest version fetched: $version');
        return version;
      } else {
        logger.w('VersionCheckService: Empty response from version URL');
        return '';
      }
    } on DioException catch (e) {
      logger.e('VersionCheckService: Failed to fetch latest version: ${e.message}');
      if (e.response != null) {
        logger.e('VersionCheckService: Response status: ${e.response!.statusCode}');
      }
      return '';
    } catch (e) {
      logger.e('VersionCheckService: Unexpected error fetching latest version: $e');
      return '';
    }
  }
}

class VersionCheckResult {
  final bool hasUpdate;
  final String currentVersion;
  final String latestVersion;
  final String downloadUrl;
  final bool isRequired;
  final String changelog;

  VersionCheckResult({
    required this.hasUpdate,
    required this.currentVersion,
    required this.latestVersion,
    required this.downloadUrl,
    required this.isRequired,
    required this.changelog,
  });
}
