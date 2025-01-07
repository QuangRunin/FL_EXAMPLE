# Example App

   Flutter Project

## Getting Started

- [Flutter: Manager version app](https://docs.flutter.dev/release/archive?tab=macos)
   Flutter 3.27.1 • channel stable • <https://github.com/flutter/flutter.git>
   Framework • revision 17025dd882 • 2024-12-17 03:23:09 +0900
   Engine • revision cb4b5fff73
   Tools • Dart 3.6.0 • DevTools 2.40.2

- [Get cli: generated code](https://pub.dev/packages/get_cli)
  - generated locales: get generate locales assets/translations

- [Freezed: generate json_serializable](https://pub.dev/packages/freezed)
  - dart run build_runner build
  - flutter pub run build_runner build --delete-conflicting-outputs

- [FVM: Manager version app](https://fvm.app/)
  - DEV:
    - fvm flutter build apk --flavor dev -t lib/main_dev.dart
  - STG:
    - fvm flutter build apk --flavor stg -t lib/main_stg.dart
  - PROD:
    - fvm flutter build apk --flavor stg -t lib/main_prod.dart
    - fvm flutter build appbundle --flavor prod -t lib/main_prod.dart
    - fvm flutter build ios --release  --flavor prod -t lib/main_prod.dart
