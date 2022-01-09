import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_age_fans/core/constant/ani_color.dart';

/// Contains useful functions to reduce boilerplate code
class UIHelper {
  UIHelper._();

  static Widget verticalSpace(double height) {
    return Container(height: height);
  }

  static Widget horizontalSpace(double width) {
    return Container(
      width: width,
    );
  }

  static SliverToBoxAdapter sliverHorizontalSpace(double width) {
    return SliverToBoxAdapter(child: horizontalSpace(width));
  }

  static SliverToBoxAdapter sliverVerticalSpace(double height) {
    return SliverToBoxAdapter(child: verticalSpace(height));
  }

  static Widget horizontalDivider({double? indent, double? endIndent}) {
    return Divider(
      height: 1,
      indent: indent,
      endIndent: endIndent,
    );
  }

  static SliverToBoxAdapter sliverHorizontalDivider(
      {double? indent, double? endIndent}) {
    return SliverToBoxAdapter(
      child: Divider(
        height: 1,
        indent: indent,
        endIndent: endIndent,
      ),
    );
  }

  static Widget verticalDivider({double? indent, double? endIndent}) {
    return VerticalDivider(
      width: 1,
      indent: indent,
      endIndent: endIndent,
    );
  }

  static SliverToBoxAdapter sliverVerticalDivider(
      {double? indent, double? endIndent}) {
    return SliverToBoxAdapter(
      child: VerticalDivider(
        width: 1,
        indent: indent,
        endIndent: endIndent,
      ),
    );
  }

  static final screenWidth =
      window.physicalSize.width / window.devicePixelRatio;
  static final screenHeight =
      window.physicalSize.height / window.devicePixelRatio;
}
