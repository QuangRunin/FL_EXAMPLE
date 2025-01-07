import 'dart:async';

import 'package:example/import.dart';

class LifecycleEventHandler extends WidgetsBindingObserver {
  factory LifecycleEventHandler() {
    return _singleton;
  }

  LifecycleEventHandler._internal() {
    WidgetsBinding.instance.addObserver(this);
  }
  static final LifecycleEventHandler _singleton =
      LifecycleEventHandler._internal();

  final StreamController<AppLifecycleState> _notifyLifecycle =
      StreamController<AppLifecycleState>.broadcast();

  Stream<AppLifecycleState> get streamNotifyLifecycle =>
      _notifyLifecycle.stream;

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    AppLog.print(state.name);
    _notifyLifecycle.add(state);
    switch (state) {
      case AppLifecycleState.resumed:
        _upgradeVersion();
        break;
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.paused:
        break;
      case AppLifecycleState.detached:
        break;
      case AppLifecycleState.hidden:
    }
  }

  void _upgradeVersion() {
    // if (Get.currentRoute == AppRouter.routerSignIn ||
    //     Get.currentRoute == AppRouter.routerDashboard) {
    //   if (RemoteManager().updateVersion?.requiredUpdate == true) {
    //     RemoteManager().upgradeApp();
    //   }
    // }
  }
}
