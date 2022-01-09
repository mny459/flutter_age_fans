import 'dart:convert';

import 'package:flutter_age_fans/core/models/main/main_bean.dart';
import 'package:flutter_age_fans/core/repositories/age_fans_repository/age_fans_repository.dart';
import 'package:flutter_age_fans/core/services/cache/cache_service.dart';
import 'package:flutter_age_fans/locator.dart';
import 'package:logging/logging.dart';
import 'package:stacked/stacked.dart';

class MainViewModel extends BaseViewModel {
  final CacheService _cacheService = locator<CacheService>();
  final AgeFansRepository _repository = locator<AgeFansRepository>();
  final _log = Logger('MainViewModel');
  final _navList = <NavBean>[
    NavBean('首页', 'https://vip.cqkeb.com/icon/index.png',
        'https://web.age-spa.com:8443/#/'),
    NavBean('目录', 'https://vip.cqkeb.com/icon/catalog.png',
        'https://web.age-spa.com:8443/#/catalog'),
    NavBean('推荐', 'https://vip.cqkeb.com/icon/recommend.png',
        'https://web.age-spa.com:8443/#/recommend'),
    NavBean('更新', 'https://vip.cqkeb.com/icon/update.png',
        'https://web.age-spa.com:8443/#/update'),
    NavBean('排行榜', 'https://vip.cqkeb.com/icon/rank.png',
        'https://web.age-spa.com:8443/#/rank'),
  ];

  int _index = 0;

  int get index => _index;

  List<NavBean> get navList => _navList;

  void changeTab(int index) {
    _index = index;
    notifyListeners();
  }

  void init() {
    _cacheService.getMainInfo().then((value) {
      if (value.isNotEmpty) {
        final mainBean = MainBean.fromJson(jsonDecode(value));
        _navList.clear();
        _navList.addAll(mainBean.nav);
        notifyListeners();
      }
    }).whenComplete(() {
      _repository.fetchMainInfo().then((value) {
        _cacheService.putMainInfo(jsonEncode(value.toJson()));
        _navList.clear();
        _navList.addAll(value.nav);
        notifyListeners();
      });
    });
  }
}
