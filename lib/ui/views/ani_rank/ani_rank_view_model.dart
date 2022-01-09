import 'dart:convert';

import 'package:flutter_age_fans/core/models/ani_rank/ani_rank_bean.dart';
import 'package:flutter_age_fans/core/repositories/age_fans_repository/age_fans_repository.dart';
import 'package:flutter_age_fans/core/services/cache/cache_service.dart';
import 'package:flutter_age_fans/locator.dart';
import 'package:flutter_age_fans/ui/views/list_view_model.dart';

class AniRankViewModel extends ListViewModel {
  final CacheService _cacheService = locator<CacheService>();
  final AgeFansRepository _repository = locator<AgeFansRepository>();
  var _rankCount = 0;
  final _rankList = <AniRankPreBean>[];
  final _years = <String>[];
  var _yearIndex = 0;

  List<AniRankPreBean> get rankList => _rankList;

  List<String> get years => _years;

  int get rankCount => _rankCount;

  int get yearIndex => _yearIndex;

  String get year => _years[yearIndex];

  @override
  int get firstPage => 1;

  @override
  void init() {
    if (_years.isEmpty) {
      _years.add('全部');
      for (var i = DateTime.now().year; i >= 2000; i--) {
        _years.add('$i');
      }
    }
    _cacheService.getRankInfo().then((value) {
      if (value.isNotEmpty) {
        final data = AniRankBean.fromJson(jsonDecode(value));
        _onDataLoad(data, true);
      }
    }).whenComplete(() {
      refresh();
    });
  }

  @override
  void loadData(int page, bool isRefresh) {
    final value = yearIndex == 0 ? '' : _years[yearIndex];
    _repository.fetchRankList(page, value: value).then((value) {
      if (yearIndex == 0) {
        _cacheService.putRankInfo(jsonEncode(value.toJson()));
      }
      _onDataLoad(value, isRefresh);
    }).catchError((error) {
      loadDataCompleted(isRefresh: isRefresh, success: false);
    });
  }

  void _onDataLoad(AniRankBean data, bool isRefresh) {
    _rankCount = data.aniRankPre.length;
    if (isRefresh) {
      _rankList.clear();
    }
    _rankList.addAll(data.aniRankPre);
    loadDataCompleted(
        isRefresh: isRefresh, hasMoreData: _rankList.length < _rankCount);
  }

  void changeYear(int index) {
    _yearIndex = index;
    refresh();
  }
}
