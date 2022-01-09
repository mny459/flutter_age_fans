import 'dart:convert';

import 'package:flutter_age_fans/core/models/ani_pre/ani_pre_bean.dart';
import 'package:flutter_age_fans/core/models/recommend/recommend_bean.dart';
import 'package:flutter_age_fans/core/repositories/age_fans_repository/age_fans_repository.dart';
import 'package:flutter_age_fans/core/services/cache/cache_service.dart';
import 'package:flutter_age_fans/locator.dart';
import 'package:flutter_age_fans/ui/views/list_view_model.dart';

class AniUpdateViewModel extends ListViewModel {
  final CacheService _cacheService = locator<CacheService>();
  final AgeFansRepository _repository = locator<AgeFansRepository>();
  var _updateCount = 0;
  final _updateList = <AniPreBean>[];

  List<AniPreBean> get updateList => _updateList;

  int get updateCount => _updateCount;

  @override
  int get firstPage => 1;

  @override
  void init() {
    _cacheService.getUpdateInfo().then((value) {
      if (value.isNotEmpty) {
        final data = RecommendBean.fromJson(jsonDecode(value));
        _onDataLoad(data, true);
      }
    }).whenComplete(() {
      refresh();
    });
  }

  @override
  void loadData(int page, bool isRefresh) {
    _repository.fetchUpdateList(page).then((value) {
      _onDataLoad(value, isRefresh);
    }).catchError((error) {
      loadDataCompleted(isRefresh: isRefresh, success: false);
    });
  }

  void _onDataLoad(RecommendBean data, bool isRefresh) {
    _updateCount = data.allCnt;
    if (isRefresh) {
      _cacheService.putUpdateInfo(jsonEncode(data.toJson()));
      _updateList.clear();
    }
    _updateList.addAll(data.aniPre);
    loadDataCompleted(
        isRefresh: isRefresh, hasMoreData: _updateList.length < _updateCount);
  }
}
