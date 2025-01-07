import 'package:example/base/loading_wrapper.dart';
import 'package:example/controller/global_data_manager.dart';
import 'package:example/controller/remote_manager.dart';
import 'package:example/import.dart';

Future<void> setupLocator() async {
  Get.put<AppThemeBase>(AppThemeBase());

  Get.put<RemoteManager>(RemoteManager());

  Get.put<LoadingController>(LoadingController());

  Get.put<GlobalDataManager>(GlobalDataManager());
}
