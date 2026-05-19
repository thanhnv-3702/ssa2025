import 'package:base_core/presenter/base_screen_state.dart';
import 'package:flutter/cupertino.dart';

abstract class BaseScreen<T extends BaseScreenState> {
  final T main;
  final BuildContext context;

  BaseScreen(this.main, this.context);

  Widget screen();
}
