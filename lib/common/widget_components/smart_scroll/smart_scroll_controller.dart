import 'package:example/common/utils/functions.dart';
import 'package:smart_scroll/smart_scroll.dart';
import 'package:example/core/api_error.dart';
import 'package:example/import.dart';

mixin SmartLoadListController<T> {
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  ScrollController smartScrollController = ScrollController();

  RxBool isLoadingPage = false.obs;
  RxBool isLoading = false.obs;

  Rx<ApiError?> error = RxNullable<ApiError?>().setNull();
  Rx<String?> emptyMessage = RxNullable<String?>().setNull();

  RxList<T> items = <T>[].obs;
  Rx<T?>? data = Rx<T?>(null);

  void jumToPosition({double? position}) {
    if (smartScrollController.hasClients) {
      smartScrollController.jumpTo(position ?? 0);
    }
  }

  void onLoadMore();

  void onRefresh();
}
