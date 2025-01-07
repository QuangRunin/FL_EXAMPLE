import 'package:flutter/foundation.dart';

class AppLog {
  static void dbPrint(dynamic mms) {
    if (!kReleaseMode) {
      debugPrint(mms);
    }
  }

  static void print(dynamic mms) {
    if (!kReleaseMode) {
      debugPrint(
          '====================================> $mms <====================================');
    }
  }

  static void err(dynamic msg) {
    if (!kReleaseMode) {
      debugPrint('\x1B[31m$msg\x1B[0m');
    }
  }

  static void success(dynamic msg) {
    if (!kReleaseMode) {
      debugPrint('\x1B[34m$msg\x1B[34m');
    }
  }

  static void warning(dynamic msg) {
    if (!kReleaseMode) {
      debugPrint('\x1B[33m$msg\x1B[33m');
    }
  }
}
