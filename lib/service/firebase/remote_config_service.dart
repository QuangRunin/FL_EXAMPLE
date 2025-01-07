// ignore: depend_on_referenced_packages
import 'package:firebase_remote_config/firebase_remote_config.dart';

class RemoteConfigService {
  final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;
  Future<FirebaseRemoteConfig> setupRemoteConfig() async {
    await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(minutes: 1),
      minimumFetchInterval: const Duration(seconds: 5),
    ));
    remoteConfig.fetchAndActivate();
    return remoteConfig;
  }
}
