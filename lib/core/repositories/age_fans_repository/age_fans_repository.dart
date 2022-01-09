import 'package:flutter_age_fans/core/models/ani_catalog/ani_catalog_bean.dart';
import 'package:flutter_age_fans/core/models/ani_collect/ani_collect_bean.dart';
import 'package:flutter_age_fans/core/models/ani_detail/ani_detail.dart';
import 'package:flutter_age_fans/core/models/ani_home/ani_home_all_info_bean.dart';
import 'package:flutter_age_fans/core/models/ani_rank/ani_rank_bean.dart';
import 'package:flutter_age_fans/core/models/ani_search/ani_search_bean.dart';
import 'package:flutter_age_fans/core/models/ani_user/ani_user_bean.dart';
import 'package:flutter_age_fans/core/models/ani_video/ani_video_bean.dart';
import 'package:flutter_age_fans/core/models/main/main_bean.dart';
import 'package:flutter_age_fans/core/models/recommend/recommend_bean.dart';

abstract class AgeFansRepository {
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

  Future<AniUserBean> login(String username, String password);

  Future<AniUserBean> register(String username, String password);

  Future<AniVideoBean> fetchVideoInfo(String playId, String vid);

  Future<AniCollectionBean> addOrDelCollect(bool add, String aid);

  Future<AniCollectionBean> fetchCollectionList(int page);

}
