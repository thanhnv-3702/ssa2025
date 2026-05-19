import 'package:base_core/common/config.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:saa2025/config/auth_config.dart';
import 'package:saa2025/services/auth/google_auth_result.dart';

/// Wraps [GoogleSignIn] — real OAuth or deterministic mock for local dev.
class GoogleAuthService {
  GoogleAuthService({GoogleSignIn? googleSignIn}) : _googleSignIn = googleSignIn ?? _createGoogleSignIn();

  final GoogleSignIn _googleSignIn;

  static GoogleSignIn _createGoogleSignIn() {
    final serverClientId = AuthConfig.serverClientId;
    return GoogleSignIn(
      scopes: const ['email', 'profile'],
      serverClientId: serverClientId.isEmpty ? null : serverClientId,
    );
  }

  Future<GoogleAuthResult> signIn() async {
    if (AuthConfig.useMockAuth) {
      logger.d('GoogleAuthService: mock sign-in');
      return const GoogleAuthResult(
        idToken: 'mock_google_id_token_saa2025',
        email: 'sunner.demo@sun-asterisk.com',
        displayName: 'Sunner Demo',
      );
    }

    final account = await _googleSignIn.signIn();
    if (account == null) {
      throw GoogleSignInCancelledException();
    }

    final auth = await account.authentication;
    final idToken = auth.idToken;
    if (idToken == null || idToken.isEmpty) {
      throw StateError('Google did not return an id_token. Check GOOGLE_SERVER_CLIENT_ID.');
    }

    return GoogleAuthResult(
      idToken: idToken,
      accessToken: auth.accessToken,
      email: account.email,
      displayName: account.displayName,
      photoUrl: account.photoUrl,
    );
  }

  Future<void> signOut() async {
    if (AuthConfig.useMockAuth) return;
    try {
      await _googleSignIn.signOut();
    } catch (e) {
      logger.w('Google sign-out: $e');
    }
  }
}
