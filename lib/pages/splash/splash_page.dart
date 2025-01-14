import 'package:example/common/widget_components/app_bar_custom.dart';
import 'package:example/import.dart';
import 'package:example/pages/splash/component/confetti.dart';
import 'package:example/pages/splash/component/custom_spin.dart';
import 'package:example/pages/splash/splash_controller.dart';

class SplashPage extends BaseScreen<SplashController> {
  SplashPage({super.key});

  @override
  Widget builder() {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBarCustom(
        titleAppBar: 'a',
      ),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Positioned(
            bottom: -(width / 4),
            child: Stack(
              alignment: Alignment.center,
              children: [
                _buildSpin(width),
                _buildCenterSpin(width),
              ],
            ),
          ),
          SizedBox.expand(
            child: Obx(
              () => Visibility(
                visible: controller.showConfetti.value,
                child: IgnorePointer(
                  child: Confetti(
                    isStopped: controller.showConfetti.value,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
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
