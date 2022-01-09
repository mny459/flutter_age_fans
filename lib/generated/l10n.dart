// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `AGE动漫`
  String get appName {
    return Intl.message(
      'AGE动漫',
      name: 'appName',
      desc: '',
      args: [],
    );
  }

  /// `首页`
  String get titleHome {
    return Intl.message(
      '首页',
      name: 'titleHome',
      desc: '',
      args: [],
    );
  }

  /// `推荐`
  String get titleRecommend {
    return Intl.message(
      '推荐',
      name: 'titleRecommend',
      desc: '',
      args: [],
    );
  }

  /// `更新`
  String get titleUpdate {
    return Intl.message(
      '更新',
      name: 'titleUpdate',
      desc: '',
      args: [],
    );
  }

  /// `目录`
  String get titleCatalog {
    return Intl.message(
      '目录',
      name: 'titleCatalog',
      desc: '',
      args: [],
    );
  }

  /// `排行榜`
  String get titleRank {
    return Intl.message(
      '排行榜',
      name: 'titleRank',
      desc: '',
      args: [],
    );
  }

  /// `推荐列表`
  String get recommendList {
    return Intl.message(
      '推荐列表',
      name: 'recommendList',
      desc: '',
      args: [],
    );
  }

  /// `每周放送列表`
  String get weeklyUpdate {
    return Intl.message(
      '每周放送列表',
      name: 'weeklyUpdate',
      desc: '',
      args: [],
    );
  }

  /// `每日推荐`
  String get dailyRecommend {
    return Intl.message(
      '每日推荐',
      name: 'dailyRecommend',
      desc: '',
      args: [],
    );
  }

  /// `地区`
  String get region {
    return Intl.message(
      '地区',
      name: 'region',
      desc: '',
      args: [],
    );
  }

  /// `版本`
  String get genre {
    return Intl.message(
      '版本',
      name: 'genre',
      desc: '',
      args: [],
    );
  }

  /// `首字母`
  String get letter {
    return Intl.message(
      '首字母',
      name: 'letter',
      desc: '',
      args: [],
    );
  }

  /// `年份`
  String get year {
    return Intl.message(
      '年份',
      name: 'year',
      desc: '',
      args: [],
    );
  }

  /// `季度`
  String get season {
    return Intl.message(
      '季度',
      name: 'season',
      desc: '',
      args: [],
    );
  }

  /// `状态`
  String get status {
    return Intl.message(
      '状态',
      name: 'status',
      desc: '',
      args: [],
    );
  }

  /// `类型`
  String get type {
    return Intl.message(
      '类型',
      name: 'type',
      desc: '',
      args: [],
    );
  }

  /// `资源`
  String get resources {
    return Intl.message(
      '资源',
      name: 'resources',
      desc: '',
      args: [],
    );
  }

  /// `排序`
  String get order {
    return Intl.message(
      '排序',
      name: 'order',
      desc: '',
      args: [],
    );
  }

  /// `最近更新`
  String get recentUpdate {
    return Intl.message(
      '最近更新',
      name: 'recentUpdate',
      desc: '',
      args: [],
    );
  }

  /// `动漫列表`
  String get aniList {
    return Intl.message(
      '动漫列表',
      name: 'aniList',
      desc: '',
      args: [],
    );
  }

  /// `动漫排行榜`
  String get aniRankList {
    return Intl.message(
      '动漫排行榜',
      name: 'aniRankList',
      desc: '',
      args: [],
    );
  }

  /// `首播年份`
  String get publicShowYear {
    return Intl.message(
      '首播年份',
      name: 'publicShowYear',
      desc: '',
      args: [],
    );
  }

  /// `点击选择年份进行筛选`
  String get hintSelectPublicShowYear {
    return Intl.message(
      '点击选择年份进行筛选',
      name: 'hintSelectPublicShowYear',
      desc: '',
      args: [],
    );
  }

  /// `共`
  String get total {
    return Intl.message(
      '共',
      name: 'total',
      desc: '',
      args: [],
    );
  }

  /// `前`
  String get first {
    return Intl.message(
      '前',
      name: 'first',
      desc: '',
      args: [],
    );
  }

  /// `部`
  String get section {
    return Intl.message(
      '部',
      name: 'section',
      desc: '',
      args: [],
    );
  }

  /// `详情`
  String get detail {
    return Intl.message(
      '详情',
      name: 'detail',
      desc: '',
      args: [],
    );
  }

  /// `原版名称`
  String get originName {
    return Intl.message(
      '原版名称',
      name: 'originName',
      desc: '',
      args: [],
    );
  }

  /// `首播时间`
  String get premiereTime {
    return Intl.message(
      '首播时间',
      name: 'premiereTime',
      desc: '',
      args: [],
    );
  }

  /// `剧情类型`
  String get plotType {
    return Intl.message(
      '剧情类型',
      name: 'plotType',
      desc: '',
      args: [],
    );
  }

  /// `简介`
  String get intro {
    return Intl.message(
      '简介',
      name: 'intro',
      desc: '',
      args: [],
    );
  }

  /// `播放列表`
  String get playList {
    return Intl.message(
      '播放列表',
      name: 'playList',
      desc: '',
      args: [],
    );
  }

  /// `相关动画`
  String get relativeAni {
    return Intl.message(
      '相关动画',
      name: 'relativeAni',
      desc: '',
      args: [],
    );
  }

  /// `猜你喜欢`
  String get guessYouLike {
    return Intl.message(
      '猜你喜欢',
      name: 'guessYouLike',
      desc: '',
      args: [],
    );
  }

  /// `登录`
  String get login {
    return Intl.message(
      '登录',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `注册`
  String get register {
    return Intl.message(
      '注册',
      name: 'register',
      desc: '',
      args: [],
    );
  }

  /// `用户名`
  String get username {
    return Intl.message(
      '用户名',
      name: 'username',
      desc: '',
      args: [],
    );
  }

  /// `16个字符内的字母、数字或符号`
  String get hintUsername {
    return Intl.message(
      '16个字符内的字母、数字或符号',
      name: 'hintUsername',
      desc: '',
      args: [],
    );
  }

  /// `密码`
  String get password {
    return Intl.message(
      '密码',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `8-32位字母、数字或符号`
  String get hintPassword {
    return Intl.message(
      '8-32位字母、数字或符号',
      name: 'hintPassword',
      desc: '',
      args: [],
    );
  }

  /// `请再次输入密码`
  String get hintPasswordMore {
    return Intl.message(
      '请再次输入密码',
      name: 'hintPasswordMore',
      desc: '',
      args: [],
    );
  }

  /// `立即登录`
  String get loginNow {
    return Intl.message(
      '立即登录',
      name: 'loginNow',
      desc: '',
      args: [],
    );
  }

  /// `立即注册`
  String get registerNow {
    return Intl.message(
      '立即注册',
      name: 'registerNow',
      desc: '',
      args: [],
    );
  }

  /// `两次输入密码不一致`
  String get hintPasswordDifferent {
    return Intl.message(
      '两次输入密码不一致',
      name: 'hintPasswordDifferent',
      desc: '',
      args: [],
    );
  }

  /// `用户名不能为空`
  String get hintUsernameEmptyError {
    return Intl.message(
      '用户名不能为空',
      name: 'hintUsernameEmptyError',
      desc: '',
      args: [],
    );
  }

  /// `用户名不能为空`
  String get hintPasswordEmptyError {
    return Intl.message(
      '用户名不能为空',
      name: 'hintPasswordEmptyError',
      desc: '',
      args: [],
    );
  }

  /// `密码校验`
  String get passwordVerify {
    return Intl.message(
      '密码校验',
      name: 'passwordVerify',
      desc: '',
      args: [],
    );
  }

  /// `退出登录`
  String get quitLogin {
    return Intl.message(
      '退出登录',
      name: 'quitLogin',
      desc: '',
      args: [],
    );
  }

  /// `历史记录`
  String get historyRecord {
    return Intl.message(
      '历史记录',
      name: 'historyRecord',
      desc: '',
      args: [],
    );
  }

  /// `我的评论`
  String get mineComment {
    return Intl.message(
      '我的评论',
      name: 'mineComment',
      desc: '',
      args: [],
    );
  }

  /// `我的收藏`
  String get mineCollect {
    return Intl.message(
      '我的收藏',
      name: 'mineCollect',
      desc: '',
      args: [],
    );
  }

  /// `修改密码`
  String get changePassword {
    return Intl.message(
      '修改密码',
      name: 'changePassword',
      desc: '',
      args: [],
    );
  }

  /// `请输入搜索关键词`
  String get hintSearch {
    return Intl.message(
      '请输入搜索关键词',
      name: 'hintSearch',
      desc: '',
      args: [],
    );
  }

  /// `「{keyWord}」搜索结果`
  String searchResult(Object keyWord) {
    return Intl.message(
      '「$keyWord」搜索结果',
      name: 'searchResult',
      desc: '',
      args: [keyWord],
    );
  }

  /// `确定`
  String get confirm {
    return Intl.message(
      '确定',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }

  /// `取消`
  String get cancel {
    return Intl.message(
      '取消',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `网盘资源`
  String get panRes {
    return Intl.message(
      '网盘资源',
      name: 'panRes',
      desc: '',
      args: [],
    );
  }

  /// `提取码: {code}`
  String panCode(Object code) {
    return Intl.message(
      '提取码: $code',
      name: 'panCode',
      desc: '',
      args: [code],
    );
  }

  /// `无效的播放地址`
  String get invalidPlayUrl {
    return Intl.message(
      '无效的播放地址',
      name: 'invalidPlayUrl',
      desc: '',
      args: [],
    );
  }

  /// `提取码已复制到剪贴板!`
  String get hintCopyPanCode {
    return Intl.message(
      '提取码已复制到剪贴板!',
      name: 'hintCopyPanCode',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
