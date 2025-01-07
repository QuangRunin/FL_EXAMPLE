import 'dart:async';

import 'package:example/base/base_run_main.dart';
import 'package:example/config/prod_config.dart';

Future<void> main() async {
  BaseRunMain.runMainApp(config: ProductConfig());
}
