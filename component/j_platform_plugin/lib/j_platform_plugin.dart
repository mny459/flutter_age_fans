import 'dart:async';

import 'package:flutter/services.dart';

class JPlatformPlugin {
  static const MethodChannel _channel =
      const MethodChannel('j_platform_plugin');

  static const _METHOD_GET_REFRESH_RATE = "get_refresh_rate";
  static const _TAG = "JPlatformPlugin.Flutter";

  static Future<num> get refreshRate async {
    final rate = await _channel.invokeMethod(_METHOD_GET_REFRESH_RATE);
    _log('refreshRate $rate runtimeType ${rate.runtimeType}');
    return rate;
  }

  static void _log(Object content) {
    print('$_TAG - ${content.toString()}');
  }
}
