import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
// ignore: depend_on_referenced_packages
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:example/import.dart';

extension CameraImageEx on XFile {
  static Future<XFile?> handlePickImage({
    required ImageSource source,
    double maxHeight = 720,
    double maxWidth = 720,
  }) async {
    if (await requestPermission(source) == true) {
      final result = await ImagePicker().pickImage(
        maxHeight: maxHeight,
        maxWidth: maxWidth,
        source: source,
      );
      return result;
    } else {
      return null;
    }
  }

  static Future<bool> requestPermission(ImageSource source) async {
    final PermissionStatus? permission;
    switch (source) {
      case ImageSource.camera:
        await Permission.camera.request();
        permission = await Permission.camera.status;
        break;
      case ImageSource.gallery:
        int androidVersion = 0;
        if (GetPlatform.isAndroid) {
          final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
          final AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
          androidVersion = int.parse(androidInfo.version.release);
        }
        if (GetPlatform.isIOS || androidVersion > 12) {
          await Permission.photos.request();
          permission = await Permission.photos.status;
        } else {
          await Permission.storage.request();
          permission = await Permission.storage.status;
        }

        break;
    }

    switch (permission) {
      case PermissionStatus.granted:
      case PermissionStatus.limited:
        return true;
      case PermissionStatus.denied:
      case PermissionStatus.restricted:
      case PermissionStatus.permanentlyDenied:
      case PermissionStatus.provisional:
        _showRequestPermission(source == ImageSource.camera
            ? LocaleKeys.requestCamera.tr
            : LocaleKeys.requestGallery.tr);
        return false;
    }
  }

  static void _showRequestPermission(String message) {
    showCupertinoDialog(
      context: Get.context!,
      barrierDismissible: true,
      builder: (context) => CupertinoAlertDialog(
        content: Text(
          message,
          style: AppTextStyle().regular(size: 14),
        ),
        actions: <Widget>[
          CupertinoDialogAction(
            child: Text(
              LocaleKeys.goToSetting.tr,
              style: AppTextStyle().regular(size: 16, color: Colors.blue),
            ),
            onPressed: () {
              Navigator.of(context).pop();
              openAppSettings();
            },
          ),
          CupertinoDialogAction(
            child: Text(
              LocaleKeys.cancel.tr,
              style: AppTextStyle().regular(size: 16, color: Colors.red),
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }
}
