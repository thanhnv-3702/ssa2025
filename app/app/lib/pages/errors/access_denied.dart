import 'package:base_core/presenter/base_screen_state.dart';
import 'package:flutter/material.dart';
import 'package:saa2025/pages/errors/access_denied_screen.dart';
import 'package:saa2025/pages/errors/error_navigation.dart';
import 'package:saa2025/pages/errors/error_vm.dart';
import 'package:saa2025/pages/utils/mixin/ui_mixin.dart';

/// Access denied — MoMorph `k-7zJk2B7s`.
class AccessDeniedState extends StatefulWidget {
  const AccessDeniedState({super.key});

  @override
  State<StatefulWidget> createState() => AccessDeniedPage();
}

class AccessDeniedPage extends BaseScreenState<AccessDeniedState, ErrorVm> with UIMixin {
  @override
  ErrorVm initViewModel() => ErrorVm();

  @override
  Widget initWidget(BuildContext context) => AccessDeniedScreen(this, context).screen();

  void onBack() {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    } else {
      goToHomeFromError();
    }
  }

  void onGoHome() => goToHomeFromError();
}
