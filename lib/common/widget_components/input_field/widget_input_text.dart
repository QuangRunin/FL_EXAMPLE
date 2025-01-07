import 'package:flutter/services.dart';
import 'package:example/import.dart';

class WidgetInputText extends StatefulWidget {
  const WidgetInputText(
      {super.key,
      this.iconLeading,
      this.widgetLeading,
      required this.hintText,
      required this.controller,
      this.currentNode,
      this.title = '',
      this.submitFunc,
      this.obscureText = false,
      this.iconNextTextInputAction = TextInputAction.next,
      this.textCapitalization = TextCapitalization.none,
      this.textInputType = TextInputType.text,
      this.inputFormatters,
      this.onChanged,
      this.maxLengthInputForm = 500,
      this.isReadOnly = false,
      this.maxLines,
      this.minLines,
      this.fontSize = 16,
      this.suffixIcon,
      this.hintFontSize = 12,
      this.fillColor,
      this.scrollPadding,
      this.textAlign,
      this.styleText,
      this.hintStyle,
      this.clearText,
      this.validator,
      this.suffixText,
      this.errText = '',
      this.height,
      this.contentPadding,
      this.borderColor,
      this.useSuffix = false,
      this.onPhoneTap,
      this.iconLeadingImage,
      this.marginTop = 24,
      this.borderRadius = 12,
      this.enabledBorder = false,
      this.showRequired = false,
      this.showOptional = false,
      this.paddingTitleBottom = 7,
      this.onPress,
      this.toolTipMessage,
      this.isIconSearch = false,
      this.autoFocus = false,
      this.titleStyle,
      this.onTapOutSide});

  final EdgeInsets? scrollPadding;
  final String title;
  final Color? fillColor;
  final double hintFontSize;
  final Color? borderColor;
  final double borderRadius;
  final String errText;
  final String? iconLeading;
  final String? iconLeadingImage;
  final Widget? widgetLeading;
  final String hintText;
  final TextEditingController controller;
  final FocusNode? currentNode;
  final bool obscureText;
  final bool isReadOnly;
  final Function()? submitFunc;
  final TextInputAction iconNextTextInputAction;
  final TextCapitalization textCapitalization;
  final TextInputType textInputType;
  final int maxLengthInputForm;
  final List<TextInputFormatter>? inputFormatters;
  final Function(String)? onChanged;
  final Widget? suffixIcon;
  final int? maxLines;
  final int? minLines;
  final double fontSize;
  final TextStyle? styleText;
  final TextStyle? hintStyle;
  final TextAlign? textAlign;
  final Function()? clearText;
  final double? height;
  final String? suffixText;
  final EdgeInsets? contentPadding;
  final String? Function(String?)? validator;
  final bool useSuffix;
  final double marginTop;
  final Function()? onPhoneTap;
  final Function()? onPress;
  final bool enabledBorder;
  final bool showRequired;
  final bool showOptional;
  final String? toolTipMessage;
  final double paddingTitleBottom;
  final bool isIconSearch;
  final bool autoFocus;
  final TextStyle? titleStyle;
  final Function(PointerDownEvent)? onTapOutSide;

  @override
  State<WidgetInputText> createState() => _WidgetInputTextState();
}

class _WidgetInputTextState extends State<WidgetInputText> with BaseMixin {
  final RxBool _isShowButtonClear = false.obs;
  final RxBool _isShowText = false.obs;
  String? errText;
  @override
  void initState() {
    super.initState();
    _isShowText.value = widget.obscureText;
    widget.controller.addListener(() {
      if (widget.controller.text.isNotEmpty) {
        _isShowButtonClear.value = true;
      } else {
        _isShowButtonClear.value = false;
      }
    });
    widget.currentNode?.addListener(() {
      if (widget.currentNode?.hasFocus == false) {
        widget.controller.text = widget.controller.text.trim();
      }
    });
  }

  @override
  void setState(Function() fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    widget.controller.addListener(
      () => setState(() {}),
    );
    return Padding(
      padding: EdgeInsets.only(top: widget.marginTop.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (widget.title.isNotEmpty)
            Padding(
              padding: EdgeInsets.only(bottom: widget.paddingTitleBottom.r),
              child: RichText(
                text: TextSpan(children: [
                  TextSpan(
                    text: widget.title,
                    style: textStyle.regular(size: 16),
                  ),
                  WidgetSpan(
                      child: widget.showRequired
                          ? Container(
                              color: color.redColor,
                              margin: const EdgeInsets.only(left: 5),
                              padding: const EdgeInsets.only(
                                  left: 7, right: 7, top: 4, bottom: 3),
                              child: Text(
                                'LocaleKeys.required.tr',
                                style: textStyle.bold(
                                    size: 10, color: color.white, height: 1),
                              ),
                            )
                          : const SizedBox()),
                  // WidgetSpan(
                  //     child: widget.showOptional
                  //         ? OptionalWidget(
                  //             backgroundColor: color.white.withOpacity(0.4),
                  //           )
                  //         : const SizedBox()),
                ]),
              ),
            )
          else
            const SizedBox(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: widget.onPress,
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        autofocus: widget.autoFocus,
                        autocorrect: false,
                        onTapOutside: widget.onTapOutSide,
                        enableSuggestions: false,
                        textAlignVertical: TextAlignVertical.top,
                        maxLines:
                            widget.obscureText ? 1 : (widget.maxLines ?? 1),
                        minLines:
                            widget.obscureText ? 1 : (widget.minLines ?? 1),
                        obscuringCharacter: '•',
                        scrollPadding: widget.scrollPadding ??
                            EdgeInsets.only(
                                left: 20.r,
                                right: 20.r,
                                top: 20.r,
                                bottom: 40.r),
                        textCapitalization: widget.textCapitalization,
                        maxLength: widget.maxLengthInputForm,
                        inputFormatters: widget.obscureText
                            ? [FilteringTextInputFormatter.deny(RegExp(r'\s'))]
                            : (widget.inputFormatters ?? []),
                        textAlign: widget.textAlign ?? TextAlign.start,
                        enabled: !widget.isReadOnly,
                        // readOnly: widget.isReadOnly,
                        style: widget.styleText ??
                            textStyle.regular(color: color.black, size: 16),
                        onChanged: (String v) {
                          if (!_isShowButtonClear.value || v.isEmpty) {
                            _isShowButtonClear.value = v.isNotEmpty;
                          }
                          widget.onChanged?.call(v);
                        },
                        validator: (value) {
                          if (widget.validator != null) {
                            setState(() => errText = widget.validator!(value));
                            return widget.validator!(value);
                          } else {
                            return null;
                          }
                        },
                        textInputAction: widget.iconNextTextInputAction,
                        controller: widget.controller,
                        obscureText: _isShowText.value,
                        focusNode: widget.currentNode,
                        keyboardType: widget.textInputType,
                        onFieldSubmitted: (String v) {
                          if (widget.submitFunc != null) {
                            widget.submitFunc!();
                          } else {
                            if (widget.currentNode != null) {
                              widget.currentNode!.unfocus();
                            }
                          }
                        },
                        cursorColor: color.mainColor,
                        decoration: InputDecoration(
                          errorStyle: textStyle.regular(
                              size: 12, color: color.redColor),
                          hintStyle: widget.hintStyle ??
                              textStyle.regular(
                                  size: 16, color: color.color999999),
                          hintText: widget.hintText,
                          fillColor: widget.fillColor ??
                              (widget.controller.text.isNotEmpty
                                  ? color.inputColor
                                  : color.inputColor),
                          filled: true,
                          isDense: true,
                          errorMaxLines: null,
                          border: !widget.isReadOnly
                              ? CustomFocusBorder(
                                  borderRadius: BorderRadius.circular(
                                      widget.borderRadius.r),
                                  innerBorderSide: BorderSide(
                                      width: 0.5.r,
                                      color: color.borderLightColor
                                          .withValues(alpha: 0.3)),
                                  outerBorderSide: BorderSide(
                                      width: 0.5.r,
                                      color: color.borderLightColor
                                          .withValues(alpha: 0.3)),
                                )
                              : CustomFocusBorder(
                                  borderRadius: BorderRadius.circular(
                                      widget.borderRadius.r),
                                  innerBorderSide: BorderSide(
                                      width: 0.5.r, color: Colors.transparent),
                                  outerBorderSide: BorderSide(
                                      width: 0.5.r, color: Colors.transparent),
                                ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(widget.borderRadius),
                            borderSide: BorderSide(
                              width: 1.r,
                              color: color.redColor,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(widget.borderRadius),
                            borderSide: BorderSide(
                              width: 1.r,
                              color: color.redColor,
                            ),
                          ),
                          enabledBorder: !widget.enabledBorder
                              ? OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                      widget.borderRadius.r),
                                  borderSide: BorderSide(
                                    width: 1.r,
                                    color: color.borderLightColor,
                                  ),
                                )
                              : OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                      widget.borderRadius.r),
                                  borderSide: BorderSide.none),
                          focusedBorder: CustomFocusBorder(
                            borderRadius:
                                BorderRadius.circular(widget.borderRadius.r),
                            innerBorderSide:
                                BorderSide(width: 1.r, color: color.mainColor),
                            outerBorderSide: BorderSide(
                                width: 3.r,
                                color: color.mainColor.withValues(alpha: 0.2)),
                          ),
                          contentPadding: widget.contentPadding ??
                              EdgeInsets.fromLTRB(10.r, 16.r, 0.r, 16.r),
                          prefixIcon: _buildPrefixIcon,
                          prefixIconConstraints:
                              BoxConstraints(maxWidth: 60.r, maxHeight: 40.r),
                          suffixIcon:
                              widget.useSuffix || widget.suffixText != null
                                  ? null
                                  : _buildSuffixIcon,
                          suffix: !widget.useSuffix || widget.suffixText != null
                              ? null
                              : _buildSuffixIcon,
                          suffixText: widget.suffixText,
                          suffixIconConstraints:
                              BoxConstraints(maxWidth: 60.r, maxHeight: 40.r),
                          counterStyle:
                              const TextStyle(height: double.minPositive),
                          counterText: '',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // _errBuilder(),
            ],
          ),
        ],
      ),
    );
  }

  Widget? get _buildPrefixIcon {
    return widget.iconLeading != null
        ? Padding(
            padding: EdgeInsets.only(left: 20.r, right: 10.r),
            child: SvgPicture.asset(
              widget.iconLeading!,
              width: widget.isIconSearch ? 17.5.w : 20.w,
              height: widget.isIconSearch ? 17.5.h : 20.h,
            ),
          )
        : null;
  }

  Widget? get _buildSuffixIcon {
    if (widget.suffixIcon != null) {
      return Padding(
        padding: EdgeInsets.only(right: 10.r),
        child: widget.suffixIcon,
      );
    }
    if (widget.isReadOnly) {
      return null;
    }
    return widget.obscureText
        ? InkWell(
            onTap: () {
              setState(() {
                _isShowText.toggle();
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: SvgPicture.asset(
                  _isShowText.value
                      ? AssetIcons.iconEyeInactive
                      : AssetIcons.iconEyeActive,
                  width: 20.w),
            ),
          )
        : Visibility(
            visible: _isShowButtonClear.value && !widget.isReadOnly,
            child: InkWell(
              onTap: () {
                widget.controller.clear();
                _isShowButtonClear.value = false;
                if (widget.clearText != null) {
                  widget.clearText!();
                }
              },
              child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: widget.useSuffix ? 0 : 14),
                child: Icon(
                  Icons.cancel_rounded,
                  color: color.color999999,
                  size: 16.r,
                ),
              ),
            ),
          );
  }
}

class CustomFocusBorder extends InputBorder {
  const CustomFocusBorder({
    this.outerBorderSide = const BorderSide(),
    this.innerBorderSide = const BorderSide(),
    this.borderRadius = BorderRadius.zero,
  });
  final BorderSide outerBorderSide;
  final BorderSide innerBorderSide;
  final BorderRadius borderRadius;

  @override
  EdgeInsets get dimensions =>
      EdgeInsets.all(outerBorderSide.width + innerBorderSide.width);

  @override
  ShapeBorder scale(double t) {
    return CustomFocusBorder(
      outerBorderSide: outerBorderSide.scale(t),
      innerBorderSide: innerBorderSide.scale(t),
      borderRadius: borderRadius * t,
    );
  }

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return Path()
      ..addRRect(borderRadius
          .resolve(textDirection)
          .toRRect(rect)
          .deflate(outerBorderSide.width));
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    return Path()..addRRect(borderRadius.resolve(textDirection).toRRect(rect));
  }

  @override
  void paint(Canvas canvas, Rect rect,
      {double? gapStart,
      double gapExtent = 0.0,
      double gapPercentage = 0.0,
      TextDirection? textDirection}) {
    if (outerBorderSide.style != BorderStyle.none &&
        innerBorderSide.style != BorderStyle.none) {
      final Paint outerPaint = Paint()
        ..color = outerBorderSide.color
        ..strokeWidth = outerBorderSide.width
        ..style = PaintingStyle.stroke;
      final Paint innerPaint = Paint()
        ..color = innerBorderSide.color
        ..strokeWidth = innerBorderSide.width
        ..style = PaintingStyle.stroke;
      final RRect outerRect = borderRadius.resolve(textDirection).toRRect(rect);
      final RRect innerRect = outerRect.deflate(outerBorderSide.width / 2);
      canvas.drawRRect(outerRect, outerPaint);
      canvas.drawRRect(innerRect, innerPaint);
    } else if (outerBorderSide.style != BorderStyle.none) {
      final Paint outerPaint = Paint()
        ..color = outerBorderSide.color
        ..strokeWidth = outerBorderSide.width
        ..style = PaintingStyle.stroke;
      canvas.drawRRect(
          borderRadius.resolve(textDirection).toRRect(rect), outerPaint);
    } else if (innerBorderSide.style != BorderStyle.none) {
      final Paint innerPaint = Paint()
        ..color = innerBorderSide.color
        ..strokeWidth = innerBorderSide.width
        ..style = PaintingStyle.stroke;
      canvas.drawRRect(
          borderRadius
              .resolve(textDirection)
              .toRRect(rect)
              .deflate(outerBorderSide.width),
          innerPaint);
    }
  }

  @override
  InputBorder copyWith({BorderSide? borderSide}) {
    return CustomFocusBorder(
      outerBorderSide: outerBorderSide,
      innerBorderSide: innerBorderSide,
      borderRadius: borderRadius,
    );
  }

  @override
  bool get isOutline => true;
}
