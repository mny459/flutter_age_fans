import 'package:flutter_age_fans/core/constant/api_routes.dart';
import 'package:flutter_age_fans/core/models/ani_home/ani_home_bean.dart';
import 'package:flutter_age_fans/core/models/ani_rank/ani_rank_bean.dart';
import 'package:logging/logging.dart';
import 'package:stacked/stacked.dart';

class AniWeekdayUpdateTileViewModel extends BaseViewModel {
  final _log = Logger('AniRankPreTileViewModel');

  late XinFansInfoBean _aniPre;

  XinFansInfoBean get aniPre => _aniPre;

  void init(XinFansInfoBean aniPre) {
    _aniPre = aniPre;
  }
}
