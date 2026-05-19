import 'package:base_core/presenter/base_screen_state.dart';
import 'package:flutter/material.dart';
import 'package:saa2025/pages/errors/error_navigation.dart';
import 'package:saa2025/pages/errors/error_vm.dart';
import 'package:saa2025/pages/errors/not_found_screen.dart';
import 'package:saa2025/pages/utils/mixin/ui_mixin.dart';

/// Not Found — MoMorph `sn2mdavs1a`.
class NotFoundState extends StatefulWidget {
  const NotFoundState({super.key});

  @override
  State<StatefulWidget> createState() => NotFoundPage();
}

class NotFoundPage extends BaseScreenState<NotFoundState, ErrorVm> with UIMixin {
  @override
  ErrorVm initViewModel() => ErrorVm();

  @override
  Widget initWidget(BuildContext context) => NotFoundScreen(this, context).screen();

  void onBack() {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    } else {
      goToHomeFromError();
    }
  }

  void onGoHome() => goToHomeFromError();
}
