import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_age_fans/core/helper/platform_helper.dart';
import 'package:flutter_age_fans/core/services/cache/cache_service.dart';
import 'package:flutter_age_fans/generated/l10n.dart';
import 'package:flutter_bugly/flutter_bugly.dart';
import 'package:flutter_age_fans/core/constant/routers.dart';
import 'package:flutter_age_fans/ui/views/login_or_register/login_or_register_view.dart';
import 'package:flutter_age_fans/ui/views/ani_main/main_view.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:flutter_age_fans/core/managers/core_manager.dart';
import 'package:flutter_age_fans/core/services/navigation/navigation_service.dart';
import 'package:flutter_age_fans/locator.dart';
import 'package:flutter_age_fans/logger.dart';
import 'package:flutter_age_fans/provider_setup.dart';
import 'package:flutter_age_fans/ui/shared/themes.dart' as themes;
import 'package:flutter_age_fans/local_setup.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLogger();
  await setupLocator();
  final cacheServiceImpl = locator<CacheService>();
  await cacheServiceImpl.init();
  // app状态栏颜色
  var systemUiOverlayStyle = const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark);
  // 无appbar情况下的颜色，默认设置为黑色。有appbar的情况已在common里设置
  SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);

  FlutterError.onError = (FlutterErrorDetails details) async {
    // 线上环境，走上报逻辑
    if (kReleaseMode) {
      Zone.current.handleUncaughtError(details.exception, details.stack!);
    } else {
      // 开发期间，走Console抛出
      FlutterError.dumpErrorToConsole(details);
    }
  };
  if (PlatformHelper.isAndroid()) {
    FlutterBugly.postCatchedException(() {
      // 可以在这里集中收集异常
      runZonedGuarded(
        () => runApp(MyApp()),
        (error, stackTrace) {
          _reportError(error, stackTrace);
        },
      );
    }, debugUpload: true);
  } else {
    // 可以在这里集中收集异常
    runZonedGuarded(
      () => runApp(MyApp()),
      (error, stackTrace) {
        _reportError(error, stackTrace);
      },
    );
  }
}

class MyApp extends StatelessWidget {
  final NavigationService? navigationService = locator<NavigationService>();

  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: MultiProvider(
        providers: providers,
        child: CoreManager(
          child: Consumer<themes.ThemeProvider>(
            builder: (_, model, child) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: model.themeData(),
                darkTheme: model.themeData(platformDarkMode: true),
                themeMode: model.themeMode,
                localizationsDelegates: localizationsDelegates,
                supportedLocales: S.delegate.supportedLocales,
                localeResolutionCallback: loadSupportedLocals,
                onGenerateTitle: (context) => S.of(context).appName,
                navigatorKey: navigationService!.navigatorKey,
                onGenerateRoute: (settings) {
                  late Widget pageChild;
                  switch (settings.name) {
                    case RouterName.login:
                      pageChild = LoginOrRegisterView();
                      break;
                    case RouterName.webView:
                      pageChild = const WebView();
                      break;
                  }
                  return MaterialPageRoute(
                      settings: settings,
                      builder: (context) {
                        return pageChild;
                      });
                },
                home: MainView(),
                initialRoute: '/',
              );
            },
          ),
        ),
      ),
    );
  }
}

void _reportError(Object error, StackTrace stackTrace) {
  if (kDebugMode) {
    print('Dart 异常 $error $stackTrace');
  }
}
