import 'dart:convert';

import 'package:flutter_age_fans/core/models/ani_catalog/ani_catalog_bean.dart';
import 'package:flutter_age_fans/core/repositories/age_fans_repository/age_fans_repository.dart';
import 'package:flutter_age_fans/core/services/cache/cache_service.dart';
import 'package:flutter_age_fans/locator.dart';
import 'package:flutter_age_fans/ui/views/list_view_model.dart';

class AniCatalogViewModel extends ListViewModel {
  final CacheService _cacheService = locator<CacheService>();
  final AgeFansRepository _repository = locator<AgeFansRepository>();
  var _allCount = 0;
  final _aniList = <AniPreLBean>[];

  List<AniPreLBean> get aniList => _aniList;

  int get allCount => _allCount;

  @override
  int get firstPage => 1;

  late AniCatalogBean _catalog;

  List<String> getOptions(String label) {
    return options[label]!;
  }

  int getOptionIndex(String label) {
    return optionSelectedIndex[label] ?? 0;
  }

  String labelsRegion = 'Labels_region';
  String labelsGenre = 'Labels_genre';
  String labelsLetter = 'Labels_letter';
  String labelsYear = 'Labels_year';
  String labelsSeason = 'Labels_season';

  String labelsStatus = 'Labels_status';
  String labelsLabel = 'Labels_label';
  String labelsResource = 'Labels_resource';
  String labelsOrder = 'Labels_order';
  bool _firstRequestNet = true;

  @override
  void init() {
    _cacheService.getCatalogInfo().then((value) {
      if (value.isNotEmpty) {
        _catalog = AniCatalogBean.fromJson(jsonDecode(value));
        onDataLoad(true);
      }
    }).whenComplete(() {
      refresh();
    });
  }

  //
  @override
  void loadData(int page, bool isRefresh) {
    final regionIndex = optionSelectedIndex[labelsRegion] ?? 0;
    final region =
        regionIndex == 0 ? "all" : options[labelsRegion]![regionIndex];
    final seasonIndex = optionSelectedIndex[labelsSeason] ?? 0;
    final season =
        seasonIndex == 0 ? "all" : options[labelsSeason]![seasonIndex];
    final statusIndex = optionSelectedIndex[labelsStatus] ?? 0;
    final status =
        statusIndex == 0 ? "all" : options[labelsStatus]![statusIndex];
    final labelIndex = optionSelectedIndex[labelsLabel] ?? 0;
    final label = labelIndex == 0 ? "all" : options[labelsLabel]![labelIndex];
    final resourceIndex = optionSelectedIndex[labelsResource] ?? 0;
    final resource =
        resourceIndex == 0 ? "all" : options[labelsResource]![resourceIndex];
    final orderIndex = optionSelectedIndex[labelsOrder] ?? 0;
    final order = orderIndex == 0 ? "更新时间" : options[labelsOrder]![orderIndex];
    final yearIndex = optionSelectedIndex[labelsYear] ?? 0;
    final year = yearIndex == 0 ? "all" : options[labelsYear]![yearIndex];
    final letterIndex = optionSelectedIndex[labelsLetter] ?? 0;
    final letter =
        letterIndex == 0 ? "all" : options[labelsLetter]![letterIndex];
    final genreIndex = optionSelectedIndex[labelsGenre] ?? 0;
    final genre = genreIndex == 0 ? "all" : options[labelsGenre]![genreIndex];

    _repository
        .fetchCatalogList(page, genre, label, letter, order, region, resource,
            season, status, year)
        .then(
      (value) {
        _catalog = value;
        if (_firstRequestNet) {
          _firstRequestNet = false;
          _cacheService.putCatalogInfo(jsonEncode(_catalog.toJson()));
        }
        onDataLoad(isRefresh);
      },
      onError: (error) {
        if (options.isEmpty) {
          setError(error);
        }
      },
    );
  }

  void onDataLoad(bool isRefresh) {
    _allCount = _catalog.allCnt;
    _initOptions();
    if (isRefresh) {
      _aniList.clear();
    }
    _aniList.addAll(_catalog.aniPreL);
    loadDataCompleted(
        isRefresh: isRefresh, hasMoreData: _aniList.length < _allCount);
  }

  final options = <String, List<String>>{};
  final optionSelectedIndex = <String, int>{};

  void _initOptions() {
    if (options.isNotEmpty) return;

    final region = _catalog.labelsRegion.toList();
    region.removeRange(0, 2);
    options[labelsRegion] = region;
    optionSelectedIndex[labelsRegion] = 0;

    final genre = _catalog.labelsGenre.toList();
    genre.removeRange(0, 2);
    options[labelsGenre] = genre;
    optionSelectedIndex[labelsGenre] = 0;

    final label = _catalog.labelsLabel.toList();
    label.removeRange(0, 2);
    options[labelsLabel] = label;
    optionSelectedIndex[labelsLabel] = 0;

    final letter = _catalog.labelsLetter.toList();
    letter.removeRange(0, 2);
    options[labelsLetter] = letter;
    optionSelectedIndex[labelsLetter] = 0;

    final order = _catalog.labelsOrder.toList();
    order.removeRange(0, 2);
    options[labelsOrder] = order;
    optionSelectedIndex[labelsOrder] = 0;

    final resource = _catalog.labelsResource.toList();
    resource.removeRange(0, 2);
    options[labelsResource] = resource;
    optionSelectedIndex[labelsResource] = 0;

    final season = _catalog.labelsSeason.toList();
    season.removeRange(0, 2);
    options[labelsSeason] = season;
    optionSelectedIndex[labelsSeason] = 0;

    final status = _catalog.labelsStatus.toList();
    status.removeRange(0, 2);
    options[labelsStatus] = status;
    optionSelectedIndex[labelsStatus] = 0;

    final year = _catalog.labelsYear.toList();
    year.removeRange(0, 2);
    options[labelsYear] = year;
    optionSelectedIndex[labelsYear] = 0;
  }

  void changeSearchOption(String labelsRegion, int index) {
    if (optionSelectedIndex[labelsRegion] == index) return;
    optionSelectedIndex[labelsRegion] = index;
    notifyListeners();
    refresh();
  }
}
