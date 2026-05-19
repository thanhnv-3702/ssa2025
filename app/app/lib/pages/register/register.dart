import 'package:base_core/presenter/base_screen_state.dart';
import 'package:flutter/material.dart';
import 'package:saa2025/pages/register/register_vm.dart';

import '../utils/mixin/ui_mixin.dart';
import 'register_screen.dart';

class RegisterState extends StatefulWidget {
  final String email;

  const RegisterState({super.key, required this.email});

  @override
  State<StatefulWidget> createState() => Register();
}

class Register extends BaseScreenState<RegisterState, RegisterVm> with UIMixin {
  final TextEditingController edtEmailController = TextEditingController();
  bool isAgree = false;
  bool isEmailValid = true;
  String errorEmail = '';

  @override
  void beforeBuild() {
    edtEmailController.text = widget.email;
  }

  @override
  RegisterVm initViewModel() => RegisterVm();

  @override
  Widget initWidget(BuildContext context) => RegisterScreen(this, context).screen();

  void toggleAgree() {
    setState(() => isAgree = !isAgree);
  }

  @override
  void dispose() {
    edtEmailController.dispose();
    super.dispose();
  }
}
