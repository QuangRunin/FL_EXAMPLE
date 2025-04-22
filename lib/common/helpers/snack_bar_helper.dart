import 'package:example/import.dart';

class SnackBarHelper {
  static void showMessage(
    String message, {
    String? title,
    Duration duration = const Duration(seconds: 3),
  }) {
    ScaffoldMessenger.of(Get.context!).clearSnackBars();
    final snackBar = SnackBar(
      content: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (title != null)
                  Text(
                    title,
                    style: AppTextStyle.share.semiBold(color: appThemes.white),
                  ),
                Text(
                  message.tr,
                  style: AppTextStyle.share.semiBold(color: appThemes.white),
                ),
              ],
            ),
          ),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => ScaffoldMessenger.of(Get.context!)
                .hideCurrentSnackBar(reason: SnackBarClosedReason.action),
            child: Container(
              width: 50,
              height: 35,
              margin: const EdgeInsets.only(left: 10),
              child: const Icon(Icons.close, size: 26, color: Colors.white),
            ),
          ),
        ],
      ),
      behavior: SnackBarBehavior.floating,
      dismissDirection: DismissDirection.endToStart,
      margin: const EdgeInsets.only(right: 16, left: 16, bottom: 16),
      padding: const EdgeInsets.only(left: 16, top: 10, bottom: 10),
      backgroundColor: appThemes.mainColor,
      duration: duration,
    );

    ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
  }

  static void showError(
    String? message, {
    Duration duration = const Duration(seconds: 3),
    String? title,
  }) {
    ScaffoldMessenger.of(Get.context!).clearSnackBars();
    final snackBar = SnackBar(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      content: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (title != null)
                  Text(
                    title,
                    style: AppTextStyle.share.semiBold(color: appThemes.white),
                  ),
                Text(
                  (message ?? '').tr,
                  style: AppTextStyle.share.semiBold(color: appThemes.white),
                ),
              ],
            ),
          ),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => ScaffoldMessenger.of(Get.context!)
                .hideCurrentSnackBar(reason: SnackBarClosedReason.action),
            child: Container(
              width: 50,
              height: 35,
              margin: const EdgeInsets.only(left: 10),
              child: const Icon(Icons.close, size: 26, color: Colors.white),
            ),
          ),
        ],
      ),
      behavior: SnackBarBehavior.floating,
      dismissDirection: DismissDirection.endToStart,
      margin: const EdgeInsets.only(right: 16, left: 16, bottom: 16),
      padding: const EdgeInsets.only(left: 16, top: 10, bottom: 10),
      backgroundColor: Colors.red,
      duration: duration,
    );

    ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
  }

  void showNetworkError(
      {Duration duration = const Duration(seconds: 5), String? message}) {
    ScaffoldMessenger.of(Get.context!).clearSnackBars();
    final snackBar = SnackBar(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Communication error',
            style: AppTextStyle.share.regular(),
          ),
          Text(
            message ?? 'Please check your internet connection...',
            style: AppTextStyle.share.regular(),
          ),
        ],
      ),
      backgroundColor: appThemes.white,
      action: SnackBarAction(
        label: 'OK',
        onPressed: () async {},
        textColor: appThemes.white,
      ),
      duration: duration,
    );

    ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
  }
}
