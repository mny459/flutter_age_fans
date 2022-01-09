import 'dart:async';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:path_provider/path_provider.dart';

class CookieUtil {
  // 获取cookie地址
  static Future<String> getCookiePath() async {
    var tempDir = await getTemporaryDirectory();
    var tempPath = tempDir.path;
    return '$tempPath/cookies';
  }

  //清除所有cookie
  static Future<void> deleteAllCookies() async {
    await getCookiePath().then((path) {
      var cookieJar = PersistCookieJar(storage: FileStorage(path));
      cookieJar.deleteAll();
    });
  }
}
