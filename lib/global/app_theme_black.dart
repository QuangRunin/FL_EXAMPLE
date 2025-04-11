import 'package:flutter/material.dart';
import 'app_text_style.dart';
import 'app_theme.dart';

class AppThemeBlack extends AppTheme {
  AppTextStyle get textStyle => AppTextStyle.share;

  @override
  ThemeData get theme => ThemeData(
        scaffoldBackgroundColor: backgroundColor,
        dialogBackgroundColor: mainColor,
        appBarTheme: _buildAppBarTheme,
        bottomAppBarTheme: _buildBottomAppBarTheme,
        dialogTheme: _buildDialogTheme,
      );
  AppBarTheme get _buildAppBarTheme => AppBarTheme(
        elevation: 0,
        iconTheme: IconThemeData(color: backgroundColor),
      );

  BottomAppBarTheme get _buildBottomAppBarTheme =>
      const BottomAppBarTheme(elevation: 0);

  DialogTheme get _buildDialogTheme => const DialogTheme(elevation: 0);

  @override
  Color get mainColor => const Color(0xFF3184F2);

  @override
  Color get black => const Color(0xFF000000);

  @override
  Color get backgroundColor => const Color(0xFF000000);

  @override
  Color get white => const Color(0xFFFFFFFF);

  @override
  Color get redColor => const Color(0xFFDD0000);

  @override
  Color get inActiveIndicator => const Color(0xFF4EA9F6);

  @override
  Color get color999999 => const Color(0xFF999999);

  @override
  Color get greyColor => const Color(0xFFD9D9D9);

  @override
  Color get borderLightColor => const Color(0xFFD9D9D9);

  @override
  Color get inputColor => const Color(0xFFFCFCFC);

  @override
  Color get disableButtonColor => const Color(0xFF999999);
}
