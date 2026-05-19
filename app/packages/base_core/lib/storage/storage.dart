import 'package:base_core/common/config.dart';
import 'package:base_core/storage/secure_storage_service.dart';
import 'package:base_core/storage/storage_service.interface.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

enum StorageKey {
  keySelectedEnv,
  keyBiometricPassword,
  keyUserName,
  keyPatientId,
  keyPatientPubId,
  keyName,
  keyEmail,
  keyPhone,
  keyTitle,
  keyOptTime,
  keyToken,
  keyAccount,
  keyPrivateToken,
  keyBiometricEnabled,
  keyLastActiveTime,
  keyRegistrationKey,
  keySelectedLanguage,
  keyNotificationEnabled,
  keyFCMToken,
}

class StorageService with ListenableServiceMixin implements IStorageService {
  final _token = ReactiveValue<String?>(null);
  final _privateToken = ReactiveValue<String?>('N/A');

  StorageService() {
    listenToReactiveValues([_token, _privateToken]);
  }

  late final SharedPreferences _prefs;
  final SecureStorageService _secureStorage = SecureStorageService.instance;

  Future<StorageService> init() async {
    _prefs = await SharedPreferences.getInstance();
    await _secureStorage.init();
    _token.value = await _secureStorage.getAccessToken();
    _privateToken.value = await _secureStorage.getRefreshToken() ?? 'N/A';
    return this;
  }

  @override
  Future<void> setToken({required String userToken}) async {
    await _secureStorage.saveAccessToken(userToken);
    _token.value = userToken;
  }

  @override
  Future<void> setPrivateToken({required String privateToken}) async {
    await _secureStorage.saveRefreshToken(privateToken);
    _privateToken.value = privateToken;
  }

  @override
  String? getToken() {
    return _token.value;
  }

  @override
  Future<bool> setString(String key, String value) async {
    return await _prefs.setString(key, value);
  }

  @override
  Future<bool> setBool(String key, bool value) async {
    return await _prefs.setBool(key, value);
  }

  @override
  Future<bool> setList(String key, List<String> value) async {
    return await _prefs.setStringList(key, value);
  }

  @override
  Future<bool> setInt(String key, int value) async {
    return await _prefs.setInt(key, value);
  }

  @override
  String? getString(String key) {
    return _prefs.getString(key);
  }

  @override
  bool getBool(String key, {bool defaultValue = false}) {
    return _prefs.getBool(key) ?? defaultValue;
  }

  @override
  bool checkKey(String key) {
    return _prefs.containsKey(key);
  }

  @override
  List<String> getList(String key, {List<String>? defaultValue}) {
    return _prefs.getStringList(key) ?? defaultValue ?? [];
  }

  @override
  int? getInt(String key) {
    return _prefs.getInt(key);
  }

  @override
  Future<bool> remove(String key) async {
    logger.d('[remove] key = $key');
    return await _prefs.remove(key);
  }

  @override
  void removeToken() async {
    await _secureStorage.deleteTokens();
    _token.value = null;
    _privateToken.value = 'N/A';
  }

  @override
  Future<bool> clear() async {
    final envValue = _prefs.getString(StorageKey.keySelectedEnv.name);
    await _secureStorage.deleteAll();
    _token.value = null;
    _privateToken.value = 'N/A';
    await _prefs.clear();
    if (envValue != null && envValue.isNotEmpty) {
      await _prefs.setString(StorageKey.keySelectedEnv.name, envValue);
    }
    return true;
  }

  @override
  String getPrivateToken() => _privateToken.value ?? 'N/A';

  @override
  Future clearAll() async {
    await _secureStorage.deleteAll();
    await _prefs.remove(StorageKey.keyAccount.name);
    _token.value = null;
    _privateToken.value = 'N/A';
  }

  Future clearAllForBiometric() async {
    await _secureStorage.deleteAll(isAll: false);
    _token.value = null;
    _privateToken.value = 'N/A';
  }

  /// Save password securely (for biometric login)
  Future<void> savePasswordSecurely(String password) async {
    await _secureStorage.savePassword(password);
  }

  /// Get password securely (for biometric login)
  Future<String?> getPasswordSecurely() async {
    final password = await _secureStorage.getPassword();
    return password;
  }

  /// Delete password securely
  Future<void> deletePasswordSecurely(String key) async {
    await _secureStorage.deletePassword(key);
  }
}
