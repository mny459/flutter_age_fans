import 'dart:convert';

import 'package:flutter_age_fans/core/models/ani_pre/ani_pre_bean.dart';
import 'package:flutter_age_fans/core/models/recommend/recommend_bean.dart';
import 'package:flutter_age_fans/core/repositories/age_fans_repository/age_fans_repository.dart';
import 'package:flutter_age_fans/core/services/cache/cache_service.dart';
import 'package:flutter_age_fans/locator.dart';
import 'package:flutter_age_fans/ui/views/list_view_model.dart';

class RecommendViewModel extends ListViewModel {
  final CacheService _cacheService = locator<CacheService>();
  final AgeFansRepository _repository = locator<AgeFansRepository>();
  var _recommendCount = 0;
  final _recommendList = <AniPreBean>[];

  List<AniPreBean> get recommendList => _recommendList;

  int get recommendCount => _recommendCount;

  @override
  int get firstPage => 1;

  @override
  void init() {
    _cacheService.getRecommendInfo().then((value) {
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
    _repository.fetchRecommendList(page).then((value) {
      _onDataLoad(value, isRefresh);
    }).catchError((error) {
      loadDataCompleted(isRefresh: isRefresh, success: false);
    });
  }

  void _onDataLoad(RecommendBean data, bool isRefresh) {
    _recommendCount = data.allCnt;
    if (isRefresh) {
      _cacheService.putRecommendInfo(jsonEncode(data.toJson()));
      _recommendList.clear();
    }
    _recommendList.addAll(data.aniPre);
    loadDataCompleted(
        isRefresh: isRefresh,
        hasMoreData: _recommendList.length < _recommendCount);
  }
}
