import 'package:example/common/widget_components/loading/custom_loading.dart';
import 'package:example/import.dart';

class LoadingWrapper extends BaseScreen<LoadingController> {
  LoadingWrapper({super.key, this.child});

  final Widget? child;
  @override
  Widget builder() {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(children: <Widget>[
          child ?? const SizedBox(),
          Obx(
            () => Visibility(
              visible: controller.loadingCtrl.value,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: ColoredBox(
                      color: const Color(0xFF131615).withValues(alpha: 0.2),
                    ),
                  ),
                  _buildLoading()
                ],
              ),
            ),
          )
        ]));
  }

  Widget _buildLoading() {
    return CustomLoading(
        color: appThemes.mainColor, type: CustomLoadingType.start);
  }

  @override
  LoadingController? putController() {
    return LoadingController();
  }
}

class LoadingController extends BaseController {
  RxBool loadingCtrl = false.obs;

  void show() {
    loadingCtrl.value = true;
    update();
  }

  void hide() {
    loadingCtrl.value = false;
    update();
  }

  void hideAll() {
    loadingCtrl.value = false;
    update();
  }
}
