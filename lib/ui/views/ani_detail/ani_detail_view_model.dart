import 'package:flutter_age_fans/core/models/ani_detail/ani_detail.dart';
import 'package:flutter_age_fans/core/models/ani_detail/ani_pan_detail_bean.dart';
import 'package:flutter_age_fans/core/repositories/age_fans_repository/age_fans_repository.dart';
import 'package:flutter_age_fans/core/services/navigation/navigation_helper.dart';
import 'package:flutter_age_fans/locator.dart';
import 'package:logging/logging.dart';
import 'package:stacked/stacked.dart';

class AniDetailViewModel extends BaseViewModel {
  final _logger = Logger('AniDetailViewModel');
  final AgeFansRepository _repository = locator<AgeFansRepository>();
  var _cid = '';
  final _panResList = <AniPanDetailBean>[];
  AniDetail? _aniDetail;

  AniDetail? get aniDetail => _aniDetail;

  List<AniPanDetailBean> get panResList => _panResList;

  void init(String cid) {
    _cid = cid;
    loadAniInfo();
  }

  void loadAniInfo() {
    _repository.fetchAniDetail(_cid).then((value) {
      _aniDetail = value;
      _initPanRes();
      notifyListeners();
    }).catchError((error) {
      setError(error);
    });
  }

  void _initPanRes() {
    if (_aniDetail == null) return;
    final data = _aniDetail!.aniInfo.resPan;
    _logger.severe('_initPanRes data = $data');
    if (data.contains('密码')) {
      data.split('\n').forEach((item) {
        _logger.severe('_initPanRes item = $item');
        if (item.trim().isNotEmpty) {
          final info = item.trim().split(' ');
          final name = info.first.trim();
          final url = info[1];
          final code = info.last.trim().substring(2);
          _logger.severe('_initPanRes name = $name  url = $url  code = $code');
          _panResList.add(AniPanDetailBean(name, url, code));
        }
      });
    }
  }

  void play(String playId, String playVid) {
    _repository.fetchVideoInfo(playId, playVid).then((value) {
      if (playId.contains('ttm3p')) {
        NavigationHelper.navWebView('${value.pUrlF}${value.vUrl}');
      } else {
        NavigationHelper.navPlayView(value.vUrl);
      }
    });
  }

  void collect() {
    _repository.addOrDelCollect(true, _cid).then((value) {});
  }
}
