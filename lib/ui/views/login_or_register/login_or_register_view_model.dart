import 'dart:async';

import 'package:flutter_age_fans/core/repositories/age_fans_repository/age_fans_repository.dart';
import 'package:flutter_age_fans/locator.dart';
import 'package:flutter_age_fans/ui/shared/global_provider.dart';
import 'package:flutter_age_fans/ui/shared/user_model.dart';
import 'package:logging/logging.dart';
import 'package:stacked/stacked.dart';

class LoginOrRegisterViewModel extends BaseViewModel {
  final AgeFansRepository _repository = locator<AgeFansRepository>();
  final _log = Logger('LoginOrRegisterViewModel');

  Future<String> login(String username, String password) {
    Completer completer = Completer<String>();
    _repository.login(username, password).then((user) {
      _log.info('login $user');
      GlobalProvider.readUser().saveUserInfo(user);
      completer.complete('');
    }).catchError((error) {
      _log.info('login catchError $error');
      completer.completeError(error.toString());
    });
    return completer.future as Future<String>;
  }

  Future<String> register(String username, String password) {
    Completer completer = Completer<String>();
    _repository.register(username, password).then((user) {
      _log.info('login $user');
      GlobalProvider.readUser().saveUserInfo(user);
      completer.complete('');
    }).catchError((error) {
      _log.info('login catchError $error');
      completer.completeError(error.toString());
    });
    return completer.future as Future<String>;
  }

}
