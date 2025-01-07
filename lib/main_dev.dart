import 'dart:async';

import 'package:example/base/base_run_main.dart';
import 'package:example/config/dev_config.dart';

Future<void> main() async {
  BaseRunMain.runMainApp(config: DevConfig());
}
