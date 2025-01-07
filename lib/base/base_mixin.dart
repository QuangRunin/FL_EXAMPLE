import 'package:example/import.dart';

mixin BaseMixin {
  AppTheme get color => Get.find<AppThemeBase>().theme;

  // bool get eb => LocalizationService.locale.languageCode == AppConst.langEN;

  AppTextStyle get textStyle => AppTextStyle.share;

  AppSized get sized => AppSized.share;
}

mixin MixinWidget<T extends StatelessWidget> on BaseMixin {}
