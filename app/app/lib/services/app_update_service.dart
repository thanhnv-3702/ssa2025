import 'dart:io';

import 'package:base_core/common/config.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

const _installApkChannel = MethodChannel('com.sunasterisk.saa2025/install_apk');

class AppUpdateService {
  final Dio _dio = Dio();

  /// Download APK from URL and install it
  Future<bool> downloadAndInstall({
    required String version,
    required String downloadUrl,
    required Function(double progress) onProgress,
    required Function(String error) onError,
  }) async {
    try {
      // Request install permission for Android 8.0+
      if (Platform.isAndroid) {
        final status = await Permission.requestInstallPackages.request();
        if (!status.isGranted) {
          onError('Install permission denied');
          return false;
        }
      }

      // Use app cache on Android so FileProvider can expose the file (content:// URI required on Android 7+)
      var downloadDir = '';
      if (Platform.isAndroid) {
        final dir = await getTemporaryDirectory();
        downloadDir = dir.path;
      } else if (Platform.isIOS) {
        try {
          final dir = await getApplicationDocumentsDirectory();
          final subdir = Directory('${dir.path}/SAA2025');
          if (!await subdir.exists()) await subdir.create(recursive: true);
          downloadDir = subdir.path;
        } catch (e, st) {
          logger.w('Save to Documents (iOS) failed', error: e, stackTrace: st);
        }
      }

      final fileName = 'saa2025_update_$version.apk';
      final filePath = '$downloadDir/$fileName';
      await _dio.download(
        downloadUrl,
        filePath,
        onReceiveProgress: (received, total) {
          if (total > 0) {
            final progress = received / total;
            onProgress(progress);
            logger.d('AppUpdateService: Download progress: ${(progress * 100).toStringAsFixed(1)}%');
          }
        },
        options: Options(
          receiveTimeout: const Duration(minutes: 10),
          followRedirects: true,
          validateStatus: (status) => status! < 500,
        ),
      );

      logger.d('AppUpdateService: Download completed. Installing...');

      if (Platform.isAndroid) {
        // Use native install (FileProvider content URI) so installer accepts the file on Android 7+
        try {
          await _installApkNative(filePath);
          logger.d('AppUpdateService: APK installation started via native');
          return true;
        } catch (e) {
          logger.w('AppUpdateService: Native install failed, trying OpenFilex: $e');
        }
        // Fallback: open_filex may use its own FileProvider
        final result = await OpenFilex.open(filePath);
        if (result.type == ResultType.done) {
          logger.d('AppUpdateService: APK installation started via OpenFilex');
          return true;
        }
        onError(result.message);
        return false;
      }

      return false;
    } catch (e) {
      logger.e('AppUpdateService: Error downloading/installing APK: $e');
      onError(e.toString());
      return false;
    }
  }

  Future<void> _installApkNative(String path) async {
    await _installApkChannel.invokeMethod<void>('installApk', <String, dynamic>{'path': path});
  }

  /// Check if app can install APK (Android only)
  Future<bool> canInstallApk() async {
    if (!Platform.isAndroid) {
      return false;
    }
    final status = await Permission.requestInstallPackages.status;
    return status.isGranted;
  }
}
