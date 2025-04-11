import 'package:example/common/widget_components/animated_list/widget_animated_list.dart';
import 'package:example/common/widget_components/app_bar_custom.dart';
import 'package:example/common/widget_components/button/widget_button.dart';
import 'package:example/common/widget_components/image/widget_network_image.dart';
import 'package:example/common/widget_components/smart_scroll/smart_scroll_widget.dart';
import 'package:example/import.dart';
import 'package:example/pages/splash/splash_controller.dart';

class SplashPage extends BaseScreen<SplashController> with SmartLoadListWidget {
  SplashPage({super.key});

  @override
  Widget builder() {
    return Scaffold(
      appBar: AppBarCustom(
        titleAppBar: 'aaaa',
      ),
      body: Column(
        children: [
          buildSmartListExpanded(
            controller,
            enablePullDown: true,
            enablePullUp: true,
            child: Obx(
              () => WidgetAnimatedList(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.items.length,
                animType: AnimationType.slide,
                padding: EdgeInsets.only(bottom: kBottomNavigationBarHeight),
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.red.shade100,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      spacing: 10,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Title $index',
                              style: textStyle.bold(size: 16),
                            ),
                            Flexible(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 16),
                                child: Text(
                                  'Description $index',
                                  style: textStyle.regular(size: 14),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          'Reloaded 1 of 2354 libraries in 583ms (compile: 16 ms, reload: 105 ms, reassemble: 363 ms). Reloaded 1 of 2354 libraries in 583ms (compile: 16 ms, reload: 105 ms, reassemble: 363 ms).',
                          style: textStyle.regular(
                            size: 12,
                            color: color.color999999,
                          ),
                        ),
                        WidgetNetworkImage(
                          imageUrl:
                              'https://picsum.photos/200/300?random=$index',
                          width: (Get.width - 36) * 0.7,
                          height: (Get.width - 36) * 0.7,
                          fit: BoxFit.cover,
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  SplashController? putController() => SplashController();
}
