import 'package:base_core/presenter/viewmodel/base_vm.dart';
import 'package:base_core/storage/storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

abstract class ScreenStateCommon<T extends StatefulWidget, V extends AppBaseViewModel> extends State<T>
    with AutomaticKeepAliveClientMixin {
  late V _viewModel;

  V get vm => _viewModel;

  NavigationService get navigator => StackedLocator.instance<NavigationService>();

  StorageService get storage => StackedLocator.instance<StorageService>();
  var isShow = false;
  var isTablet = false;

  @override
  @mustCallSuper
  void initState() {
    super.initState();
    // Default: keep the whole app in portrait. Screens that need different orientation
    // (e.g. `BarcodeScreen`) should override this via `SystemChrome.setPreferredOrientations`.
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      beforeBuild();
      setState(() {});
    });
  }



  @override
  @mustCallSuper
  Widget build(BuildContext context) {
    super.build(context);
    var smallestDimension = MediaQuery.of(context).size.shortestSide;
    isTablet = smallestDimension >= 600;
    return ViewModelBuilder<V>.reactive(
      viewModelBuilder: () {
        _viewModel = initViewModel();
        return _viewModel;
      },
      onViewModelReady: (model) => model.init(),
      builder: (context, model, child) {
        return Container(
          child: Stack(
            children: [
              initWidget(context),
            ],
          ),
          color: Colors.transparent,
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;

  V initViewModel();

  Widget initWidget(BuildContext context);

  void showLoading() {
    isShow = true;
    vm.rebuildUi();
  }

  void hideLoading() {
    isShow = false;
    vm.rebuildUi();
  }

  void back() {
    navigator.back();
  }

  void beforeBuild() {
    //do nothing
  }
}
