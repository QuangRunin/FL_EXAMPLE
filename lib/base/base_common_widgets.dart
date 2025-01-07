import 'package:example/common/widget_components/button/widget_button.dart';
import 'package:example/common/widget_components/text_button/widget_text_button.dart';
import 'package:example/import.dart';

mixin BaseCommonWidgets {
  void hideDialog() {
    if (Get.isDialogOpen!) {
      Get.back();
    }
  }

  Divider appDivider({double height = 1, double thickness = 1}) {
    return Divider(
      height: height.h,
      color: appThemes.greyColor,
      thickness: thickness.h,
    );
  }

  ScrollPhysics appPhysics() {
    return const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics());
  }

  void showAcceptAlert({
    required String title,
    String? message,
    required Function() onAccept,
    String? acceptText,
    String? additionalText,
    bool barrierDismissible = true,
  }) {
    showDialog(
        context: Get.context!,
        barrierDismissible: barrierDismissible,
        builder: (context) {
          // ignore: deprecated_member_use
          return WillPopScope(
            onWillPop: barrierDismissible ? null : () async => false,
            child: AlertDialog(
              contentPadding: EdgeInsets.zero,
              backgroundColor: appThemes.white,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12))),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 40),
                    child: Column(
                      children: [
                        Text(
                          title,
                          style: AppTextStyle.share
                              .semiBold(size: 16, color: appThemes.black),
                          textAlign: TextAlign.center,
                        ),
                        Visibility(
                            visible: additionalText != null,
                            child: Text(
                              '\n${additionalText ?? ''}',
                              style: AppTextStyle.share
                                  .semiBold(size: 16, color: appThemes.black),
                              textAlign: TextAlign.center,
                            ))
                      ],
                    ),
                  ),
                  const Divider(
                    height: 0.5,
                    color: Color(0xffA2A1A1),
                    thickness: 0.5,
                  ),
                  // WidgetTextButton(
                  //     onPressed: () {
                  //       Get.back();
                  //       onAccept();
                  //     },
                  //     title: acceptText ?? 'OK'),
                ],
              ),
            ),
          );
        });
  }

  void showCloseAlert({
    required String content,
    String? additionalContent,
    bool barrierDismissible = true,
    bool isCenter = true,
    VoidCallback? onClose,
  }) {
    showDialog(
        context: Get.context!,
        barrierDismissible: barrierDismissible,
        builder: (context) {
          // ignore: deprecated_member_use
          return WillPopScope(
            onWillPop: barrierDismissible ? null : () async => false,
            child: AlertDialog(
              contentPadding: EdgeInsets.zero,
              backgroundColor: appThemes.white,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12))),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Stack(
                    children: [
                      Positioned(
                        right: 0,
                        child: IconButton(
                            onPressed: () {
                              if (onClose != null) {
                                onClose();
                              } else {
                                Get.back();
                              }
                            },
                            icon: const Icon(
                              Icons.close,
                              size: 30,
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 20),
                        child: Column(
                          crossAxisAlignment: isCenter
                              ? CrossAxisAlignment.center
                              : CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 50, left: isCenter ? 12 : 0),
                              child: Text(
                                content,
                                style: AppTextStyle.share
                                    .semiBold(size: 16, color: appThemes.black),
                                textAlign: isCenter ? TextAlign.center : null,
                              ),
                            ),
                            Visibility(
                              visible: additionalContent != null,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Text(
                                  '${additionalContent ?? ''}　　　',
                                  style: AppTextStyle.share.semiBold(
                                      size: 16, color: appThemes.redColor),
                                  textAlign: isCenter ? TextAlign.center : null,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  void showConfirmAlert({
    required String title,
    String? message,
    required Function() onAccept,
    Function()? onCancel,
    Color? acceptColor,
    bool barrierDismissible = false,
    String? cancelText,
    String? acceptText,
    bool horizontal = true,
    bool showOnlyConfirm = false,
  }) {
    showDialog(
        context: Get.context!,
        barrierDismissible: barrierDismissible,
        builder: (context) {
          // ignore: deprecated_member_use
          return WillPopScope(
            onWillPop: barrierDismissible
                ? null
                : () async {
                    return false;
                  },
            child: AlertDialog(
              contentPadding: EdgeInsets.zero,
              backgroundColor: appThemes.white,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12))),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 26, vertical: message != null ? 20 : 40),
                    child: Text(
                      title,
                      style: AppTextStyle.share
                          .semiBold(size: 16, color: appThemes.black),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  if (message != null)
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 16, right: 16, bottom: 32),
                      child: Text(
                        message,
                        style: AppTextStyle.share
                            .regular(size: 14, color: appThemes.redColor),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  const Divider(
                    height: 0.5,
                    color: Color(0xffA2A1A1),
                    thickness: 0.5,
                  ),
                  if (showOnlyConfirm)
                    WidgetTextButton(
                        onPressed: () {
                          Get.back();
                          onAccept();
                        },
                        textColor: acceptColor,
                        title: acceptText ?? 'OK')
                  else if (horizontal)
                    IntrinsicHeight(
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: WidgetTextButton(
                                onPressed: () {
                                  Get.back();
                                  if (onCancel != null) {
                                    onCancel();
                                  }
                                },
                                title: cancelText ?? LocaleKeys.cancel.tr),
                          ),
                          const VerticalDivider(
                            width: 0.5,
                            color: Color(0xffA2A1A1),
                            thickness: 0.5,
                          ),
                          Expanded(
                            flex: 1,
                            child: WidgetTextButton(
                                onPressed: () {
                                  Get.back();
                                  onAccept();
                                },
                                textColor: acceptColor,
                                title: acceptText ?? 'OK'),
                          ),
                        ],
                      ),
                    ),
                  if (!horizontal)
                    Column(
                      children: [
                        WidgetTextButton(
                            onPressed: () {
                              Get.back();
                              onAccept();
                            },
                            textColor: acceptColor,
                            title: acceptText ?? 'OK'),
                        const Divider(
                          height: 0.5,
                          color: Color(0xffA2A1A1),
                          thickness: 0.5,
                        ),
                        WidgetTextButton(
                            onPressed: () {
                              Get.back();
                              if (onCancel != null) {
                                onCancel();
                              }
                            },
                            title: cancelText ?? LocaleKeys.cancel.tr),
                      ],
                    ),
                ],
              ),
            ),
          );
        });
  }

  void showAlertWarning({
    required String content,
    bool barrierDismissible = false,
  }) {
    showDialog(
        context: Get.context!,
        barrierDismissible: barrierDismissible,
        builder: (context) {
          return AlertDialog(
            contentPadding: EdgeInsets.zero,
            backgroundColor: appThemes.redColor,
            insetPadding: const EdgeInsets.all(16),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12))),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text(
                        'リサイクル法について⚠︎',
                        style: AppTextStyle.share.semiBold(
                            size: Get.width > 375 ? 16 : 14,
                            color: appThemes.black),
                        textAlign: TextAlign.center,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: Text(
                          content,
                          style: AppTextStyle.share.regular(
                              size: Get.width > 375 ? 14 : 12,
                              color: Colors.black54),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Text(
                        '※発見次第通報します',
                        style: AppTextStyle.share.medium(
                            size: Get.width > 375 ? 14 : 12,
                            color: appThemes.black),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                Divider(
                  height: 4,
                  color: appThemes.white,
                  thickness: 4,
                ),
                IntrinsicHeight(
                  child: Row(
                    children: [
                      Expanded(
                        child: WidgetButton(
                          title: '閉じる',
                          textColor: appThemes.black,
                          backgroundColor: appThemes.redColor,
                          borderRadius: 12,
                          textSize: 13,
                          onClick: () {
                            Get.back();
                          },
                        ),
                      ),
                      VerticalDivider(
                        color: appThemes.white,
                        thickness: 3,
                        width: 3,
                      ),
                      Expanded(
                        child: WidgetButton(
                          title: '利用規約を確認',
                          backgroundColor: appThemes.redColor,
                          textColor: appThemes.black,
                          borderRadius: 12,
                          textSize: 13,
                          onClick: () {
                            // Get.toNamed(
                            //   AppRouter.routerWebview,
                            //   arguments: WebViewParams(url: AppUrl.terms),
                            // );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  void showAlertAnErr({
    required String title,
    required String message,
  }) {}

  void showOneButtonAlert({
    required String title,
    bool barrierDismissible = false,
  }) {
    showDialog(
        context: Get.context!,
        barrierDismissible: barrierDismissible,
        builder: (context) {
          return AlertDialog(
            contentPadding: EdgeInsets.zero,
            backgroundColor: appThemes.white,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12))),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
                  child: Text(
                    title,
                    style: AppTextStyle.share
                        .semiBold(size: 16, color: appThemes.black),
                    textAlign: TextAlign.center,
                  ),
                ),
                const Divider(
                  height: 0.5,
                  color: Color(0xffA2A1A1),
                  thickness: 0.5,
                ),
                WidgetTextButton(
                    onPressed: () {
                      Get.back();
                    },
                    title: 'OK'),
              ],
            ),
          );
        });
  }

  void showCustomGeneralDialog({
    String? title,
    String? acceptText,
    String? message,
    Color? backgroundColor,
    Color? confirmTitleColor,
    Color? confirmBackgroundColor,
    Color? titleColor,
    bool barrierDismissible = false,
    Function()? onCancel,
    required Function() onConfirm,
    bool showOnlyConfirm = false,
  }) {
    showGeneralDialog(
        barrierColor: appThemes.black.withValues(alpha: 0.6),
        transitionBuilder: (context, a1, a2, widget) {
          Tween<double> tween;
          if (a1.status == AnimationStatus.reverse) {
            tween = Tween<double>(begin: 0.7, end: 1);
          } else {
            tween = Tween<double>(begin: 0.65, end: 1);
          }
          return ScaleTransition(
            scale: tween.animate(a1),
            child: FadeTransition(opacity: a1, child: widget),
          );
        },
        transitionDuration: const Duration(milliseconds: 200),
        barrierDismissible: barrierDismissible,
        barrierLabel: '',
        context: Get.context!,
        pageBuilder: (context, animation1, animation2) {
          return Center(
            child: Container(
              width: 382.r,
              decoration: BoxDecoration(
                color: backgroundColor ?? appThemes.white,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: EdgeInsets.all(20.r),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (title != null)
                    Padding(
                      padding: EdgeInsets.only(top: 16.r),
                      child: Text(
                        title,
                        style: AppTextStyle.share.bold(
                            size: 30, color: titleColor ?? appThemes.black),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  if (message != null)
                    Padding(
                      padding: EdgeInsets.only(top: 24.r),
                      child: Text(
                        message,
                        style: AppTextStyle.share.regular(size: 16),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  Padding(
                    padding: EdgeInsets.only(top: 24.r),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (!showOnlyConfirm)
                          Expanded(
                            child: WidgetButton(
                              title: LocaleKeys.cancel.tr,
                              onClick: () {
                                Get.back();
                                if (onCancel != null) {
                                  onCancel();
                                }
                              },
                              borderColor: appThemes.greyColor,
                              backgroundColor: appThemes.white,
                              textColor: appThemes.black,
                            ),
                          ),
                        Expanded(
                          child: WidgetButton(
                            margin: EdgeInsets.only(left: 16.r),
                            title: acceptText ?? LocaleKeys.ok.tr.toUpperCase(),
                            textColor: confirmTitleColor ?? appThemes.white,
                            backgroundColor:
                                confirmBackgroundColor ?? appThemes.mainColor,
                            onClick: () {
                              Get.back();
                              onConfirm();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
