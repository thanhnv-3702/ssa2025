import 'package:base_core/presenter/screen_state_common.dart';
import 'package:base_core/presenter/viewmodel/base_vm.dart';
import 'package:flutter/cupertino.dart';

abstract class BaseScreenState<T extends StatefulWidget, V extends AppBaseViewModel> extends ScreenStateCommon<T, V> {}
