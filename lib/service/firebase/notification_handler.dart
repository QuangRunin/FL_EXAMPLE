// import 'dart:convert';

// class NotificationHandler {
//   static final flutterLocalNotificationPlugin =
//       FlutterLocalNotificationsPlugin();
//   static BuildContext? myContext;

//   static void initNotification() {
//     const initAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');

//     const initIOS = DarwinInitializationSettings(
//       onDidReceiveLocalNotification: onDidReceiveLocalNotification,
//     );

//     const initSetting =
//         InitializationSettings(android: initAndroid, iOS: initIOS);
//     flutterLocalNotificationPlugin.initialize(
//       initSetting,
//       onDidReceiveNotificationResponse: _onSelectNotification,
//       onDidReceiveBackgroundNotificationResponse: _onSelectNotification,
//     );
//   }

//   static void _onSelectNotification(NotificationResponse notificationResponse) {
//     moveTheScreen(notificationResponse.payload);
//   }

//   static Future<void> moveTheScreen(String? payload) async {
//     AppLog.dbPrint('PAYLOAD MoveTheScreen $payload');
//     if (payload != null && Get.isRegistered<DashboardController>()) {
//       if (isRegisterController<VideoDetailController>()) {
//         findController<VideoDetailController>().pauseVideoWhenNextPage();
//       }
//       final String jsonString =
//           payload.replaceAllMapped(RegExp(r'(\w+):\s*([^,}]+)'), (match) {
//         final key = match[1];
//         final value = match[2];
//         if (!RegExp(r'^\d+$').hasMatch(value ?? ''.trim())) {
//           return '"$key": "${value?.trim()}"';
//         }
//         return '"$key": ${value?.trim()}';
//       });
//       final PushData data = PushData.fromMap(jsonDecode(jsonString));
//       final id = data.notificationId;
//       switch (data.path) {
//         case '/notification':
//           Get.toNamed(AppRouter.routerNotificationDetail, arguments: id);
//           break;
//         case '/interview':
//           Get.toNamed(AppRouter.routerVideoDetail,
//               arguments:
//                   PostTopikDetail(post: Post(id: id, video_upload_type: 2)));
//           break;
//         case '/post':
//           Get.toNamed(AppRouter.routerPostDetail, arguments: Post(id: id));
//           break;
//         case '/exam':
//           Get.toNamed(
//             AppRouter.routerPostByTopik,
//             arguments: TopikLevel(
//               id: 3,
//               name: LocaleKeys.topicTypeExam,
//               icon_url: AssetIcons.iconMultiQues,
//             ),
//           );
//           break;
//       }
//     }
//   }

//   static Future onDidReceiveLocalNotification(
//     int? id,
//     String? title,
//     String? body,
//     String? payload,
//   ) async {
//     AppLog.print('PAYLOAD ios $payload');
//   }
// }
