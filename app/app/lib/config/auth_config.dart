import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Auth configuration — reads from `packages/https/.env` (loaded in [main]).
class AuthConfig {
  AuthConfig._();

  /// When true: mock Google account + mock BE token response (no VPN required).
  static bool get useMockAuth {
    const fromDefine = bool.fromEnvironment('SAA_AUTH_MOCK', defaultValue: false);
    if (fromDefine) return true;
    final env = dotenv.maybeGet('SAA_AUTH_MOCK')?.toLowerCase();
    return env == 'true' || env == '1' || env == 'yes';
  }

  /// OAuth 2.0 web client ID (server) for [GoogleSignIn.serverClientId].
  static String get serverClientId => dotenv.maybeGet('GOOGLE_SERVER_CLIENT_ID')?.trim() ?? '';

  static const String googleProvider = 'google';
}
