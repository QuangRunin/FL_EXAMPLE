import 'package:example/common/widget_components/app_bar_custom.dart';
import 'package:example/common/widget_components/button/widget_button.dart';
import 'package:example/common/widget_components/input_field/widget_input_text.dart';
import 'package:example/import.dart';
import 'package:example/pages/splash/component/confetti.dart';
import 'package:example/pages/splash/component/custom_spin.dart';
import 'package:example/pages/splash/splash_controller.dart';
import 'package:example/pages/splash/test.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SplashPage extends BaseScreen<SplashController> {
  SplashPage({super.key});

  @override
  Widget builder() {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBarCustom(
        titleAppBar: 'a',
      ),
      body: Padding(
          padding: const EdgeInsets.all(20),
          child: GetBuilder<SplashController>(builder: (xController) {
            return Form(
              key: xController.formKey,
              autovalidateMode: xController.autovalidateMode.value,
              child: Column(children: [
                WidgetInputText(
                  hintText: 'Test',
                  title: 'aaa',
                  isRequired: true,
                  onChanged: (p0) {
                    print(p0);
                  },
                  validator: (p0) {
                    if ((p0 ?? '').isEmpty) return "aa";
                    return null;
                  },
                ),
                WidgetInputText(
                  hintText: 'Test1',
                  title: 'bbbb',
                  isRequired: true,
                  onChanged: (p0) {
                    print(p0);
                  },
                  validator: (p0) {
                    if ((p0 ?? '').isEmpty)
                      return "CCCC bbbb bbbb bbbb bbbb bbbb bbbb bbbbbbbbbbbbVbbbb VVVbbbbbbbbVbbbb bbbbbbbb";
                    return null;
                  },
                ),
                WidgetButton(
                  title: 'Test',
                  onClick: () {
                    controller.formKey.currentState?.validate();
                    controller.activeValidateMode();
                  },
                  margin: const EdgeInsets.only(top: 10),
                ),
              ]),
            );
          })),
    );
  }

  Widget _buildSpin(double width) {
    return Obx(
      () => Transform.rotate(
        angle: controller.rotationAngle.value,
        child: CustomPaint(
          size: Size(width * 1.2, width * 1.2),
          painter: SpinPainter(data: controller.data),
        ),
      ),
    );
  }

  Widget _buildCenterSpin(double width) {
    return Positioned(
      top: (width * 1.2 / 2) - 46,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: controller.spinWheel,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(AssetIcons.spinArrow, width: 70, color: color.white),
            Positioned(
              bottom: 3,
              child: Container(
                width: 45,
                height: 45,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.deepOrange,
                  border: Border.all(color: color.redColor, width: 2),
                ),
                child: Text(
                  "SPIN",
                  style: textStyle.bold(size: 12, color: color.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  SplashController? putController() => SplashController();
}

class NoPasteControls extends MaterialTextSelectionControls {
  @override
  Future<void> handlePaste(TextSelectionDelegate delegate) async {}
}
