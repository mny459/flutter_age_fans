import 'package:flutter_age_fans/core/models/ani_catalog/ani_catalog_bean.dart';
import 'package:flutter_age_fans/core/repositories/age_fans_repository/age_fans_repository.dart';
import 'package:flutter_age_fans/locator.dart';
import 'package:flutter_age_fans/ui/views/list_view_model.dart';

class SearchViewModel extends ListViewModel {
  final AgeFansRepository _repository = locator<AgeFansRepository>();
  var _allCount = 0;
  final _aniList = <AniPreLBean>[];

  List<AniPreLBean> get aniList => _aniList;
  String _keyWord = '';

  String get keyWord => _keyWord;

  int get allCount => _allCount;

  @override
  void init() {}

  void search({String? word}) {
    if (word != null && word.isNotEmpty) {
      _keyWord = word;
    }
    if (_keyWord.isEmpty) {
      return;
    }
    setBusy(true);
    refresh();
  }

  void clearSearch() {
    _keyWord = '';
    _aniList.clear();
    notifyListenersNextFrame();
  }

  void onTextChanged(String text) {
    if (text.isEmpty) {
      clearSearch();
    }
  }

  @override
  void loadData(int page, bool isRefresh) {
    _repository.search(_keyWord, page).then((value) {
      _allCount = value.seaCnt;
      if (isRefresh) {
        _aniList.clear();
      }
      _aniList.addAll(value.aniPreL);
      setBusy(false);
      loadDataCompleted(
          isRefresh: isRefresh, hasMoreData: _aniList.length < _allCount);
    });
  }
}
