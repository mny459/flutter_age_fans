import 'package:logging/logging.dart';
import 'package:flutter_age_fans/core/services/key_storage/key_storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Service that is responsible for storing/retrieving data in/from
/// local storage using the [SharedPreferences] package.
class KeyStorageServiceImpl implements KeyStorageService {
  final _log = Logger('KeyStorageServiceImpl');

  static const kUser = 'user_key';
  static const kThemeColor = 'theme_color';
  static const kThemeMode = 'theme_mode';

  static KeyStorageServiceImpl? _instance;
  static SharedPreferences? _preferences;

  static Future<KeyStorageServiceImpl?> getInstance() async {
    _preferences ??= await SharedPreferences.getInstance();
    _instance ??= KeyStorageServiceImpl();
    return _instance;
  }

  @override
  String get userInfo => _getFromDisk(kUser) ?? '';

  @override
  set userInfo(String? user) => _saveToDisk(kUser, user);

  @override
  int get themeMode => _getFromDisk(kThemeMode) ?? 0;

  @override
  set themeMode(int themeMode) => _saveToDisk(kThemeMode, themeMode);

  @override
  int get themeColor => _getFromDisk(kThemeColor) ?? 0;

  @override
  set themeColor(int color) => _saveToDisk(kThemeColor, color);

  dynamic _getFromDisk(String key) {
    final value =  _preferences!.get(key);

    _log.finest('(Fetching) key: $key value: $value');

    return value;
  }

  void _saveToDisk<T>(String key, T content) {
    _log.finest('(Saving) key: $key value: $content');

    if (content is String) {
      _preferences?.setString(key, content);
    }
    if (content is bool) {
      _preferences?.setBool(key, content);
    }
    if (content is int) {
      _preferences?.setInt(key, content);
    }
    if (content is double) {
      _preferences?.setDouble(key, content);
    }
    if (content is List<String>) {
      _preferences?.setStringList(key, content);
    }
  }
}
