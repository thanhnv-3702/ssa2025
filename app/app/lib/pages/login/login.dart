import 'package:base_core/presenter/base_screen_state.dart';
import 'package:base_core/storage/storage.dart';
import 'package:flutter/material.dart';
import 'package:saa2025/pages/app_pages.router.dart';
import 'package:saa2025/pages/login/login_vm.dart';
import 'package:saa2025/pages/utils/extension.dart';
import 'package:saa2025/pages/utils/utils.dart';
import 'package:saa2025/pages/widgets/saa_language_sheet.dart';

import '../utils/mixin/ui_mixin.dart';
import 'login_screen.dart';

enum LoginRootBack { root, previous }

enum LoginLanguage { vn, en, ja }

extension LoginLanguageX on LoginLanguage {
  String get code {
    switch (this) {
      case LoginLanguage.vn:
        return 'VN';
      case LoginLanguage.en:
        return 'EN';
      case LoginLanguage.ja:
        return 'JA';
    }
  }

  Locale get locale {
    switch (this) {
      case LoginLanguage.vn:
        return const Locale('vi');
      case LoginLanguage.en:
        return const Locale('en');
      case LoginLanguage.ja:
        return const Locale('ja');
    }
  }
}

class LoginState extends StatefulWidget {
  final LoginRootBack rootBack;

  const LoginState({super.key, required this.rootBack});

  @override
  State<StatefulWidget> createState() => Login();
}

class Login extends BaseScreenState<LoginState, LoginVm> with UIMixin {
  LoginLanguage _language = LoginLanguage.en;
  bool _isGoogleLoginInProgress = false;

  String get selectedLanguageCode => _language.code;

  String get descriptionText => tr.loginDescription;

  String get copyrightText => tr.loginCopyright;

  String get googleButtonLabel => tr.loginGoogleButton;

  bool get isGoogleLoginInProgress => _isGoogleLoginInProgress;

  @override
  LoginVm initViewModel() => LoginVm();

  @override
  void beforeBuild() {
    _loadSavedLanguage();
  }

  void _loadSavedLanguage() {
    final saved = storage.getString(StorageKey.keySelectedLanguage.name);
    if (saved == null) return;
    final match = LoginLanguage.values.where((l) => l.locale.languageCode == saved);
    if (match.isNotEmpty) {
      _language = match.first;
    }
  }

  @override
  Widget initWidget(BuildContext context) => LoginScreen(this, context).screen();

  void onLanguageTap() {
    showSaaLanguageSheet(
      context: context,
      currentCode: _language.code,
      onLanguageChanged: (code) {
        final lang = LoginLanguage.values.firstWhere((l) => l.code == code);
        setState(() => _language = lang);
      },
    );
  }

  Future<void> onGoogleLoginTap() async {
    if (_isGoogleLoginInProgress) return;
    setState(() => _isGoogleLoginInProgress = true);

    await vm.loginWithGoogle(
      onLoading: (loading) {
        if (mounted) setState(() => _isGoogleLoginInProgress = loading);
      },
      onToast: handleToast,
      onSuccess: (isSuccess) {
        if (!isSuccess) return;
        Utils.showToast(tr.errorLoginSuccess, isSuccess: true);
        navigator.clearStackAndShow(Routes.mainTabState);
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
