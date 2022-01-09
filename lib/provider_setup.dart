import 'package:flutter_age_fans/ui/shared/themes.dart';
import 'package:flutter_age_fans/ui/shared/user_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:flutter_age_fans/core/enums/connectivity_status.dart';
import 'package:flutter_age_fans/core/services/connectivity/connectivity_service.dart';
import 'package:flutter_age_fans/locator.dart';

// Provider
List<SingleChildWidget> providers = [
  ...independentServices,
  ...dependentServices,
  ...uiConsumableProviders
];

List<SingleChildWidget> independentServices = [];

List<SingleChildWidget> dependentServices = [];

List<SingleChildWidget> uiConsumableProviders = [
  StreamProvider<ConnectivityStatus>(
    create: (context) => locator<ConnectivityService>().connectivity$,
    initialData: ConnectivityStatus.cellular,
  ),
  ChangeNotifierProvider(
    create: (_) => UserModel(),
    lazy: true,
  ),
  ChangeNotifierProvider(
    create: (_) => ThemeProvider(),
    lazy: true,
  ),
];
