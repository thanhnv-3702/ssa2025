import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:saa2025/config/api_config.dart';
import 'package:saa2025/config/auth_config.dart';

/// Runtime environment — `Utils.setEnvPath` loads matching dotenv file.
class AppEnvironment {
  AppEnvironment._();

  static String get name =>
      dotenv.maybeGet('ENV')?.trim().toLowerCase() ?? const String.fromEnvironment('ENV', defaultValue: 'dev');

  static bool get isDev => name == 'dev' || name.isEmpty;

  static bool get isStaging => name == 'stag' || name == 'staging';

  static bool get isProd => name == 'prod' || name == 'production';

  /// Staging/prod: real Google + real API (no mock).
  static bool get useRealAuth => isStaging || isProd;

  static bool get useRealApi => isStaging || isProd;

  /// Effective flags after .env overrides.
  static bool get authMockEnabled => AuthConfig.useMockAuth;

  static bool get apiMockEnabled => ApiConfig.useMockApi;

  static String get baseUrl => dotenv.maybeGet('BASE_URL')?.trim() ?? '';

  static String get summary => 'env=$name mockAuth=$authMockEnabled mockApi=$apiMockEnabled base=$baseUrl';
}
