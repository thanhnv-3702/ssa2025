import 'package:base_core/common/config.dart';
import 'package:base_core/storage/storage.dart';
import 'package:flutter/foundation.dart' show defaultTargetPlatform, TargetPlatform;
import 'package:flutter/services.dart' show PlatformException;
import 'package:local_auth/local_auth.dart';

mixin BiometricMixin {
  final LocalAuthentication _localAuth = LocalAuthentication();

  /// Authenticate using biometric with retries. Tries up to [maxAttempts] times
  /// before returning false (fallback to password). [SETT-03] iOS: allow 3 attempts.
  Future<bool> authenticateWithRetries({
    required String reason,
    bool useErrorDialogs = true,
    bool stickyAuth = true,
  }) async {
    final bool effectiveStickyAuth = defaultTargetPlatform == TargetPlatform.android ? stickyAuth : false;

    final int maxAttemptsToUse = 3;
    for (var attempt = 1; attempt <= maxAttemptsToUse; attempt++) {
      try {
        final didAuthenticate = await authenticate(
          reason: reason,
          useErrorDialogs: useErrorDialogs,
          stickyAuth: effectiveStickyAuth,
        );
        logger.d('NEON didAuthenticate = $didAuthenticate');
        if (didAuthenticate) return true;
        if (defaultTargetPlatform == TargetPlatform.android) {
          return false;
        }

        logger.d('BiometricMixin: Attempt $attempt/$maxAttemptsToUse failed');
        if (attempt >= maxAttemptsToUse) {
          await stopAuthentication();
          return false;
        }
      } on Exception catch (e) {
        logger.e('BiometricMixin: Authentication platform error: $e');
        return false;
      }
    }
    return false;
  }

  /// Check if device supports biometric authentication
  Future<bool> isBiometricAvailable() async {
    try {
      final bool canCheckBiometrics = await _localAuth.canCheckBiometrics;
      final bool isDeviceSupported = await _localAuth.isDeviceSupported();
      return canCheckBiometrics && isDeviceSupported;
    } catch (e) {
      logger.e('BiometricMixin: Error checking biometric availability: $e');
      return false;
    }
  }

  /// Get available biometric types
  Future<List<BiometricType>> getAvailableBiometrics() async {
    try {
      return await _localAuth.getAvailableBiometrics();
    } catch (e) {
      logger.e('BiometricMixin: Error getting available biometrics: $e');
      return [];
    }
  }

  /// Check if biometric is enabled in app settings
  bool isBiometricEnabled(StorageService storage) {
    return storage.getBool(StorageKey.keyBiometricEnabled.name);
  }

  /// Enable/disable biometric authentication
  Future<void> setBiometricEnabled(StorageService storage, bool enabled) async {
    await storage.setBool(StorageKey.keyBiometricEnabled.name, enabled);
  }

  /// Authenticate using biometric
  Future<bool> authenticate({
    required String reason,
    bool useErrorDialogs = true,
    bool stickyAuth = true,
  }) async {
    try {
      final bool didAuthenticate = await _localAuth.authenticate(
        localizedReason: reason,
        options: AuthenticationOptions(
          useErrorDialogs: useErrorDialogs,
          stickyAuth: stickyAuth,
          biometricOnly: true,
        ),
      );
      return didAuthenticate;
    } on PlatformException catch (e) {
      if (e.code == 'UserCancelled') {
        rethrow;
      }
      logger.e('BiometricMixin: Authentication error: $e');
      return false;
    } catch (e) {
      logger.e('BiometricMixin: Authentication error: $e');
      return false;
    }
  }

  /// Stop any ongoing authentication
  Future<void> stopAuthentication() async {
    try {
      await _localAuth.stopAuthentication();
    } catch (e) {
      logger.e('BiometricMixin: Error stopping authentication: $e');
    }
  }
}
