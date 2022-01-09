import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_age_fans/ui/shared/theme_helper.dart';
import 'package:logging/logging.dart';

class NetworkImageHelper {
  NetworkImageHelper._();

  static final _logger = Logger('NetworkImageHelper');

  static Widget? handleErrorLoadState(ExtendedImageState state) {
    switch (state.extendedImageLoadState) {
      case LoadState.failed:
        _logger.severe('error ${state.lastException}');
        return Center(
          child: Text(
            '图片异常',
            style: TextStyle(fontSize: 14, color: ThemeHelper.onSurfaceColor()),
          ),
        );
      case LoadState.loading:
        return const CupertinoActivityIndicator();
      case LoadState.completed:
        return null;
    }
  }

  static Widget? handleEmptyLoadState(ExtendedImageState state) {
    switch (state.extendedImageLoadState) {
      case LoadState.failed:
        return Container(color: ThemeHelper.onSurfaceColor());
      case LoadState.loading:
        return const CupertinoActivityIndicator();
      case LoadState.completed:
        return null;
    }
  }
}
