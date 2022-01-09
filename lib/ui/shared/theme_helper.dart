import 'package:flutter/material.dart';
import 'package:flutter_age_fans/core/services/navigation/navigation_helper.dart';

class ThemeHelper {
  ThemeHelper._();
  static Color backgroundColor() {
    return Theme.of(NavigationHelper.context).colorScheme.background;
  }

  static Color surfaceColor() {
    return Theme.of(NavigationHelper.context).colorScheme.surface;
  }

  static Color onSurfaceColor() {
    return Theme.of(NavigationHelper.context).colorScheme.onSurface;
  }

}
