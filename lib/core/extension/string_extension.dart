import 'package:flutter/widgets.dart';

extension StringExtension on String {
  /// https://github.com/flutter/flutter/issues/18761
  /// Flutter 的文本溢出效果以单词为准，会造成英文溢出效果不佳。
  /// 添加空白占位符，将单词分割成字符
  String get joinChar => Characters(this).toList().join('\u{200B}');
}
