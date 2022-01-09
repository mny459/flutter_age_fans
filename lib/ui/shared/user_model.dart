import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_age_fans/core/models/ani_user/ani_user_bean.dart';
import 'package:flutter_age_fans/core/services/key_storage/key_storage_service.dart';
import 'package:flutter_age_fans/locator.dart';
import 'package:logging/logging.dart';

class UserModel extends ChangeNotifier {
  final _log = Logger('UserModel');

  AniUserBean? _me;

  AniUserBean? get me => _me;

  bool get hasLogin => _me != null;

  final KeyStorageService _keyStorageService = locator<KeyStorageService>();

  void saveUserInfo(AniUserBean user) async {
    _keyStorageService.userInfo = user.toJson().toString();
    _me = user;
    notifyListeners();
  }

  void initUserInfo() {
    var userInfo = _keyStorageService.userInfo;
    if (userInfo.isNotEmpty == true) {
      _me = AniUserBean.fromJson(jsonDecode(userInfo));
      notifyListeners();
    }
  }

  void clearUserInfo() {
    _keyStorageService.userInfo = '';
    _me = null;
    _log.severe(
        'hasLogin = $hasLogin userInfo = ${_keyStorageService.userInfo} _me = $_me');
    notifyListeners();
  }
}
