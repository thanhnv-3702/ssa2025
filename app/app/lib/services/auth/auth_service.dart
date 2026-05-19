import 'dart:async';

import 'package:base_core/common/config.dart';
import 'package:base_core/domain/repository/resource.dart';
import 'package:base_core/storage/storage.dart';
import 'package:https/vn/sun/https/domain/model/account_entity.dart';
import 'package:https/vn/sun/https/domain/usecase/user_usecase.dart';
import 'package:https/vn/sun/https/inject/injection.dart';
import 'package:saa2025/config/auth_config.dart';
import 'package:saa2025/pages/app_pages.locator.dart';
import 'package:saa2025/services/auth/auth_session_store.dart';
import 'package:saa2025/services/auth/google_auth_result.dart';
import 'package:saa2025/services/auth/google_auth_service.dart';
import 'package:saa2025/services/fcm_service.dart';

/// Orchestrates Google Sign-In → SAA backend token exchange → secure session.
class AuthService {
  AuthService({
    GoogleAuthService? googleAuth,
    UserCase? userCase,
    StorageService? storage,
  })  : _googleAuth = googleAuth ?? GoogleAuthService(),
        _userCase = userCase ?? getIt<UserCase>(),
        _storage = storage ?? locator<StorageService>(),
        _sessionStore = AuthSessionStore(storage ?? locator<StorageService>());

  final GoogleAuthService _googleAuth;
  final UserCase _userCase;
  final StorageService _storage;
  final AuthSessionStore _sessionStore;

  /// Full sign-in: Google (or mock) → POST `/apis/default/api/login` → persist tokens.
  Future<AccountEntity> signInWithGoogle() async {
    final google = await _googleAuth.signIn();
    final account = AuthConfig.useMockAuth
        ? await _exchangeMock(google)
        : await _exchangeWithBackend(google);

    if (account.accessToken == null || account.accessToken!.isEmpty) {
      throw StateError('Backend did not return access_token');
    }

    await _sessionStore.save(account: account, google: google);
    await FcmService.instance.getAndSaveToken(_storage);
    logger.d('AuthService: session saved for ${google.email ?? account.username}');
    return account;
  }

  Future<void> signOut() async {
    await _googleAuth.signOut();
    await _sessionStore.clear();
  }

  Future<AccountEntity> _exchangeWithBackend(GoogleAuthResult google) async {
    final completer = Completer<AccountEntity>();

    _userCase.loginWithGoogle(
      idToken: google.idToken,
      email: google.email,
      displayName: google.displayName,
      googleAccessToken: google.accessToken,
      callBack: (event) {
      if (event is Loading) return;

      if (event is Success) {
        final data = event.data;
        if (data is AccountEntity) {
          completer.complete(data);
        } else {
          completer.completeError(StateError('Invalid login response'));
        }
        return;
      }

      if (event is Notify) {
        completer.completeError(StateError(event.message?.toString() ?? 'Login failed'));
        return;
      }

      if (event is Failed) {
        completer.completeError(StateError(event.error?.toString() ?? 'Login failed'));
        return;
      }

      if (event is Exception) {
        completer.completeError(event);
      }
      },
    );

    return completer.future;
  }

  Future<AccountEntity> _exchangeMock(GoogleAuthResult google) async {
    await Future<void>.delayed(const Duration(milliseconds: 350));
    final ts = DateTime.now().millisecondsSinceEpoch;
    logger.d('AuthService: mock BE login for ${google.email}');
    return AccountEntity(
      'mock_saa_access_$ts',
      'Bearer',
      3600,
      1,
      'sunner',
      google.displayName ?? google.email?.split('@').first ?? 'demo.sunner',
      'mock_saa_refresh_$ts',
      null,
      google.email,
      google.displayName,
    );
  }
}
