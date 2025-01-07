import 'package:example/import.dart';

class WidgetIconButton extends StatelessWidget with BaseMixin {
  const WidgetIconButton({
    super.key,
    this.height,
    this.size,
    this.width,
    this.fit,
    required this.onPressed,
    this.image,
    this.child,
    this.iconColor,
    this.iconData,
    this.alignment,
    this.iconSvg,
    this.padding,
  });
  final double? width;
  final double? height;
  final double? size;
  final Function onPressed;
  final String? image;
  final BoxFit? fit;
  final Widget? child;
  final Color? iconColor;
  final IconData? iconData;
  final Alignment? alignment;
  final String? iconSvg;
  final EdgeInsets? padding;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: padding ?? EdgeInsets.zero,
      onPressed: () => onPressed(),
      iconSize: size,
      color: Colors.black,
      alignment: alignment ?? Alignment.center,
      icon: iconSvg != null
          ? SvgPicture.asset(
              iconSvg!,
              width: width,
              height: height,
              fit: BoxFit.contain,
              colorFilter: iconColor != null
                  ? ColorFilter.mode(iconColor!, BlendMode.color)
                  : null,
              // color: iconColor,
            )
          : (iconData != null
              ? Icon(iconData, size: (size ?? 20).r, color: iconColor)
              : SizedBox(
                  width: (size ?? 20).r,
                  child: Image.asset(
                    image!,
                    width: width,
                    height: height,
                    color: iconColor,
                    fit: fit ?? BoxFit.contain,
                  ),
                )),
      // hoverColor: Colors.transparent,
      // focusColor: Colors.transparent,
      // splashColor: Colors.transparent,
      // highlightColor: Colors.transparent,
    );
  }
}
