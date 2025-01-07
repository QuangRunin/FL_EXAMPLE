import 'package:example/pages/splash/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppRouter {
  static const String routerSplash = '/splash';

  static const curve = Curves.fastOutSlowIn;
  static var transition =
      GetPlatform.isAndroid ? Transition.native : Transition.cupertino;
  static const transitionDuration = Duration(milliseconds: 300);

  static List<GetPage<dynamic>> getPages = <GetPage<dynamic>>[
    GetPage<SplashPage>(
      name: routerSplash,
      page: () => SplashPage(),
      curve: curve,
      transition: transition,
      transitionDuration: transitionDuration,
    ),
  ];
}
