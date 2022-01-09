import 'package:flutter/material.dart';

class CustomRouteObserver extends RouteObserver<PageRoute<dynamic>> {
  /// 监听导航器的 push 操作
  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    print('Route..didPush route: $route,previousRoute:$previousRoute');
  }

  /// 监听导航器的 pop 操作
  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    print('Route..didPop route: $route,previousRoute:$previousRoute');
  }

  /// 监听导航器的 replace 操作
  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
  }

  /// 监听导航器的 remove 操作
  @override
  void didRemove(Route route, Route? previousRoute) {
    super.didRemove(route, previousRoute);
  }
}
