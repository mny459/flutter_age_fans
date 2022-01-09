import 'package:flutter/material.dart';

/// Pager中使用的
class KeepAliveWidget extends StatefulWidget {
  final Widget child;
  final VoidCallback? initState;
  const KeepAliveWidget(this.child, {this.initState});

  @override
  State<StatefulWidget> createState() => KeepAliveState();
}

class KeepAliveState extends State<KeepAliveWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    widget.initState?.call();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }
}

Widget keepAliveWrapper(Widget child) {
  return KeepAliveWidget(child);
}
