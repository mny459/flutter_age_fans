import 'dart:collection';

import 'dart:ui';

class FpsMonitorUtils {
  /// 初始化帧率和
  static var maxFrames = 60;
  static var lastFrames = ListQueue<FrameTiming>(maxFrames);

  static void init() {
    maxFrames = 60;
    lastFrames = ListQueue<FrameTiming>(maxFrames);
  }

  static void onReportTimings(List<FrameTiming> timings) {
    // for (var timing in timings) {
    //   lastFrames.addFirst(timing);
    // }
    //
    // while (lastFrames.length >= maxFrames) {
    //   lastFrames.removeLast();
    // }
    // var curFps = fps;
    // if (curFps < 30) {
    //   print('fps : $curFps');
    // }
  }

  static const frameInterval =
      Duration(microseconds: Duration.microsecondsPerSecond ~/ 60);

  /// 帧率的计算
  static double get fps {
    var lastFramesSet = <FrameTiming>[];
    for (var timing in lastFrames) {
      if (lastFramesSet.isEmpty) {
        lastFramesSet.add(timing);
      } else {
        var lastStart =
            lastFramesSet.last.timestampInMicroseconds(FramePhase.buildStart);
        if (lastStart -
                timing.timestampInMicroseconds(FramePhase.rasterFinish) >
            (frameInterval.inMicroseconds * 2)) {
          // in different set
          break;
        }
        lastFramesSet.add(timing);
      }
    }
    // 帧数
    var frameCount = lastFramesSet.length;

    var costCount = lastFramesSet.map((t) {
      return (t.totalSpan.inMicroseconds ~/ frameInterval.inMicroseconds) + 1;
    }).fold(0, (dynamic a, b) => a + b);
    return frameCount * 60 / costCount;
  }
}
