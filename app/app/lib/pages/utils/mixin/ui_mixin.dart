import 'package:base_core/common/base_const.dart';
import 'package:base_core/presenter/base_screen_state.dart';
import 'package:base_core/presenter/viewmodel/base_vm.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:saa2025/pages/utils/error_message_map.dart';
import 'package:saa2025/pages/utils/extension.dart';
import 'package:saa2025/pages/utils/utils.dart';
import 'package:saa2025/pages/widgets/custom_loading_widget.dart';

mixin UIMixin<T extends StatefulWidget, V extends AppBaseViewModel> on BaseScreenState<T, V> {
  void handleToast(String error) {
    if (error == BaseConst.systemError) {
      Utils.showToast(tr.systemError);
    } else if (error == BaseConst.unknownError) {
      Utils.showToast(tr.systemError);
    } else {
      final String message = getErrorMessage(error);
      Utils.showToast(message);
    }
  }

  void handleLoading(bool isShowing) {
    if (isShowing) {
      EasyLoading.instance.loadingStyle = EasyLoadingStyle.light;
      EasyLoading.show(
        maskType: EasyLoadingMaskType.black,
        dismissOnTap: false,
        indicator: const CustomLoadingWidget(),
      );
    } else {
      EasyLoading.dismiss();
    }
  }
}
