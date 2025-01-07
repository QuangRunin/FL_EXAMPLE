import 'package:get_storage/get_storage.dart';
import 'package:example/controller/controller_manager.dart';
import 'package:example/global/app_enum.dart';

mixin CacheManager {
  final GetStorage _box = GetStorage();
  Future<bool> removeAllCache() async {
    Future.wait([]);
    ControllerManager().tags = [];
    return true;
  }

  // ============================= passBoarding ============================= //
  void savePassBoarding(bool value) {
    _box.write(CacheManagerKey.passBoarding.toString(), value);
  }

  bool? getPassBoarding() {
    return _box.read(CacheManagerKey.passBoarding.toString());
  }

  Future<void> removePassBoarding() async {
    await _box.remove(CacheManagerKey.passBoarding.toString());
  }
}
