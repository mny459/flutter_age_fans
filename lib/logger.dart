
import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:logger/logger.dart' as fancy;

/// 设置日志
/// 这里用了两个库
/// 1. logging: 控制是否输出 log，一般用 fine 表示 debug，severe 表示 error
/// 2. logger: 真正输出的控制台的对象，支持 String、List、Map、Set
void setupLogger() {
  Logger.root.level = kReleaseMode ? Level.OFF : Level.ALL;
  // 所有 Logger.root.level 以及以上的信息会被传递到 onRecord
  Logger.root.onRecord.listen((LogRecord record) {
    // loggerName Log 名字，相当于 Tag
    var m =
        '${record.loggerName} ${record.level.name}: ${record.time}: ${record.message}';
    var log = _getLogger();

    if (record.level == Level.SEVERE) {
      // SEVERE 严重错误 What a terrible failure log
      log.wtf(m);
    } else if (record.level == Level.SHOUT) {
      // SHOUT Debug
      log.e(m);
    } else if (record.level == Level.WARNING) {
      log.w(m);
    } else if (record.level == Level.INFO) {
      log.i(m);
    } else if (record.level == Level.CONFIG) {
      log.d(m);
    } else if (record.level == Level.FINE) {
      log.d(m);
    } else if (record.level == Level.FINER) {
      log.v(m);
    } else if (record.level == Level.FINEST) {
      log.v(m);
    }
  });
}

// [filter] 可选，使用默认的过滤器
// [printer] 梅花 [fancy.PrettyPrinter]
// [output]
// [level]
fancy.Logger _getLogger() {
  return fancy.Logger(
    printer: fancy.PrettyPrinter(methodCount: 0, printTime: false),
    // level: // 等级，默认 v
    // filter: // 自定义日志是否输出的过滤器
    // output: // 日志输出位置，可以指定文件，也可以指定控制台，默认控制台
  );
}