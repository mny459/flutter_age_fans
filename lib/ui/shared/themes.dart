import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_age_fans/core/constant/ani_color.dart';
import 'package:flutter_age_fans/core/services/key_storage/key_storage_service.dart';
import 'package:flutter_age_fans/locator.dart';
import 'package:logging/logging.dart';

const primaryCupertinoTheme = CupertinoThemeData(
  primaryColor: CupertinoDynamicColor.withBrightness(
    color: Colors.purple,
    darkColor: Colors.cyan,
  ),
);

/// 主题管理
class ThemeProvider with ChangeNotifier {
  final _logger = Logger('ThemeProvider');
  final KeyStorageService _keyStorageService = locator<KeyStorageService>();
  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;

  bool get isDarkMode =>
      !_followSystemDarkModel && _themeMode == ThemeMode.dark;

  bool _followSystemDarkModel = false;

  bool get followSystemDarkModel => _followSystemDarkModel;

  /// 当前主题颜色
  MaterialColor _themeColor = Colors.primaries[5];

  /// 系统的
  var _systemThemeMode = SchedulerBinding.instance!.window.platformBrightness;

  ThemeProvider() {
    init();
  }

  void init() {
    _initThemeMode();
    _initThemeColor();
  }

  void _initThemeMode() {
    var mode = ThemeMode.values[_keyStorageService.themeMode];
    _followSystemDarkModel = mode == ThemeMode.system;
    if (mode == ThemeMode.system) {
      _themeMode = _systemThemeMode == Brightness.light
          ? ThemeMode.light
          : ThemeMode.dark;
    } else {
      _themeMode = mode;
    }
  }

  void _initThemeColor() {
    var themeColor = _keyStorageService.themeColor;
    MaterialColor primaryColor;
    if (themeColor == 0) {
      primaryColor = _themeColor;
    } else {
      primaryColor = Colors.primaries.firstWhere(
          (color) => color.value == themeColor,
          orElse: () => _themeColor);
    }
    _themeColor = primaryColor;
  }

  void setDarkTheme() {
    if (_followSystemDarkModel) return;
    _setTheme(ThemeMode.dark);
  }

  void setLightTheme() {
    if (_followSystemDarkModel) return;
    _setTheme(ThemeMode.light);
  }

  void setFollowSystemDarkModel(bool follow) {
    _followSystemDarkModel = follow;
    checkSystemThemeMode();
    notifyListeners();
  }

  void checkSystemThemeMode() {
    var curMode = SchedulerBinding.instance!.window.platformBrightness;
    if (_systemThemeMode != curMode) {
      _systemThemeMode = curMode;
      _initThemeMode();
      notifyListeners();
    }
  }

  void _setTheme(ThemeMode mode) {
    _themeMode = mode;
    _keyStorageService.themeMode = _themeMode.index;
    notifyListeners();
  }

  /// 根据主题 明暗 和 颜色 生成对应的主题
  /// [dark]系统的Dark Mode
  ThemeData themeData({bool platformDarkMode = false}) {
    var isDark = platformDarkMode;
    var brightness = isDark ? Brightness.dark : Brightness.light;
    final backgroundColor =
        isDark ? AniColor.backgroundColor : AniLightColor.backgroundColor;
    final surfaceColor =
        isDark ? AniColor.surfaceColor : AniLightColor.surfaceColor;
    final primaryColor = MaterialColor(
        isDark ? AniColor.colorFF5F00.value : AniLightColor.colorFF5F00.value,
        <int, Color>{
          50: isDark ? AniColor.colorFF5F00 : AniLightColor.colorFF5F00,
          100: isDark ? AniColor.colorFF5F00 : AniLightColor.colorFF5F00,
          200: isDark ? AniColor.colorFF5F00 : AniLightColor.colorFF5F00,
          300: isDark ? AniColor.colorFF5F00 : AniLightColor.colorFF5F00,
          400: isDark ? AniColor.colorFF5F00 : AniLightColor.colorFF5F00,
          500: isDark ? AniColor.colorFF5F00 : AniLightColor.colorFF5F00,
          600: isDark ? AniColor.colorFF5F00 : AniLightColor.colorFF5F00,
          700: isDark ? AniColor.colorFF5F00 : AniLightColor.colorFF5F00,
          800: isDark ? AniColor.colorFF5F00 : AniLightColor.colorFF5F00,
          900: isDark ? AniColor.colorFF5F00 : AniLightColor.colorFF5F00,
        });
    final secondaryColor =
        isDark ? AniColor.colorD0E0F0 : AniLightColor.colorD0E0F0;
    final onSurfaceColor =
        isDark ? AniColor.textFourthColor : AniLightColor.textFourthColor;

    var themeData = ThemeData(
      brightness: brightness,
      // 主题颜色属于亮色系还是属于暗色系(eg:dark时,AppBarTitle文字及状态栏文字的颜色为白色,反之为黑色)
      // 这里设置为dark目的是,不管App是明or暗,都将appBar的字体颜色的默认值设为白色.
      // 再AnnotatedRegion<SystemUiOverlayStyle>的方式,调整响应的状态栏颜色
      primaryColorBrightness: Brightness.dark,
      fontFamily: 'Open Sans',
      colorScheme: ColorScheme.fromSwatch(primarySwatch: primaryColor).copyWith(
        secondary: secondaryColor,
        surface: surfaceColor,
        background: backgroundColor,
        onSurface: onSurfaceColor,
        brightness: brightness,
      ),
      backgroundColor: backgroundColor,
      scaffoldBackgroundColor: backgroundColor,
      dividerTheme:
          const DividerThemeData(color: AniColor.colorDivider, thickness: 0),
    );

    themeData = themeData.copyWith(
      cupertinoOverrideTheme: CupertinoThemeData(
        primaryColor: primaryColor,
        brightness: brightness,
      ),
      appBarTheme: themeData.appBarTheme.copyWith(
        elevation: 0,
        backgroundColor: surfaceColor,
        centerTitle: true,
        iconTheme: IconThemeData(color: onSurfaceColor, size: 24),
        actionsIconTheme: IconThemeData(color: onSurfaceColor, size: 24),
      ),
      hintColor: themeData.hintColor.withAlpha(90),
      textTheme: themeData.textTheme.copyWith(

          /// 解决中文hint不居中的问题 https://github.com/flutter/flutter/issues/40248
          subtitle1: themeData.textTheme.subtitle1!.copyWith(
              color: themeData.colorScheme.onSurface,
              textBaseline: TextBaseline.alphabetic),
          subtitle2: themeData.textTheme.subtitle2!.copyWith(
              color: themeData.colorScheme.onSurface,
              textBaseline: TextBaseline.alphabetic)),
      inputDecorationTheme: inputDecorationTheme(themeData),
      bottomNavigationBarTheme: themeData.bottomNavigationBarTheme.copyWith(
        type: BottomNavigationBarType.fixed,
        backgroundColor: AniColor.colorBlack,
        selectedItemColor: primaryColor,
        unselectedItemColor: onSurfaceColor,
        selectedIconTheme: IconThemeData(color: primaryColor, size: 24),
        unselectedIconTheme: IconThemeData(color: onSurfaceColor, size: 24),
      ),
    );
    return themeData;
  }

  static InputDecorationTheme inputDecorationTheme(ThemeData theme) {
    var primaryColor = theme.primaryColor;
    var dividerColor = theme.dividerColor;
    var errorColor = theme.errorColor;
    var disabledColor = theme.disabledColor;

    var width = 0.5;

    return InputDecorationTheme(
      hintStyle: TextStyle(fontSize: 14),
      errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(width: width, color: errorColor)),
      focusedErrorBorder: UnderlineInputBorder(
          borderSide: BorderSide(width: 0.7, color: errorColor)),
      focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(width: width, color: primaryColor)),
      enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(width: width, color: dividerColor)),
      border: UnderlineInputBorder(
          borderSide: BorderSide(width: width, color: dividerColor)),
      disabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(width: width, color: disabledColor)),
    );
  }

  void changeThemeColor(MaterialColor themeColor) {
    _themeColor = themeColor;
    _logger.info('changeThemeColor ${_themeColor.value}');
    _keyStorageService.themeColor = _themeColor.value;
    notifyListeners();
  }
}
