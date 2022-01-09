
import 'package:flutter_age_fans/core/helper/platform_helper.dart';
import 'package:flutter_age_fans/core/services/http/cookie_util.dart';
import 'package:flutter_age_fans/ui/shared/global_provider.dart';
import 'package:logging/logging.dart';
import 'package:stacked/stacked.dart';

class MineViewModel extends BaseViewModel {
  final _log = Logger('MineViewModel');

  // 本地清空用户信息即可
  void quitLogin() {
    // 1. 用户信息
    GlobalProvider.readUser().clearUserInfo();
    if (PlatformHelper.isMobile()) {
      // 2. Cookie
      CookieUtil.deleteAllCookies();
    }
  }
}
