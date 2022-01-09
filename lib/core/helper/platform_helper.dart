import 'dart:io';

import 'package:flutter/foundation.dart';

class PlatformHelper {

  PlatformHelper._();

  static bool isWeb() {
    return kIsWeb;
  }

  static bool isMobile() {
    return isAndroid() || isIOS();
  }

  static bool isDesktop() {
    return isWindows() || isMacOS() || isLinux() || isFuchsia();
  }

  static bool isAndroid() {
    return !isWeb() && Platform.isAndroid;
  }

  static bool isIOS() {
    return !isWeb() && Platform.isIOS;
  }

  static bool isWindows() {
    return !isWeb() && Platform.isWindows;
  }

  static bool isMacOS() {
    return !isWeb() && Platform.isMacOS;
  }

  static bool isLinux() {
    return !isWeb() && Platform.isLinux;
  }

  static bool isFuchsia() {
    return !isWeb() && Platform.isFuchsia;
  }
}
