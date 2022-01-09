import 'dart:convert';

import 'package:flutter_age_fans/core/models/main/main_bean.dart';
import 'package:flutter_age_fans/core/repositories/age_fans_repository/age_fans_repository.dart';
import 'package:flutter_age_fans/core/services/cache/cache_service.dart';
import 'package:flutter_age_fans/locator.dart';
import 'package:logging/logging.dart';
import 'package:stacked/stacked.dart';

class StartUpViewModel extends BaseViewModel {
  final CacheService _cacheService = locator<CacheService>();
  final AgeFansRepository _repository = locator<AgeFansRepository>();
  final _log = Logger('StartUpViewModel');
  var _startUpUrl = '';

  Future<void> init() async {
    final mainInfo = await _cacheService.getMainInfo();
    if (mainInfo.isNotEmpty) {
      final mainBean = MainBean.fromJson(jsonDecode(mainInfo));
      // _startUpUrl = mainBean.launch.pic[]
    }
    _repository.fetchMainInfo().then((value) {
      _cacheService.putMainInfo(jsonEncode(value.toJson()));
    });
  }
}
