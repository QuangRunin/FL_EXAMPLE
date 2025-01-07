import 'package:example/import.dart';

abstract class BaseMainController<T> extends BaseController {
  BaseMainController({
    required this.currentPage,
    required this.indexPageChange,
  });

  late final Worker worker;
  final T currentPage;
  final Rx<T> indexPageChange;
  @override
  void onInit() {
    worker = ever(
      indexPageChange,
      (T pageChange) {
        if (pageChange == currentPage) {
          initPage();
        }
        this.pageChange();
      },
    );
    if (indexPageChange.value == currentPage) {
      initPage();
    }

    super.onInit();
  }

  void initPage() {
    worker.dispose();
  }

  void pageChange() {}

  bool get isCurrentPage => currentPage == indexPageChange.value;
}
