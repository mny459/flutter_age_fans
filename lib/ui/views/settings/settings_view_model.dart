import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:stacked/stacked.dart';

class SettingsViewModel extends BaseViewModel {
  String _cacheSize = '0.00B';

  String get cacheSize => _cacheSize;

  void init() async {
    final size = await loadApplicationCache();
    _cacheSize = formatSize(size);
    notifyListeners();
  }

  /// 获取缓存
  Future<double> loadApplicationCache() async {
    /// 获取文件夹
    var directory = await getApplicationDocumentsDirectory();

    /// 获取缓存大小
    var value = await getTotalSizeOfFilesInDir(directory);
    return value;
  }

  /// 循环计算文件的大小（递归）
  Future<double> getTotalSizeOfFilesInDir(final FileSystemEntity file) async {
    if (file is File) {
      var length = await file.length();
      return double.parse(length.toString());
    }
    if (file is Directory) {
      final children = file.listSync();
      var total = 0.0;
      for (final child in children) {
        total += await getTotalSizeOfFilesInDir(child);
      }
      return total;
    }
    return 0;
  }

  /// 缓存大小格式转换
  String formatSize(double value) {
    var unitArr = <String>['B', 'K', 'M', 'G'];
    var index = 0;
    while (value > 1024) {
      index++;
      value = value / 1024;
    }
    var size = value.toStringAsFixed(2);
    return size + unitArr[index];
  }

  void clearCache() {
  }
}
