import 'package:example/global/app_theme_black.dart';
import 'package:example/global/app_theme_bright.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'app_base_color.dart';
import 'app_const.dart';

enum AppThemeType { black, bright }

AppTheme appThemes = AppThemeBright();

abstract class AppTheme implements BaseColor {
  ThemeData get theme;
}

class AppThemeBase {
  AppThemeBase() {
    ever(_appTheme, (AppThemeType type) {
      appThemes = theme;
      Get.changeTheme(theme.theme);
      Get.forceAppUpdate();
    });

    _initThemeModeFromSharedPref();
  }

  static final Rx<AppThemeType> _appTheme = AppThemeType.bright.obs;

  AppThemeType get appTheme => _appTheme.value;

  AppTheme get theme =>
      appTheme == AppThemeType.black ? AppThemeBright() : AppThemeBlack();

  ThemeData get themeData => theme.theme;

  Future<void> changeAppTheme(AppThemeType appThemeType) async {
    await saveThemeModeInSharedPref(appThemeType);
  }

  Future<void> _initThemeModeFromSharedPref() async {
    final String? themeModeFromPref = GetStorage().read(AppConst.keyThemeMode);

    _appTheme.value = themeModeFromPref == null ||
            themeModeFromPref == AppThemeType.bright.toString()
        ? AppThemeType.black
        : AppThemeType.bright;

    appThemes = theme;
  }

  static Future<void> saveThemeModeInSharedPref(AppThemeType type) async {
    if (_appTheme.value != type) {
      _appTheme.value = type;
      // Get.changeTheme(AppThemeBase().themeData);
      GetStorage().write(AppConst.keyThemeMode, type.toString());
    }
  }
}
