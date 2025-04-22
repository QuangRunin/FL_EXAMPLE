import 'package:example/base/base_controller.dart';
import 'package:example/common/widget_components/smart_scroll/smart_scroll_controller.dart';

class SplashController extends BaseController
    with SmartLoadListController<User> {
  @override
  void onLoadMore() {
    Future.delayed(const Duration(seconds: 2), () {
      final newItems = List.generate(10, (v) => User('name')).toList();
      items.addAll(newItems);
      items.refresh();
      refreshController.loadComplete();
    });
  }

  @override
  void onRefresh() {
    Future.delayed(const Duration(seconds: 1), () {
      items.value = List.generate(20, (v) => User('name')).toList();
      items.refresh();
      refreshController.refreshCompleted();
    });
  }
}

class User {
  String name;
  User(this.name);
}
