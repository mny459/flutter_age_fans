import 'package:crypto/crypto.dart';
import 'package:flutter_age_fans/core/data_sources/age_fans/age_fans_request.dart';
import 'package:flutter_age_fans/core/models/ani_catalog/ani_catalog_bean.dart';
import 'package:flutter_age_fans/core/models/ani_collect/ani_collect_bean.dart';
import 'package:flutter_age_fans/core/models/ani_detail/ani_detail.dart';
import 'package:flutter_age_fans/core/models/ani_home/ani_home_all_info_bean.dart';
import 'package:flutter_age_fans/core/models/ani_home/ani_home_bean.dart';
import 'package:flutter_age_fans/core/models/ani_pre/ani_bean.dart';
import 'package:flutter_age_fans/core/models/ani_rank/ani_rank_bean.dart';
import 'package:flutter_age_fans/core/models/ani_search/ani_search_bean.dart';
import 'package:flutter_age_fans/core/models/ani_user/ani_user_bean.dart';
import 'package:flutter_age_fans/core/models/ani_video/ani_get_play_bean.dart';
import 'package:flutter_age_fans/core/models/ani_video/ani_video_bean.dart';
import 'package:flutter_age_fans/core/models/main/main_bean.dart';
import 'package:flutter_age_fans/core/models/recommend/recommend_bean.dart';
import 'package:flutter_age_fans/ui/shared/global_provider.dart';
import 'package:j_net/j_net.dart';
import 'package:logging/logging.dart';

abstract class AgeFansRemoteDataSource {
  Future<MainBean> fetchMainInfo();

  Future<AniHomeAllInfoBean> fetchHomeInfo();

  Future<AniCatalogBean> fetchCatalogList(
      int page,
      String genre,
      String label,
      String letter,
      String order,
      String region,
      String resource,
      String season,
      String status,
      String year);

  Future<RecommendBean> fetchRecommendList(int page);

  Future<RecommendBean> fetchUpdateList(int page);

  Future<AniDetail> fetchAniDetail(String cid);

  Future<AniRankBean> fetchRankList(int page, {String value = ''});

  Future<AniSearchBean> search(String query, int page);

  Future<List<AniBean>> fetchBanners();

  Future<AniUserBean> login(String username, String password);

  Future<AniUserBean> register(String username, String password);

  Future<AniVideoBean> fetchVideoInfo(String playId, String vid);

  Future<AniCollectionBean> addOrDelCollect(bool add, String aid);

  Future<AniCollectionBean> fetchCollectionList(int page);
}

class AgeFansRemoteDataSourceImpl implements AgeFansRemoteDataSource {
  final _log = Logger('AgeFansRemoteDataSourceImpl');

  @override
  Future<MainBean> fetchMainInfo() async {
    var request = AgeFansMainRequest();
    var response = await JNet.getInstance().send(request);
    _log.severe("${response.data}");
    return MainBean.fromJson(response.data);
  }

  @override
  Future<RecommendBean> fetchRecommendList(int page) async {
    final request = AgeFansRecommendRequest(page);
    _log.severe("${request.params}");
    final response = await JNet.getInstance().send(request);
    _log.severe("${response.data}");
    return RecommendBean.fromJson(response.data);
  }

  @override
  Future<RecommendBean> fetchUpdateList(int page) async {
    final request = AgeFansUpdateRequest(page);
    _log.severe("${request.params}");
    final response = await JNet.getInstance().send(request);
    _log.severe("${response.data}");
    return RecommendBean.fromJson(response.data);
  }

  @override
  Future<AniDetail> fetchAniDetail(String cid) async {
    final request = AgeFansDetailRequest(cid);
    final response = await JNet.getInstance().send(request);
    _log.severe("${response.data}");
    return AniDetail.fromJson(response.data);
  }

  @override
  Future<AniRankBean> fetchRankList(int page, {String value = ''}) async {
    final request = AgeFansRankRequest(page, value: value);
    final response = await JNet.getInstance().send(request);
    _log.severe("${response.data}");
    return AniRankBean.fromJson(response.data);
  }

  @override
  Future<AniCatalogBean> fetchCatalogList(
      int page,
      String genre,
      String label,
      String letter,
      String order,
      String region,
      String resource,
      String season,
      String status,
      String year) async {
    final request = AgeFansCatalogRequest(page, genre, label, letter, order,
        region, resource, season, status, year);
    final response = await JNet.getInstance().send(request);
    _log.severe("${response.data}");
    return AniCatalogBean.fromJson(response.data);
  }

  @override
  Future<AniHomeAllInfoBean> fetchHomeInfo() async {
    final banners = await fetchBanners();
    final request = AgeFansHomeRequest();
    final response = await JNet.getInstance().send(request);
    _log.severe("${response.data}");
    final homeInfo = AniHomeBean.fromJson(response.data);
    return AniHomeAllInfoBean(homeInfo, banners);
  }

  @override
  Future<AniSearchBean> search(String query, int page) async {
    final request = AgeFansSearchRequest(query, page);
    final response = await JNet.getInstance().send(request);
    _log.severe("${response.data}");
    return AniSearchBean.fromJson(response.data);
  }

  @override
  Future<List<AniBean>> fetchBanners() async {
    final request = AgeFansSlipicRequest();
    final response = await JNet.getInstance().send(request);
    _log.severe("${response.data}");
    final result = (response.data as List<dynamic>)
        .map((e) => AniBean.fromJson(e))
        .toList();
    return result;
  }

  @override
  Future<AniUserBean> login(String username, String password) async {
    final request = AgeFansLoginRequest(username, password);
    final response = await JNet.getInstance().send(request);
    _log.severe("${response.data}");
    return AniUserBean.fromJson(response.data);
  }

  @override
  Future<AniUserBean> register(String username, String password) async {
    final request = AgeFansRegisterRequest(username, password);
    final response = await JNet.getInstance().send(request);
    _log.severe("${response.data}");
    return AniUserBean.fromJson(response.data);
  }

  @override
  Future<AniVideoBean> fetchVideoInfo(String playId, String vid) async {
    final timeReq = AgeFansGetVideoRequest();
    final timeResponse = await JNet.getInstance().send(timeReq);
    final videoInfo = AniGetPlayBean.fromJson(timeResponse.data);
    final kp =
        '${videoInfo.serverTime}{|}$playId{|}$vid{|}agefans3382-getplay-1719';
    final request = AgeFansVideoRequest(
        videoInfo.host,
        videoInfo.urlPath,
        playId,
        vid,
        videoInfo.serverTime,
        md5.convert(kp.codeUnits).toString());
    final response = await JNet.getInstance().send(request);
    _log.severe("${response.data}");
    return AniVideoBean.fromJson(response.data);
  }

  @override
  Future<AniCollectionBean> addOrDelCollect(bool add, String aid) async {
    final me = GlobalProvider.readUser().me!;
    final request = AgeFansAddOrDelCollectionRequest(
        add, aid, me.username, me.signT.toString(), me.signK);
    final response = await JNet.getInstance().send(request);
    _log.severe("${response.data}");
    return AniCollectionBean.fromJson(response.data);
  }

  @override
  Future<AniCollectionBean> fetchCollectionList(int page) async {
    final me = GlobalProvider.readUser().me!;
    final request = AgeFansCollectionListRequest(
        page, 36, me.username, me.signT.toString(), me.signK);
    final response = await JNet.getInstance().send(request);
    _log.severe("${response.data}");
    return AniCollectionBean.fromJson(response.data);
  }
}
