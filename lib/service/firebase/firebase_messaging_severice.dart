// import 'dart:convert';
// import 'dart:math';

// class FirebaseMessagingService with CacheManager {
//   factory FirebaseMessagingService() {
//     return _singleton;
//   }
//   FirebaseMessagingService._internal();
//   FirebaseMessaging? messaging = FirebaseMessaging.instance;
//   Future<void> requestPermission() async {
//     final settings = await messaging!.requestPermission(
//         alert: true,
//         announcement: true,
//         badge: true,
//         carPlay: false,
//         criticalAlert: false,
//         provisional: false,
//         sound: true);
//     if (settings.authorizationStatus == AuthorizationStatus.authorized) {
//       AppLog.print('User granted permission');
//     } else if (settings.authorizationStatus ==
//         AuthorizationStatus.provisional) {
//       AppLog.print('User granted provisional permission');
//     } else {
//       AppLog.print('User declined or has not accepted permission');
//     }
//   }

//   void setupFirebase() {
//     NotificationHandler.initNotification();
//     _firebaseCloudMessagingListener();
//     _createNotificationChannel();
//   }

//   Future<void> handleInitialMessage() async {
//     await _registerFcmToken();
//     NotificationHandler.flutterLocalNotificationPlugin
//         .getNotificationAppLaunchDetails()
//         .then((NotificationAppLaunchDetails? value) {
//       if (value?.notificationResponse?.payload != null) {
//         NotificationHandler.moveTheScreen(value?.notificationResponse?.payload);
//       }
//     });
//     FirebaseMessaging.instance
//         .getInitialMessage()
//         .then((RemoteMessage? message) async {
//       if (message != null) {
//         NotificationHandler.moveTheScreen(message.data.toString());
//       }
//     });
//     return;
//   }

//   Future<void> _registerFcmToken() async {
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//       if (getFcmToken() == null) {
//         messaging?.getToken().then((token) async {
//           AppLog.dbPrint('FCM => $token');
//           _createFcmToken(token);
//         });
//       } else {
//         // messaging?.onTokenRefresh.listen(
//         //   (String? refreshToken) {
//         //     if (refreshToken != null && getFcmToken() != refreshToken) {
//         //       AppLog.dbPrint('Refresh FCM TOKEN');
//         //       _createFcmToken(refreshToken);
//         //     }
//         //   },
//         // );
//       }
//     });
//   }

//   Future<void> _createFcmToken(String? token) async {
//     NotificationUseCase().createFcmToken(
//       params: FcmParam(fcmToken: token, deviceId: await getDeviceId()),
//       onSuccess: () async {
//         await saveFcmToken(token);
//         AppLog.dbPrint(
//             '=============> REGISTER FCM TOKEN SUCCESS <=============');
//       },
//       onFailure: (err) {
//         AppLog.dbPrint(
//             '=============> REGISTER FCM TOKEN ${err.message} <=============');
//       },
//     );
//   }

//   Future<void> _firebaseCloudMessagingListener() async {
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       AppLog.dbPrint(
//           '=============> onMessage <============= ${jsonEncode(message.toMap())} ');
//       showNotification(message);
//     });

//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       AppLog.dbPrint('=============> onMessageOpenedApp <=============');
//       NotificationHandler.moveTheScreen(jsonEncode(message.data));
//     });
//   }

//   static Future<void> _createNotificationChannel() async {
//     const AndroidNotificationChannel channel = AndroidNotificationChannel(
//       'high_importance_channel',
//       'High Importance Notifications',
//       importance: Importance.max,
//     );
//     final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//         FlutterLocalNotificationsPlugin();

//     await flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<
//             AndroidFlutterLocalNotificationsPlugin>()
//         ?.createNotificationChannel(channel);
//   }

//   static Future<void> showNotification(RemoteMessage message) async {
//     const android = AndroidNotificationDetails(
//       'high_importance_channel',
//       'High Importance Notifications',
//       importance: Importance.max,
//       priority: Priority.max,
//       ticker: 'VJ Ticker',
//       icon: '@mipmap/ic_launcher',
//       enableVibration: true,
//       channelShowBadge: true,
//     );
//     const ios = DarwinNotificationDetails(
//       presentAlert: true,
//       presentSound: true,
//       presentBadge: true,
//     );
//     const platformChannelSpecific =
//         NotificationDetails(android: android, iOS: ios);
//     if (message.notification?.title != null) {
//       final int messageId = Random().nextInt(900000) + 100;
//       await NotificationHandler.flutterLocalNotificationPlugin.show(
//         messageId,
//         parse(message.notification?.title).body?.text,
//         parse(message.notification?.body).body?.text,
//         platformChannelSpecific,
//         payload: jsonEncode(message.data),
//       );
//     }
//   }

//   static final FirebaseMessagingService _singleton =
//       FirebaseMessagingService._internal();
// }
