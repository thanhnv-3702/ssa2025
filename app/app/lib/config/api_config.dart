import 'package:flutter_dotenv/flutter_dotenv.dart';

/// API data source toggle — mirrors [AuthConfig] pattern.
class ApiConfig {
  ApiConfig._();

  /// When true: use in-app mock repositories (no VPN).
  static bool get useMockApi {
    const fromDefine = bool.fromEnvironment('SAA_API_MOCK', defaultValue: false);
    if (fromDefine) return true;
    final env = dotenv.maybeGet('SAA_API_MOCK')?.toLowerCase();
    if (env == 'false' || env == '0' || env == 'no') return false;
    if (env == 'true' || env == '1' || env == 'yes') return true;
    return true;
  }

  /// When false (staging): empty API results stay empty; no mock fallback.
  static bool get allowMockFallback {
    if (useMockApi) return true;
    final env = dotenv.maybeGet('SAA_API_FALLBACK')?.toLowerCase();
    return env == 'true' || env == '1' || env == 'yes';
  }
}
