import 'package:example/config/dev_config.dart';
import 'package:example/config/prod_config.dart';
import 'package:example/config/stg_config.dart';

class AppConfig {
  static late BaseConfig config;

  static void setProd() {
    config = ProductConfig();
  }

  static void setStg() {
    config = StagingConfig();
  }

  static void setDev() {
    config = DevConfig();
  }

  static void setEnvironment({required BaseConfig valueConfig}) {
    config = valueConfig;
  }
}

abstract class BaseConfig {
  String get baseUrl;
  String get baseWebviewUrl;
}
