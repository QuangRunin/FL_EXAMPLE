import 'package:smart_scroll/smart_scroll.dart';
import 'package:example/common/widget_components/loading/custom_loading.dart';
import 'package:example/common/widget_components/no_data/error_message.dart';
import 'package:example/common/widget_components/smart_scroll/smart_scroll_controller.dart';
import 'package:example/import.dart';

mixin SmartLoadListWidget {
  Widget buildSmartListExpanded(SmartLoadListController controller,
          {Widget? child,
          bool? enablePullDown,
          bool? enablePullUp,
          double headerHeight = 20,
          ScrollController? scrollController,
          bool isSliverBar = false,
          ScrollPhysics? scrollPhysics}) =>
      Expanded(
        child: _smartScroll(
          controller,
          child: child,
          enablePullDown: enablePullDown,
          enablePullUp: enablePullUp,
          headerHeight: headerHeight,
          scrollController: scrollController,
          isSliverBar: isSliverBar,
          scrollPhysics: scrollPhysics,
        ),
      );

  Widget buildSmartList(SmartLoadListController controller,
          {Widget? child,
          bool? enablePullDown,
          bool? enablePullUp,
          double headerHeight = 20,
          ScrollController? scrollController,
          bool isSliverBar = false,
          bool isNotExamPage = true,
          ScrollPhysics? scrollPhysics}) =>
      _smartScroll(controller,
          child: child,
          enablePullDown: enablePullDown,
          enablePullUp: enablePullUp,
          headerHeight: headerHeight,
          isSliverBar: isSliverBar,
          scrollController: scrollController,
          scrollPhysics: scrollPhysics,
          isNotExamPage: isNotExamPage);

  Widget _smartScroll(SmartLoadListController controller,
      {Widget? child,
      bool? enablePullDown,
      bool? enablePullUp,
      double headerHeight = 20,
      ScrollController? scrollController,
      bool isSliverBar = false,
      bool isNotExamPage = true,
      ScrollPhysics? scrollPhysics}) {
    return Obx(
      () => Stack(
        alignment: Alignment.center,
        fit: StackFit.expand,
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            switchInCurve: Curves.easeIn,
            switchOutCurve: Curves.easeOut,
            child: (controller.isLoading.value ||
                    controller.isLoadingPage.value)
                ? const SizedBox(
                    key: ValueKey('loadingPlaceholder'),
                  )
                : SmartScroll(
                    key: const ValueKey('smartScrollContent'),
                    physics: scrollPhysics ??
                        (GetPlatform.isIOS
                            ? const BouncingScrollPhysics()
                            : const ClampingScrollPhysics()),
                    controller: controller.refreshController,
                    scrollController: isSliverBar
                        ? null
                        : scrollController ?? controller.smartScrollController,
                    enablePullDown: enablePullDown ?? true,
                    enablePullUp: enablePullUp ?? false,
                    onLoading: controller.onLoadMore,
                    onRefresh: controller.onRefresh,
                    header: GetPlatform.isIOS
                        ? ClassicHeader(
                            idleText: '',
                            refreshingText: '',
                            releaseText: '',
                            failedText: '',
                            completeText: '',
                            canTwoLevelText: '',
                            height: headerHeight.r,
                            spacing: 0,
                            completeDuration: Duration.zero,
                            completeIcon: const SizedBox(),
                          )
                        : MaterialClassicHeader(
                            height: 25.r, color: appThemes.mainColor),
                    footer: ClassicFooter(
                      loadStyle: LoadStyle.ShowWhenLoading,
                      idleText: '',
                      failedText: '',
                      noDataText: '',
                      loadingText: '',
                      canLoadingText: '',
                      height: 65.r,
                      completeDuration: const Duration(milliseconds: 1500),
                      idleIcon: const SizedBox(),
                      loadingIcon: SizedBox(
                        height: 30.r,
                        width: 30.r,
                        child: const CircularProgressIndicator(
                          color: Colors.grey,
                          strokeWidth: 2.5,
                        ),
                      ),
                    ),
                    child: controller.error.value != null
                        ? ErrorMessage(err: controller.error.value)
                        : controller.dataList.isEmpty && isNotExamPage
                            ? ErrorMessage(
                                message: controller.emptyMessage.value)
                            : child,
                  ),
          ),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            switchInCurve: Curves.easeIn,
            switchOutCurve: Curves.easeOut,
            child: controller.isLoadingPage.value
                ? CustomLoading(
                    key: const ValueKey('loadingPage'),
                    color: appThemes.mainColor,
                    type: CustomLoadingType.start,
                  )
                : const SizedBox.shrink(
                    key: ValueKey('noLoadingPage'),
                  ),
          ),
        ],
      ),
    );
  }
}
