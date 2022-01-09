import 'package:flutter_age_fans/core/constant/api_routes.dart';
import 'package:flutter_age_fans/core/models/ani_catalog/ani_catalog_bean.dart';
import 'package:flutter_age_fans/core/models/ani_pre/ani_pre_bean.dart';
import 'package:logging/logging.dart';
import 'package:stacked/stacked.dart';

class AniPreTileViewModel extends BaseViewModel {
  final _log = Logger('AniPreTileViewModel');

  late AniPreLBean _aniPre;

  AniPreLBean get aniPre => _aniPre;

  String get url => '${ApiRoutes.domainAgeFans}${_aniPre.picSmall}';

  void init(AniPreLBean aniPre) {
    _aniPre = aniPre;
  }
}
