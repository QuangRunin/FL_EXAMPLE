import 'package:example/base/cache_manager.dart';

class GlobalDataManager with CacheManager {
  factory GlobalDataManager() {
    return _singleton;
  }
  GlobalDataManager._internal();

  bool passBoarding = false;

  bool isOpenAppSetting = false;
  String versionApp = '';
  String versionOS = '';
  // final AuthUseCase _authUseCase = AuthUseCase();
  // Rx<UserInfo> userInfo = const UserInfo().obs;

  // Future<void> _initGlobalData() async {
  //   versionApp = await getAppVersion();
  //   versionOS = await getVersionOS();
  //   passBoarding = getPassBoarding() ?? false;
  //   userInfo.value = await getUserInfo();
  // }

  // Future<void> getNewUserInfo() async {
  //   userInfo.value = await getUserInfo();
  // }

  // void checkLogin() {
  //   if (getToken() != null) {
  //     Get.offAllNamed(AppRouter.routerDashboard);
  //   } else {
  //     Get.offAllNamed(AppRouter.routerStart);
  //   }
  // }

  // Future<void> getUserInfoWithApi() async {
  //   await _authUseCase.getUserInfo(
  //     onSuccess: (UserInfo data) async {
  //       removeUserInfo();
  //       UserInfo newUserInfo = data;
  //       newUserInfo =
  //           newUserInfo.copyWith(type_login: userInfo.value.type_login);
  //       await saveUserInfo(newUserInfo);
  //       userInfo.value = await getUserInfo();
  //       userInfo.refresh();
  //     },
  //     onFailure: (err) {},
  //   );
  // }

  static final GlobalDataManager _singleton = GlobalDataManager._internal();
}
