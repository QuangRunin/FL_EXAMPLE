import 'package:example/common/utils/debounce.dart';
import 'package:flutter/services.dart';
import 'package:example/import.dart';

class CustomInputText extends StatefulWidget {
  const CustomInputText({
    super.key,
    this.iconLeading,
    this.widgetLeading,
    required this.hintText,
    required this.controller,
    this.currentNode,
    this.title = '',
    this.submitFunc,
    this.obscureText = false,
    this.iconNextTextInputAction = TextInputAction.next,
    this.textCapitalization = TextCapitalization.sentences,
    this.textInputType = TextInputType.text,
    this.inputFormatters,
    this.onChanged,
    this.maxLengthInputForm = 500,
    this.isReadOnly = false,
    this.maxLines = 1,
    this.minLines = 1,
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
    this.marginTop = 22,
    this.borderRadius = 0,
    this.enabledBorder = false,
    this.showRequired = false,
    this.onPress,
    this.horizontalTitle,
    this.onChangedDelay,
    this.showHorizontalOption = false,
    this.onTap,
  });

  final EdgeInsets? scrollPadding;
  final String title;
  final String? horizontalTitle;
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
  final Function(String)? onChangedDelay;
  final Widget? suffixIcon;
  final int maxLines;
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

  final bool showHorizontalOption;
  final VoidCallback? onTap;

  @override
  State<CustomInputText> createState() => _CustomInputTextState();
}

class _CustomInputTextState extends State<CustomInputText> with BaseMixin {
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

  final Debounce _debounce = Debounce(const Duration(milliseconds: 700));
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
      padding: EdgeInsets.only(top: widget.marginTop),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (widget.title.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: 7),
              child: RichText(
                text: TextSpan(children: [
                  TextSpan(
                    text: widget.title,
                    style: textStyle.bold(size: 12),
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
                ]),
              ),
            )
          else
            const SizedBox(),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: widget.onPress,
            child: Row(
              crossAxisAlignment: (widget.maxLines > 5)
                  ? CrossAxisAlignment.start
                  : CrossAxisAlignment.center,
              children: [
                if (widget.horizontalTitle != null)
                  Container(
                    width: 55,
                    margin: const EdgeInsets.only(right: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.horizontalTitle!,
                          style: textStyle.bold(size: 12),
                        ),
                        // if (widget.showRequired) RequiredWidget(),
                        // if (widget.showHorizontalOption)
                        //   Container(
                        //     margin: const EdgeInsets.only(top: 3),
                        //     color: color.color999999,
                        //     padding: const EdgeInsets.only(
                        //         left: 7, right: 7, top: 4, bottom: 3),
                        //     child: Text(
                        //       LocaleKeys.unRequired.tr,
                        //       style: textStyle.bold(
                        //           size: 10, color: color.white, height: 1),
                        //     ),
                        //   )
                      ],
                    ),
                  )
                else
                  const SizedBox(),
                Expanded(
                  child: TextFormField(
                    textAlignVertical: TextAlignVertical.top,
                    maxLines: widget.obscureText ? 1 : (widget.maxLines),
                    minLines: widget.obscureText ? 1 : (widget.minLines),
                    autocorrect: false,
                    enableSuggestions: false,
                    obscuringCharacter: '●',
                    scrollPadding:
                        widget.scrollPadding ?? const EdgeInsets.all(20.0),
                    textCapitalization: widget.textCapitalization,
                    maxLength: widget.maxLengthInputForm,
                    inputFormatters: widget.obscureText
                        ? [FilteringTextInputFormatter.deny(RegExp(r'\s'))]
                        : (widget.inputFormatters ?? []),
                    textAlign: widget.textAlign ?? TextAlign.start,
                    enabled: !widget.isReadOnly,
                    style: widget.styleText ??
                        textStyle.bold(color: color.black, size: 12),
                    onChanged: (String v) {
                      if (widget.onChangedDelay != null) {
                        _debounce(() {
                          if (!_isShowButtonClear.value || v.isEmpty) {
                            _isShowButtonClear.value = v.isNotEmpty;
                          }
                          widget.onChangedDelay?.call(v);
                        });
                      } else {
                        if (!_isShowButtonClear.value || v.isEmpty) {
                          _isShowButtonClear.value = v.isNotEmpty;
                        }
                        widget.onChanged?.call(v);
                      }
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
                      hintStyle: widget.hintStyle ??
                          textStyle.semiBold(size: 14, color: color.redColor),
                      hintText: widget.hintText,
                      fillColor: widget.fillColor ??
                          (widget.controller.text.isNotEmpty
                              ? color.white
                              : color.white),
                      filled: true,
                      isDense: true,
                      errorStyle: TextStyle(
                          height: 0.01, color: color.mainColor, fontSize: 0),
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(widget.borderRadius),
                        borderSide: BorderSide(
                          width: 1,
                          color: color.mainColor,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(widget.borderRadius),
                        borderSide: BorderSide(
                          width: 1,
                          color: color.redColor,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(widget.borderRadius),
                        borderSide: BorderSide(
                          width: 1,
                          color: color.black,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(widget.borderRadius),
                        borderSide: BorderSide(width: 1, color: color.black),
                      ),
                      contentPadding: widget.contentPadding ??
                          const EdgeInsets.fromLTRB(12, 18, 0, 18),
                      prefixIcon: _buildPrefixIcon,
                      prefixIconConstraints:
                          const BoxConstraints(maxWidth: 40, maxHeight: 40),
                      suffixIcon: widget.useSuffix || widget.suffixText != null
                          ? null
                          : _buildSuffixIcon,
                      suffix: !widget.useSuffix || widget.suffixText != null
                          ? null
                          : _buildSuffixIcon,
                      suffixText: widget.suffixText,
                      suffixIconConstraints:
                          const BoxConstraints(maxWidth: 40, maxHeight: 40),
                      counterStyle: const TextStyle(height: double.minPositive),
                      counterText: '',
                    ),
                    onTap: widget.onTap,
                  ),
                ),
              ],
            ),
          ),
          _errBuilder(),
        ],
      ),
    );
  }

  Widget _errBuilder() {
    return errText != null
        ? Padding(
            padding: EdgeInsets.only(
                top: 5, left: widget.horizontalTitle != null ? 60 : 0),
            child: Text(
              errText!,
              style: textStyle.regular(size: 12, color: color.redColor),
              maxLines: 3,
              textAlign: TextAlign.start,
            ),
          )
        : const SizedBox();
  }

  Widget? get _buildPrefixIcon {
    return widget.iconLeading != null
        ? Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Image.asset(widget.iconLeading!, width: 24, height: 24),
          )
        : null;
  }

  Widget? get _buildSuffixIcon {
    if (widget.suffixIcon != null) {
      return Padding(
          padding: const EdgeInsets.only(right: 10), child: widget.suffixIcon);
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
              child: Icon(
                _isShowText.value ? Icons.visibility_off : Icons.visibility,
                size: 18.0,
                color: _isShowText.value ? Colors.black : Colors.grey,
              ),
            ),
          )
        : Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Visibility(
              visible: _isShowButtonClear.value && !widget.isReadOnly,
              child: InkWell(
                onTap: () {
                  widget.controller.clear();
                  _isShowButtonClear.value = false;

                  if (widget.clearText != null) {
                    widget.clearText!();
                  }
                  if (widget.onChangedDelay != null) {
                    widget.onChangedDelay?.call('');
                  }
                },
                child: Padding(
                  padding: EdgeInsets.only(left: widget.useSuffix ? 0 : 7),
                  child: const Icon(
                    Icons.cancel,
                    color: Colors.grey,
                    size: 16,
                  ),
                ),
              ),
            ),
          );
  }
}
