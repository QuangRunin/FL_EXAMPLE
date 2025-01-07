import 'package:example/base/base_mixin.dart';
import 'package:example/base/cache_manager.dart';
import 'package:example/base/loading_wrapper.dart';
import 'package:example/global/app_log.dart';
import 'package:example/global/app_router.dart';
import 'package:example/global/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'service/localization/localization_service.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>
    with BaseMixin, CacheManager, WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      enableLog: true,
      translations: LocalizationService(),
      locale: LocalizationService.locale,
      fallbackLocale: LocalizationService.fallbackLocale,
      color: color.white,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate
      ],
      navigatorObservers: [CustomRouteObserver()],
      supportedLocales: LocalizationService.locales,
      debugShowCheckedModeBanner: false,
      title: 'Example',
      theme: Get.find<AppThemeBase>().themeData,
      builder: (BuildContext context, Widget? child) {
        return ScreenUtilInit(
          designSize: const Size(430, 932),
          minTextAdapt: true,
          splitScreenMode: true,
          child: MediaQuery(
            data: MediaQuery.of(context)
                .copyWith(textScaler: const TextScaler.linear(1)),
            child: LoadingWrapper(child: child),
          ),
        );
      },
      initialRoute: AppRouter.routerSplash,
      getPages: AppRouter.getPages,
      defaultTransition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 280),
    );
  }
}

class CustomRouteObserver extends NavigatorObserver {
  final List<String> screenHistory = [];

  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    if (route.settings.name != null) {
      screenHistory.add(route.settings.name!);
      AppLog.print(screenHistory);
    }
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    if (route.settings.name != null) {
      screenHistory.remove(route.settings.name);
    }
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (oldRoute?.settings.name != null) {
      screenHistory.remove(oldRoute?.settings.name);
    }
    if (newRoute?.settings.name != null) {
      screenHistory.add(newRoute!.settings.name!);
    }
  }
}
