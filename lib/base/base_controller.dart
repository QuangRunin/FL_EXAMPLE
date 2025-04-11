import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:example/base/base_common_widgets.dart';
import 'package:example/base/cache_manager.dart';
import 'package:example/base/loading_wrapper.dart';
import 'package:example/controller/controller_manager.dart';
import 'package:example/import.dart';

export 'package:flutter/material.dart';

abstract class BaseController extends GetxController
    with CacheManager, BaseCommonWidgets {
  LoadingController get loading => Get.find<LoadingController>();
  RxBool pageLoading = false.obs;
  Rx<AutovalidateMode> autovalidateMode = AutovalidateMode.disabled.obs;

  @override
  void onInit() {
    ControllerManager().currentController.value = Get.currentRoute;
    hideKeyBoard();
    //debugPrint('BaseController');
    super.onInit();
  }

  @override
  void onReady() {
    //debugPrint('onReady');
    super.onReady();
  }

  @override
  void onClose() {
    ControllerManager().handleOnClose(runtimeType.toString());
    hideLoading();
  }

  void onResumed() {}

  Future<void> showLoading() async {
    FocusManager.instance.primaryFocus?.unfocus();
    loading.show();
  }

  void showLoadingWhenInit() {
    SchedulerBinding.instance.addPostFrameCallback((_) => loading.show());
  }

  Future<void> hideLoading() async {
    await 0.01.seconds.delay();
    loading.hide();
  }

  void showLoadingPage() {
    pageLoading.value = true;
  }

  void hideLoadingPage() {
    pageLoading.value = false;
  }

  void hideKeyBoard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  void hideInput() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }

  Future<void> delayHideLoading() async {
    await 0.1.seconds.delay();
    hideLoading();
  }

  void activeValidateMode() {
    autovalidateMode.value = AutovalidateMode.always;
    update();
  }

  @override
  void dispose() {
    pageLoading.value = false;
    loading.hideAll();
    hideKeyBoard();
    super.dispose();
  }
}
