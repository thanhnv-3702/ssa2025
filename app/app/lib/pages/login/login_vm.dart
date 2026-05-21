import 'package:base_core/common/config.dart';
import 'package:base_core/presenter/viewmodel/base_vm.dart';
import 'package:saa2025/generated/app_localizations.dart';
import 'package:saa2025/pages/utils/mixin/vm_mixin.dart';
import 'package:saa2025/services/auth/auth_service.dart';
import 'package:saa2025/services/auth/google_auth_result.dart';
import 'package:stacked_services/stacked_services.dart';

class LoginVm extends AppBaseViewModel with ViewModelMixin {
  final AuthService _authService = AuthService();

  /// Google OAuth → SAA `/apis/default/api/login` → secure token storage.
  Future<void> loginWithGoogle({
    required void Function(bool) onLoading,
    required void Function(String) onToast,
    required void Function(bool isSuccess) onSuccess,
  }) async {
    onLoading(true);
    try {
      await _authService.signInWithGoogle();
      onSuccess(true);
    } on GoogleSignInCancelledException {
      onSuccess(false);
    } catch (e, st) {
      logger.e('Google login failed: $e', stackTrace: st);
      onToast(_mapErrorMessage(e));
      onSuccess(false);
    } finally {
      onLoading(false);
    }
  }

  String _mapErrorMessage(Object e) {
    final ctx = StackedService.navigatorKey?.currentContext;
    final tr = ctx != null ? AppLocalizations.of(ctx) : null;
    final text = e.toString();
    if (text.contains('id_token')) {
      return tr?.errorGoogleNotConfigured ?? 'Google Sign-In is not configured.';
    }
    if (text.contains('access_token')) {
      return tr?.errorBackendNoToken ?? 'Login failed: backend did not return a token.';
    }
    return tr?.errorGoogleLoginFailed ?? 'Google sign-in failed. Please try again.';
  }
}
