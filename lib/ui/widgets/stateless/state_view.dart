import 'package:flutter/cupertino.dart';

import 'loading_animation.dart';
import 'retry_view.dart';

class StateView extends StatelessWidget {
  final bool loadingOrError;
  final bool hasError;
  final Widget? child;
  final Function? onRetry;

  const StateView(
      {Key? key,
      this.loadingOrError = false,
      this.hasError = false,
      this.child,
      this.onRetry})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (loadingOrError) {
      if (hasError) {
        return RetryView(onRetry);
      } else {
        return const CenterLoadingAnimation();
      }
    }
    return child ?? Container();
  }
}
