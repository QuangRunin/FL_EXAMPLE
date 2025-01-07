import 'package:example/import.dart';

class ControllerManager {
  factory ControllerManager() {
    return _singleton;
  }

  ControllerManager._internal();

  static final ControllerManager _singleton = ControllerManager._internal();

  Rx<String> currentController = ''.obs;
  bool expired = false;
  int currentTagIndex = 0;

  List<String> tags = [];
  Future<void> setExpired(value) async {
    expired = value;
  }

  void handleOnClose(String controllerName) {
    final index =
        tags.lastIndexWhere((element) => element.contains(controllerName));
    if (index != -1) {
      tags.removeAt(index);
    }
  }
}
