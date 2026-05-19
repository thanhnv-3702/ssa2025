import 'package:base_core/common/config.dart';
import 'package:base_core/presenter/viewmodel/base_vm.dart';
import 'package:saa2025/pages/utils/mixin/vm_mixin.dart';
import 'package:saa2025/services/auth/auth_service.dart';
import 'package:saa2025/services/auth/google_auth_result.dart';

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
    final text = e.toString();
    if (text.contains('id_token')) {
      return 'Google Sign-In chưa cấu hình. Đặt SAA_AUTH_MOCK=true hoặc GOOGLE_SERVER_CLIENT_ID.';
    }
    if (text.contains('access_token')) {
      return 'Đăng nhập thất bại: backend không trả token.';
    }
    return 'Đăng nhập Google thất bại. Vui lòng thử lại.';
  }
}
