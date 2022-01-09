import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:stacked/stacked.dart';

abstract class ListViewModel<T> extends BaseViewModel {
  int get firstPage => 0;
  int _curPage = 0;

  void init();

  final RefreshController _refreshController = RefreshController();

  RefreshController get refreshController => _refreshController;

  void refresh() {
    _curPage = firstPage;
    loadData(_curPage, true);
  }

  void loadMore() {
    _curPage += 1;
    loadData(_curPage, false);
  }

  void loadData(int page, bool isRefresh);

  void loadDataCompleted(
      {bool isRefresh = true, bool success = true, bool hasMoreData = true}) {
    if (!hasMoreData) {
      _loadNoMoreData();
    }
    if (isRefresh) {
      _refreshCompleted(success: success);
    } else if (hasMoreData) {
      _loadComplete(success: success);
    }
    notifyListeners();
  }

  void _loadNoMoreData() {
    _refreshController.loadNoData();
  }

  void _refreshCompleted({bool success = true}) {
    if (success) {
      _refreshController.refreshCompleted(resetFooterState: true);
    } else {
      _refreshController.refreshFailed();
    }
  }

  void _loadComplete({bool success = true}) {
    if (success) {
      _refreshController.loadComplete();
    } else {
      _refreshController.loadFailed();
    }
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  void notifyListenersNextFrame() {
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    // });
    notifyListeners();
  }
}
