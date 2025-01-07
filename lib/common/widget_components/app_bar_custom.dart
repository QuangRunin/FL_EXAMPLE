import 'package:flutter/services.dart';
import 'package:example/import.dart';
import 'button/widget_button.dart';

class AppBarCustom extends BaseWidget<BaseController>
    implements PreferredSizeWidget {
  AppBarCustom(
      {super.key,
      this.titleAppBar = '',
      this.widgetTitle,
      this.centerTitle = true,
      this.automaticallyImplyLeading = true,
      this.actions,
      this.leadingPressed,
      this.backgroundColor,
      this.leadingIcon,
      this.hideLeading = false,
      this.elevation = 0.5,
      this.bottom,
      this.actionTitleButton,
      this.actionButtonRadius = 10,
      this.actionPress,
      this.actionButtonPadding = 0,
      this.backIconColor,
      this.actionButtonWidth,
      this.marginRight = 14,
      this.titleSpacing});

  final String titleAppBar;
  final Widget? widgetTitle;
  final bool centerTitle;
  final bool automaticallyImplyLeading;
  final List<Widget>? actions;
  final String? actionTitleButton;
  final VoidCallback? leadingPressed;
  final Function()? actionPress;
  final String? leadingIcon;
  final Color? backgroundColor;
  final bool hideLeading;
  final double elevation;
  final PreferredSizeWidget? bottom;
  final double actionButtonRadius;
  final double actionButtonPadding;
  final double? actionButtonWidth;
  final Color? backIconColor;
  final double? marginRight;
  final double? titleSpacing;
  @override
  Widget builder() {
    return PreferredSize(
      preferredSize: Size.fromHeight(kToolbarHeight.h),
      child: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        scrolledUnderElevation: elevation,
        bottom: bottom,
        titleSpacing: titleSpacing,
        automaticallyImplyLeading: false,
        surfaceTintColor: color.white,
        foregroundColor: color.white,
        // forceMaterialTransparency: true,
        actions: actionTitleButton != null
            ? <Widget>[
                Center(
                  child: WidgetButton(
                    title: actionTitleButton!,
                    onClick: actionPress!,
                    textColor: color.white,
                    borderColor: color.white,
                    height: 30.h,
                    width: actionButtonWidth,
                    borderRadius: actionButtonRadius,
                    padding: actionButtonPadding,
                    margin: EdgeInsets.only(right: 14.r),
                  ),
                ),
              ]
            : <Widget>[
                ...actions ?? <Widget>[],
                SizedBox(width: marginRight),
              ],
        backgroundColor: backgroundColor ?? color.white,
        centerTitle: centerTitle,
        leading: hideLeading ? const SizedBox() : _buildLeading(),
        elevation: elevation,
        shadowColor: const Color(0xFFEAEAEA),
        title: widgetTitle ??
            Text(
              titleAppBar,
              style: textStyle.extraBold(size: 20, color: color.black),
              maxLines: 2,
            ),
      ),
    );
  }

  Widget? _buildLeading() {
    if (!automaticallyImplyLeading) {
      return null;
    }
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        if (leadingPressed != null) {
          leadingPressed!();
        } else {
          Get.back();
        }
      },
      child: Padding(
        padding: EdgeInsets.only(left: 16.r),
        child: Icon(Icons.arrow_left),
      ),
    );
  }

  @override
  String? screenName() => null;

  @override
  Size get preferredSize => Size.fromHeight(50.r);
}
