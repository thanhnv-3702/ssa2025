import 'package:base_core/common/config.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Secure storage service for sensitive data (passwords, tokens)
/// Uses platform-specific secure storage:
/// - Android: EncryptedSharedPreferences (encrypted with Android Keystore)
/// - iOS: Keychain Services
class SecureStorageService {
  static SecureStorageService? _instance;

  static SecureStorageService get instance {
    _instance ??= SecureStorageService._();
    return _instance!;
  }

  SecureStorageService._();

  late FlutterSecureStorage _storage;

  /// Initialize secure storage with platform-specific options
  Future<void> init() async {
    _storage = FlutterSecureStorage(
      aOptions: AndroidOptions(
        encryptedSharedPreferences: true,
        resetOnError: true,
        sharedPreferencesName: 'secure_storage_prefs',
        preferencesKeyPrefix: 'saa2025_',
      ),
      iOptions: IOSOptions(
        accessibility: KeychainAccessibility.first_unlock_this_device,
        synchronizable: false,
      ),
    );
  }

  /// Save password securely
  Future<void> savePassword(String password) async {
    try {
      await _storage.write(key: 'password_for_biometric', value: password);
    } catch (e) {
      logger.e('SecureStorageService: Failed to save password: $e');
      rethrow;
    }
  }

  /// Get password securely
  Future<String?> getPassword() async {
    try {
      final password = await _storage.read(key: 'password_for_biometric');
      return password;
    } catch (e) {
      logger.e('SecureStorageService: Failed to get password: $e');
      return null;
    }
  }

  /// Delete password
  Future<void> deletePassword(String key) async {
    try {
      await _storage.delete(key: key);
      logger.d('SecureStorageService: Password deleted with key: $key');
    } catch (e) {
      logger.e('SecureStorageService: Failed to delete password: $e');
    }
  }

  /// Save access token securely
  Future<void> saveAccessToken(String token) async {
    try {
      await _storage.write(key: 'access_token', value: token);
      logger.d('SecureStorageService: Access token saved');
    } catch (e) {
      logger.e('SecureStorageService: Failed to save access token: $e');
      rethrow;
    }
  }

  /// Get access token securely
  Future<String?> getAccessToken() async {
    try {
      return await _storage.read(key: 'access_token');
    } catch (e) {
      logger.e('SecureStorageService: Failed to get access token: $e');
      return null;
    }
  }

  /// Save refresh token securely
  Future<void> saveRefreshToken(String token) async {
    try {
      await _storage.write(key: 'refresh_token', value: token);
      logger.d('SecureStorageService: Refresh token saved');
    } catch (e) {
      logger.e('SecureStorageService: Failed to save refresh token: $e');
      rethrow;
    }
  }

  /// Get refresh token securely
  Future<String?> getRefreshToken() async {
    try {
      return await _storage.read(key: 'refresh_token');
    } catch (e) {
      logger.e('SecureStorageService: Failed to get refresh token: $e');
      return null;
    }
  }

  /// Delete all tokens
  Future<void> deleteTokens() async {
    try {
      await _storage.delete(key: 'access_token');
      await _storage.delete(key: 'refresh_token');
      logger.d('SecureStorageService: Tokens deleted');
    } catch (e) {
      logger.e('SecureStorageService: Failed to delete tokens: $e');
    }
  }

  /// Delete all secure data
  Future<void> deleteAll({bool isAll = true}) async {
    try {
      if (isAll) {
        await _storage.deleteAll();
      } else {
        final password = await getPassword();
        await _storage.deleteAll();
        if (password != null) {
          await savePassword(password);
        }
      }
      logger.d('SecureStorageService: All secure data deleted');
    } catch (e) {
      logger.e('SecureStorageService: Failed to delete all: $e');
    }
  }

  /// Check if key exists
  Future<bool> containsKey(String key) async {
    try {
      final value = await _storage.read(key: key);
      return value != null;
    } catch (e) {
      logger.e('SecureStorageService: Failed to check key $key: $e');
      return false;
    }
  }
}
