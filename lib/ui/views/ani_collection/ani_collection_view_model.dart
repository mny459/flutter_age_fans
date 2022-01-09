
import 'package:flutter_age_fans/core/models/ani_collect/ani_collect_bean.dart';
import 'package:flutter_age_fans/core/models/ani_pre/ani_pre_bean.dart';
import 'package:flutter_age_fans/core/repositories/age_fans_repository/age_fans_repository.dart';
import 'package:flutter_age_fans/locator.dart';
import 'package:flutter_age_fans/ui/views/list_view_model.dart';

class AniCollectionViewModel extends ListViewModel {
  final AgeFansRepository _repository = locator<AgeFansRepository>();
  var _collectionCount = 0;
  final _collectionList = <AniPreBean>[];

  List<AniPreBean> get collectionList => _collectionList;

  int get rankCount => _collectionCount;

  @override
  int get firstPage => 0;

  @override
  void init() {
    refresh();
  }

  @override
  void loadData(int page, bool isRefresh) {
    _repository.fetchCollectionList(page).then((value) {
      _onDataLoad(value, isRefresh);
    }).catchError((error) {
      loadDataCompleted(isRefresh: isRefresh, success: false);
    });
  }

  void _onDataLoad(AniCollectionBean data, bool isRefresh) {
    if (data.data == null || isRefresh) {
      _collectionList.clear();
    }
    _collectionCount = data.data?.allSize ?? 0;
    if (data.data != null) {
      _collectionList.addAll(data.data!.list);
    }
    loadDataCompleted(
        isRefresh: isRefresh, hasMoreData: _collectionList.length < _collectionCount);
  }
}
