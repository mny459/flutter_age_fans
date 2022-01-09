import 'package:flutter/widgets.dart';
import 'package:flutter_age_fans/core/services/navigation/navigation_service.dart';
import 'package:flutter_age_fans/locator.dart';
import 'package:flutter_age_fans/ui/shared/user_model.dart';
import 'package:provider/provider.dart';

class GlobalProvider {
  GlobalProvider._();

  static UserModel readUser() {
    final navigationService = locator<NavigationService>();
    return navigationService.navigatorKey.currentContext!.read<UserModel>();
  }

  static UserModel watchUser(BuildContext context) {
    return context.watch<UserModel>();
  }

}
