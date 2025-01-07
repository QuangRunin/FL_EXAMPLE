import 'package:example/common/utils/functions.dart';
import 'package:example/import.dart';

enum TypeButton { active, inactive, secondary, ghost }

class WidgetButton extends StatelessWidget with BaseMixin {
  const WidgetButton({
    super.key,
    required this.title,
    required this.onClick,
    this.width,
    this.height = 50,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
    this.borderRadius = 100,
    this.textWeight,
    this.textSize = 16,
    this.prefixIcon,
    this.suffixIcon,
    this.margin,
    this.padding = 16,
    this.disable = false,
    this.isLoading = false,
    this.elevation = 0,
  });

  final String title;
  final Function() onClick;

  final double? width;
  final double height;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;
  final double borderRadius;
  final FontWeight? textWeight;
  final double? textSize;
  final String? prefixIcon;
  final String? suffixIcon;
  final EdgeInsets? margin;
  final double padding;
  final bool disable;
  final bool isLoading;
  final double elevation;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: ConstrainedBox(
        constraints: BoxConstraints.expand(width: width, height: height.h),
        child: ElevatedButton(
          onPressed: disable || isLoading ? null : onClick,
          style: ElevatedButton.styleFrom(
            elevation: elevation,
            backgroundColor: backgroundColor ?? color.mainColor,
            disabledBackgroundColor: color.disableButtonColor,
            // primary: bgColor ??
            //     (disable || isLoading ? color.neutral7 : color.appBaseColor),
            // disabledBackgroundColor: isLoading ? color.appBaseColor : null,
            // shadowColor: bgColor != color.appBaseColor
            //     ? Colors.transparent
            //     : color.mainColor,
            shadowColor: Colors.transparent,
            padding: EdgeInsets.symmetric(horizontal: padding),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              side: borderColor != null
                  ? BorderSide(color: borderColor!, width: 1)
                  : BorderSide.none,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isNotNullOrEmpty(prefixIcon))
                Padding(
                  padding: EdgeInsets.only(right: 10.w),
                  child: SvgPicture.asset(prefixIcon!, width: 25.w),
                ),
              Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: textStyle.bold(
                    color: textColor ?? appThemes.white, size: textSize),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
