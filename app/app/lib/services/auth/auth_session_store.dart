import 'package:base_core/storage/storage.dart';
import 'package:https/vn/sun/https/domain/model/account_entity.dart';
import 'package:saa2025/services/auth/google_auth_result.dart';

/// Persists tokens and profile fields after successful login.
class AuthSessionStore {
  const AuthSessionStore(this._storage);

  final StorageService _storage;

  Future<void> save({
    required AccountEntity account,
    GoogleAuthResult? google,
  }) async {
    final access = account.accessToken;
    if (access != null && access.isNotEmpty) {
      await _storage.setToken(userToken: access);
    }

    final refresh = account.refreshToken;
    if (refresh != null && refresh.isNotEmpty) {
      await _storage.setPrivateToken(privateToken: refresh);
    }

    final username = account.username;
    if (username != null && username.isNotEmpty) {
      await _storage.setString(StorageKey.keyUserName.name, username);
    }

    final email = account.email ?? google?.email;
    if (email != null && email.isNotEmpty) {
      await _storage.setString(StorageKey.keyEmail.name, email);
    }

    final name = account.displayName ?? google?.displayName;
    if (name != null && name.isNotEmpty) {
      await _storage.setString(StorageKey.keyName.name, name);
    }

    if (account.registrationKey != null) {
      await _storage.setString(StorageKey.keyRegistrationKey.name, account.registrationKey!);
    }
  }

  Future<void> clear() async {
    _storage.removeToken();
    await _storage.clearAllForBiometric();
  }
}
