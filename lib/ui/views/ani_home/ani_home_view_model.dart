import 'dart:convert';

import 'package:flutter_age_fans/core/models/ani_home/ani_home_all_info_bean.dart';
import 'package:flutter_age_fans/core/models/ani_home/ani_home_bean.dart';
import 'package:flutter_age_fans/core/models/ani_pre/ani_bean.dart';
import 'package:flutter_age_fans/core/repositories/age_fans_repository/age_fans_repository.dart';
import 'package:flutter_age_fans/core/services/cache/cache_service.dart';
import 'package:flutter_age_fans/locator.dart';
import 'package:flutter_age_fans/ui/views/list_view_model.dart';

class AniHomeViewModel extends ListViewModel {
  final CacheService _cacheService = locator<CacheService>();
  final AgeFansRepository _repository = locator<AgeFansRepository>();
  AniHomeBean? _homeInfo;

  AniHomeBean? get homeInfo => _homeInfo;

  Map<String, List<XinFansInfoBean>> get xinFansInfoMap => _xinFansInfoMap;
  final _xinFansInfoMap = <String, List<XinFansInfoBean>>{
    '周一': <XinFansInfoBean>[],
    '周二': <XinFansInfoBean>[],
    '周三': <XinFansInfoBean>[],
    '周四': <XinFansInfoBean>[],
    '周五': <XinFansInfoBean>[],
    '周六': <XinFansInfoBean>[],
    '周日': <XinFansInfoBean>[],
  };

  final List<AniBean> _banners = [];

  List<AniBean> get banners => _banners;

  @override
  void init() {
    _cacheService.getHomeInfo().then((value) {
      if (value.isNotEmpty) {
        final homeAllInfo = AniHomeAllInfoBean.fromJson(jsonDecode(value));
        onDataLoad(homeAllInfo);
      }
    }).whenComplete(() {
      refresh();
    });
  }

  @override
  void loadData(int page, bool isRefresh) {
    _repository.fetchHomeInfo().then((value) {
      _cacheService.putHomeInfo(jsonEncode(value.toJson()));
      onDataLoad(value);
    }).catchError((error) {
      if (_homeInfo == null) {
        setError(error);
      }
    });
  }

  void onDataLoad(AniHomeAllInfoBean allInfo) {
    _homeInfo = allInfo.homeBean;
    _banners.clear();
    _banners.addAll(allInfo.banners);
    if (_homeInfo != null) {
      for (var list in _xinFansInfoMap.values) {
        list.clear();
      }
      for (var item in _homeInfo!.xinfansInfo) {
        final index = item.wd == 0 ? 6 : item.wd - 1;
        final key = _xinFansInfoMap.keys.toList()[index];
        _xinFansInfoMap[key]?.add(item);
      }
    }
    loadDataCompleted(isRefresh: true, success: true);
  }
}
