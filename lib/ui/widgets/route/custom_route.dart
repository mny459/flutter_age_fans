import 'package:flutter/widgets.dart';

/// 路由通知
class CustomRoute extends PageRoute {
  final WidgetBuilder? builder;

  CustomRoute({
    RouteSettings? settings,
    this.builder,
    this.transitionDuration = const Duration(milliseconds: 300),
    this.barrierColor,
    this.barrierLabel,
    this.maintainState = true,
    bool fullscreenDialog = false,
  }) : super(settings: settings, fullscreenDialog: fullscreenDialog);

  /// 路由过程中的背景颜色
  @override
  final Color? barrierColor;

  @override
  final String? barrierLabel;

  /// 是否保存路由状态
  @override
  final bool maintainState;

  /// 路由持续时间
  @override
  final Duration transitionDuration;

  /// 构建页面
  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return builder!(context);
  }

  /// 自定义动画 child 为 buildPage 方法构建出的组件
  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return super
        .buildTransitions(context, animation, secondaryAnimation, child);
  }
}
