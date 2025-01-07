import 'package:example/import.dart';
import 'package:example/pages/splash/splash_controller.dart';

class SplashPage extends BaseScreen<SplashController> {
  SplashPage({super.key});

  @override
  Widget builder() {
    return Image.asset(
      AssetImages.imageSplash,
      fit: BoxFit.cover,
      gaplessPlayback: true,
    );
  }

  @override
  SplashController? putController() => SplashController();
}
