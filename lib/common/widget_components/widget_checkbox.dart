import 'package:flutter/gestures.dart';
import 'package:example/import.dart';

class WidgetCheckbox extends StatefulWidget {
  const WidgetCheckbox({
    super.key,
    required this.title,
    this.hightLightText,
    this.onHightLightPressed,
    this.padding,
    this.requiredCheckbox = false,
    required this.onChange,
  });
  final String title;
  final String? hightLightText;
  final Function()? onHightLightPressed;
  final EdgeInsets? padding;
  final bool requiredCheckbox;
  final Function(bool value) onChange;
  @override
  State<WidgetCheckbox> createState() => _WidgetCheckboxState();
}

class _WidgetCheckboxState extends State<WidgetCheckbox> with BaseMixin {
  bool isChecked = false;
  void _handleChangeSelected() {
    setState(() {
      isChecked = !isChecked;
    });
    widget.onChange(isChecked);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding ?? EdgeInsets.symmetric(vertical: 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: _handleChangeSelected,
                child: Container(
                  width: 25.w,
                  height: 25.w,
                  margin: EdgeInsets.only(right: 12.r),
                  decoration: BoxDecoration(
                      color: isChecked ? color.mainColor : color.white,
                      borderRadius: BorderRadius.circular(4.r),
                      border: isChecked
                          ? null
                          : Border.all(color: color.greyColor)),
                  child: isChecked
                      ? Center(child: Icon(Icons.done))
                      : const SizedBox(),
                ),
              ),
              Flexible(
                child: RichText(
                  text: TextSpan(
                    style: DefaultTextStyle.of(context).style,
                    children: <TextSpan>[
                      TextSpan(
                        text: widget.title,
                        style: textStyle.regular(size: 16),
                      ),
                      if (widget.hightLightText != null)
                        TextSpan(
                          text: ' ${widget.hightLightText}',
                          style: textStyle.regular(
                            size: 16,
                            color: color.mainColor,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = widget.onHightLightPressed!,
                        )
                    ],
                  ),
                ),
              ),
            ],
          ),
          if (widget.requiredCheckbox && !isChecked)
            Padding(
              padding: EdgeInsets.only(top: 7.r, left: 7.r),
              child: Text(
                LocaleKeys.requiredCheckBoxTerms.tr,
                style: textStyle.regular(
                  size: 12,
                  color: color.redColor,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
