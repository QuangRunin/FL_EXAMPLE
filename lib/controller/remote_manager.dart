// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'package:example/base/loading_wrapper.dart';
import 'package:example/common/utils/utils.dart';
import 'package:example/data/model/common/app_version.dart';
import 'package:example/generated/locales.g.dart';
import 'package:example/service/firebase/remote_config_service.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

class RemoteManager {
  factory RemoteManager() {
    return _singleton;
  }
  RemoteManager._internal() {
    // _initRemote();
    _getVersionApp();
  }
  String? currentVersion;
  AppVersionModel? updateVersion;
  int? totalWish;
  bool initialMessageActive = false;

  DateTime? activeOTP;
  bool isOpenPopupUpdate = false;
  void setActiveOTP(value) {
    activeOTP = value;
  }

  void _initRemote() {
    final String data =
        RemoteConfigService().remoteConfig.getString('app_version').toString();
    if (data.isNotEmpty) {
      updateVersion = AppVersionModel.fromMap(jsonDecode(data));
    }
  }

  void upgradeApp() {
    Future(() async {
      final String? tempVersion = updateVersion?.appVersion;
      if (tempVersion != null &&
          tempVersion.isNotEmpty &&
          isOpenPopupUpdate == false) {
        await _getVersionApp();

        if (_convertVersion(tempVersion) > _convertVersion(currentVersion)) {
          final bool temp = updateVersion?.requiredUpdate ?? true;
          isOpenPopupUpdate = true;
          Get.find<LoadingController>().showCustomGeneralDialog(
            title: LocaleKeys.pleaseUpdateApp.tr,
            message: LocaleKeys.needUpdateApp.tr,
            acceptText: LocaleKeys.update.tr,
            showOnlyConfirm: temp,
            barrierDismissible: !temp,
            onCancel: () => isOpenPopupUpdate = false,
            onConfirm: () {
              isOpenPopupUpdate = false;
              openBrowser(updateVersion?.linkUrl);
            },
          );
        }
      }
    });
  }

  int _convertVersion(String? value) {
    if (value != null && value.isNotEmpty) {
      return int.parse(value.replaceAll('.', ''));
    }
    return 0;
  }

  Future<void> _getVersionApp() async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();

    currentVersion = packageInfo.version;
  }

  static final RemoteManager _singleton = RemoteManager._internal();
}
