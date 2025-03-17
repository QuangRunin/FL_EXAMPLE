import 'package:flutter/services.dart';
import 'package:example/import.dart';

class WidgetInputText extends StatefulWidget {
  const WidgetInputText({
    super.key,
    this.prefixIcon,
    required this.hintText,
    this.controller,
    this.focusNode,
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
    this.titleFontSize = 16,
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
    this.height,
    this.contentPadding,
    this.borderColor,
    this.marginTop = 24,
    this.borderRadius = 12,
    this.enabledBorder = false,
    this.isRequired = false,
    this.paddingTitleBottom = 7,
    this.onPress,
    this.toolTipMessage,
    this.autoFocus = false,
    this.titleStyle,
    this.onTapOutSide,
    this.prefixIconSvg,
    this.suffixIconSvg,
    this.initialValue,
  });

  final Function()? submitFunc;
  final Function(String)? onChanged;
  final Function()? clearText;
  final Function()? onPress;
  final Function(PointerDownEvent)? onTapOutSide;
  final bool obscureText;
  final bool isReadOnly;
  final bool enabledBorder;
  final bool isRequired;
  final bool autoFocus;
  final String? Function(String?)? validator;
  final EdgeInsets? scrollPadding;
  final String title;
  final String? prefixIconSvg;
  final String? suffixIconSvg;
  final String hintText;
  final String? suffixText;
  final String? toolTipMessage;
  final Color? fillColor;
  final Color? borderColor;
  final double hintFontSize;
  final double borderRadius;
  final double titleFontSize;
  final double? height;
  final double paddingTitleBottom;
  final double marginTop;
  final int? maxLines;
  final int maxLengthInputForm;
  final int? minLines;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextInputAction iconNextTextInputAction;
  final TextCapitalization textCapitalization;
  final TextInputType textInputType;
  final List<TextInputFormatter>? inputFormatters;
  final TextStyle? styleText;
  final TextStyle? hintStyle;
  final TextStyle? titleStyle;
  final TextAlign? textAlign;
  final EdgeInsets? contentPadding;
  final String? initialValue;
  @override
  State<WidgetInputText> createState() => _WidgetInputTextState();
}

class _WidgetInputTextState extends State<WidgetInputText> with BaseMixin {
  final RxBool _isShowButtonClear = false.obs;
  final RxBool _isShowText = false.obs;
  late TextEditingController _controller;
  @override
  void initState() {
    super.initState();
    _controller =
        widget.controller ?? TextEditingController(text: widget.initialValue);
    _isShowText.value = widget.obscureText;
    _setupControllerListener();
    _setupFocusNodeListener();
  }

  void _setupControllerListener() {
    _controller.addListener(() {
      _isShowButtonClear.value = _controller.text.isNotEmpty;
    });
  }

  void _setupFocusNodeListener() {
    widget.focusNode?.addListener(() {
      if (widget.focusNode?.hasFocus == false) {
        _controller.text = _controller.text.trim();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: widget.marginTop.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.title.isNotEmpty) _buildTitle(),
          _buildTextField(),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Padding(
      padding: EdgeInsets.only(bottom: widget.paddingTitleBottom.r),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: widget.title,
              style: widget.titleStyle ?? textStyle.regular(size: 16),
            ),
            if (widget.isRequired) _buildRequiredIndicator(),
          ],
        ),
      ),
    );
  }

  WidgetSpan _buildRequiredIndicator() {
    return WidgetSpan(
      child: Container(
        margin: const EdgeInsets.only(left: 5),
        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
        color: color.redColor,
        child: Text(
          'Required',
          style: textStyle.bold(size: 10, color: color.white, height: 1),
        ),
      ),
    );
  }

  Widget _buildTextField() {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: widget.onPress,
      child: TextFormField(
        autofocus: widget.autoFocus,
        controller: _controller,
        focusNode: widget.focusNode,
        obscureText: _isShowText.value,
        readOnly: widget.isReadOnly,
        keyboardType: widget.textInputType,
        textInputAction: widget.iconNextTextInputAction,
        textCapitalization: widget.textCapitalization,
        maxLength: widget.maxLengthInputForm,
        maxLines: widget.obscureText ? 1 : (widget.maxLines ?? 1),
        minLines: widget.obscureText ? 1 : (widget.minLines ?? 1),
        inputFormatters: _getInputFormatters(),
        textAlign: widget.textAlign ?? TextAlign.start,
        style: widget.styleText ??
            textStyle.regular(color: color.black, size: widget.titleFontSize),
        scrollPadding: widget.scrollPadding ??
            EdgeInsets.only(left: 20.r, right: 20.r, top: 20.r, bottom: 40.r),
        onChanged: (value) => widget.onChanged?.call(value.trim()),
        onFieldSubmitted: _handleSubmit,
        validator: (value) {
          if (widget.validator == null) return null;
          return widget.validator!(value);
        },
        decoration: _buildDecoration(),
      ),
    );
  }

  List<TextInputFormatter> _getInputFormatters() {
    if (widget.obscureText) {
      return [FilteringTextInputFormatter.deny(RegExp(r'\s'))];
    }
    return widget.inputFormatters ?? [];
  }

  void _handleSubmit(String value) {
    widget.submitFunc?.call() ?? widget.focusNode?.unfocus();
  }

  InputDecoration _buildDecoration() {
    return InputDecoration(
      hintText: widget.hintText,
      hintStyle: widget.hintStyle ??
          textStyle.regular(
              size: widget.titleFontSize, color: color.color999999),
      fillColor: widget.fillColor ??
          (_controller.text.isNotEmpty ? color.inputColor : color.inputColor),
      filled: true,
      isDense: true,
      contentPadding:
          widget.contentPadding ?? EdgeInsets.fromLTRB(10.r, 16.r, 0.r, 16.r),
      prefixIcon: _buildPrefixIcon(),
      suffixIcon: _buildSuffixIcon(),
      suffixText: widget.suffixText,
      counterText: '',
      border: _buildBorder(),
      enabledBorder: _buildEnabledBorder(),
      focusedBorder: _buildFocusedBorder(),
      errorBorder: _buildErrorBorder(),
      focusedErrorBorder: _buildErrorBorder(),
      errorStyle: textStyle.regular(size: 10, color: color.redColor),
      errorMaxLines: 10,
    );
  }

  InputBorder _buildBorder() {
    return widget.isReadOnly
        ? CustomFocusBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius.r),
            innerBorderSide:
                BorderSide(width: 0.5.r, color: Colors.transparent),
            outerBorderSide:
                BorderSide(width: 0.5.r, color: Colors.transparent),
          )
        : CustomFocusBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius.r),
            innerBorderSide: BorderSide(
                width: 0.5.r,
                color: color.borderLightColor.withValues(alpha: 0.3)),
            outerBorderSide: BorderSide(
                width: 0.5.r,
                color: color.borderLightColor.withValues(alpha: 0.3)),
          );
  }

  InputBorder _buildEnabledBorder() {
    return widget.enabledBorder
        ? OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius.r),
            borderSide: BorderSide.none,
          )
        : OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius.r),
            borderSide: BorderSide(width: 1.r, color: color.borderLightColor),
          );
  }

  InputBorder _buildFocusedBorder() {
    return CustomFocusBorder(
      borderRadius: BorderRadius.circular(widget.borderRadius.r),
      innerBorderSide: BorderSide(width: 1.r, color: color.mainColor),
      outerBorderSide:
          BorderSide(width: 3.r, color: color.mainColor.withValues(alpha: 0.2)),
    );
  }

  InputBorder _buildErrorBorder() {
    return CustomFocusBorder(
      borderRadius: BorderRadius.circular(widget.borderRadius.r),
      innerBorderSide: BorderSide(width: 1.r, color: color.redColor),
      outerBorderSide:
          BorderSide(width: 2.r, color: color.redColor.withValues(alpha: 0.3)),
    );
  }
  // InputBorder _buildErrorBorder() {
  //   return OutlineInputBorder(
  //     borderRadius: BorderRadius.circular(widget.borderRadius),
  //     borderSide: BorderSide(width: 1.r, color: color.redColor),
  //   );
  // }

  Widget? _buildPrefixIcon() {
    if (widget.prefixIcon == null && widget.prefixIconSvg == null) {
      return null;
    }
    return Padding(
      padding: EdgeInsets.only(left: 20.r, right: 10.r),
      child: widget.prefixIcon ??
          SvgPicture.asset(
            widget.prefixIconSvg!,
            width: 20.w,
            height: 20.h,
          ),
    );
  }

  Widget? _buildSuffixIcon() {
    if (widget.suffixIcon != null && widget.suffixIconSvg == null) {
      return Padding(
        padding: EdgeInsets.only(right: 10.r),
        child: widget.suffixIcon ??
            SvgPicture.asset(
              widget.suffixIconSvg!,
              width: 20.w,
              height: 20.h,
            ),
      );
    }
    if (widget.isReadOnly) return null;

    return Obx(() => widget.obscureText
        ? InkWell(
            onTap: () => _isShowText.toggle(),
            child: Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: SvgPicture.asset(
                _isShowText.value
                    ? AssetIcons.iconEyeInactive
                    : AssetIcons.iconEyeActive,
                width: 20.w,
              ),
            ),
          )
        : Visibility(
            visible: _isShowButtonClear.value,
            child: GestureDetector(
              onTap: _clearText,
              behavior: HitTestBehavior.opaque,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: widget.suffixIcon != null ? 0 : 14),
                child: Icon(
                  Icons.cancel_rounded,
                  color: color.color999999,
                  size: 18.r,
                ),
              ),
            ),
          ));
  }

  void _clearText() {
    _controller.clear();
    widget.clearText?.call();
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
