import 'package:flutter_age_fans/core/constant/api_routes.dart';
import 'package:flutter_age_fans/core/models/ani_rank/ani_rank_bean.dart';
import 'package:logging/logging.dart';
import 'package:stacked/stacked.dart';

class AniRankPreTileViewModel extends BaseViewModel {
  final _log = Logger('AniRankPreTileViewModel');

  late AniRankPreBean _aniPre;

  AniRankPreBean get aniPre => _aniPre;

  String get url => '${ApiRoutes.domainAgeFans}${_aniPre.href}';

  void init(AniRankPreBean aniPre) {
    _aniPre = aniPre;
  }
}
