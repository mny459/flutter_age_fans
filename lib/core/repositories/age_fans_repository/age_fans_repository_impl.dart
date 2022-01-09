import 'package:flutter_age_fans/core/data_sources/age_fans/age_fans_remote_data_source.dart';
import 'package:flutter_age_fans/core/exceptions/cache_exception.dart';
import 'package:flutter_age_fans/core/exceptions/network_exception.dart';
import 'package:flutter_age_fans/core/exceptions/repository_exception.dart';
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
import 'package:flutter_age_fans/core/repositories/age_fans_repository/age_fans_repository.dart';
import 'package:flutter_age_fans/core/services/connectivity/connectivity_service.dart';
import 'package:flutter_age_fans/locator.dart';
import 'package:logging/logging.dart';

class AgeFansRepositoryImpl extends AgeFansRepository {
  final ConnectivityService? connectivityService =
      locator<ConnectivityService>();
  final _log = Logger('AgeFansRepositoryImpl');
  final AgeFansRemoteDataSource remoteDataSource =
      locator<AgeFansRemoteDataSource>();

  @override
  Future<MainBean> fetchMainInfo() {
    try {
      return remoteDataSource.fetchMainInfo();
    } on NetworkException catch (e) {
      _log.severe('Failed to fetch posts remotely $e');
      throw RepositoryException(e.message);
    } on CacheException catch (e) {
      _log.severe('Failed to fetch posts locally $e');
      throw RepositoryException(e.message);
    } catch (e) {
      _log.severe('Failed to fetch posts else $e');
      throw const RepositoryException('');
    }
  }

  @override
  Future<AniHomeAllInfoBean> fetchHomeInfo() {
    try {
      return remoteDataSource.fetchHomeInfo();
    } on NetworkException catch (e) {
      _log.severe('Failed to fetch posts remotely $e');
      throw RepositoryException(e.message);
    } on CacheException catch (e) {
      _log.severe('Failed to fetch posts locally $e');
      throw RepositoryException(e.message);
    } catch (e) {
      _log.severe('Failed to fetch posts else $e');
      throw const RepositoryException('');
    }
  }

  @override
  Future<RecommendBean> fetchRecommendList(int page) {
    try {
      return remoteDataSource.fetchRecommendList(page);
    } on NetworkException catch (e) {
      _log.severe('Failed to fetch posts remotely $e');
      throw RepositoryException(e.message);
    } on CacheException catch (e) {
      _log.severe('Failed to fetch posts locally $e');
      throw RepositoryException(e.message);
    } catch (e) {
      _log.severe('Failed to fetch posts else $e');
      throw const RepositoryException('');
    }
  }

  @override
  Future<RecommendBean> fetchUpdateList(int page) {
    try {
      return remoteDataSource.fetchUpdateList(page);
    } on NetworkException catch (e) {
      _log.severe('Failed to fetch posts remotely $e');
      throw RepositoryException(e.message);
    } on CacheException catch (e) {
      _log.severe('Failed to fetch posts locally $e');
      throw RepositoryException(e.message);
    } catch (e) {
      _log.severe('Failed to fetch posts else $e');
      throw const RepositoryException('');
    }
  }

  @override
  Future<AniDetail> fetchAniDetail(String cid) {
    try {
      return remoteDataSource.fetchAniDetail(cid);
    } on NetworkException catch (e) {
      _log.severe('Failed to fetch posts remotely $e');
      throw RepositoryException(e.message);
    } on CacheException catch (e) {
      _log.severe('Failed to fetch posts locally $e');
      throw RepositoryException(e.message);
    } catch (e) {
      _log.severe('Failed to fetch posts else $e');
      throw const RepositoryException('');
    }
  }

  @override
  Future<AniRankBean> fetchRankList(int page, {String value = ''}) {
    try {
      return remoteDataSource.fetchRankList(page, value: value);
    } on NetworkException catch (e) {
      _log.severe('Failed to fetch posts remotely $e');
      throw RepositoryException(e.message);
    } on CacheException catch (e) {
      _log.severe('Failed to fetch posts locally $e');
      throw RepositoryException(e.message);
    } catch (e) {
      _log.severe('Failed to fetch posts else $e');
      throw const RepositoryException('');
    }
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
      String year) {
    try {
      return remoteDataSource.fetchCatalogList(page, genre, label, letter,
          order, region, resource, season, status, year);
    } on NetworkException catch (e) {
      _log.severe('Failed to fetch posts remotely $e');
      throw RepositoryException(e.message);
    } on CacheException catch (e) {
      _log.severe('Failed to fetch posts locally $e');
      throw RepositoryException(e.message);
    } catch (e) {
      _log.severe('Failed to fetch posts else $e');
      throw const RepositoryException('');
    }
  }

  @override
  Future<AniSearchBean> search(String query, int page) {
    try {
      return remoteDataSource.search(query, page);
    } on NetworkException catch (e) {
      _log.severe('Failed to fetch posts remotely $e');
      throw RepositoryException(e.message);
    } on CacheException catch (e) {
      _log.severe('Failed to fetch posts locally $e');
      throw RepositoryException(e.message);
    } catch (e) {
      _log.severe('Failed to fetch posts else $e');
      throw const RepositoryException('');
    }
  }

  @override
  Future<AniUserBean> login(String username, String password) {
    try {
      return remoteDataSource.login(username, password);
    } on NetworkException catch (e) {
      _log.severe('Failed to fetch posts remotely $e');
      throw RepositoryException(e.message);
    } on CacheException catch (e) {
      _log.severe('Failed to fetch posts locally $e');
      throw RepositoryException(e.message);
    } catch (e) {
      _log.severe('Failed to fetch posts else $e');
      throw const RepositoryException('');
    }
  }

  @override
  Future<AniUserBean> register(String username, String password) {
    try {
      return remoteDataSource.register(username, password);
    } on NetworkException catch (e) {
      _log.severe('Failed to fetch posts remotely $e');
      throw RepositoryException(e.message);
    } on CacheException catch (e) {
      _log.severe('Failed to fetch posts locally $e');
      throw RepositoryException(e.message);
    } catch (e) {
      _log.severe('Failed to fetch posts else $e');
      throw const RepositoryException('');
    }
  }

  @override
  Future<AniVideoBean> fetchVideoInfo(String playId, String vid) {
    try {
      return remoteDataSource.fetchVideoInfo(playId, vid);
    } on NetworkException catch (e) {
      _log.severe('Failed to fetch posts remotely $e');
      throw RepositoryException(e.message);
    } on CacheException catch (e) {
      _log.severe('Failed to fetch posts locally $e');
      throw RepositoryException(e.message);
    } catch (e) {
      _log.severe('Failed to fetch posts else $e');
      throw const RepositoryException('');
    }
  }

  @override
  Future<AniCollectionBean> addOrDelCollect(bool add, String aid) {
    try {
      return remoteDataSource.addOrDelCollect(add, aid);
    } on NetworkException catch (e) {
      _log.severe('Failed to fetch posts remotely $e');
      throw RepositoryException(e.message);
    } on CacheException catch (e) {
      _log.severe('Failed to fetch posts locally $e');
      throw RepositoryException(e.message);
    } catch (e) {
      _log.severe('Failed to fetch posts else $e');
      throw const RepositoryException('');
    }
  }

  @override
  Future<AniCollectionBean> fetchCollectionList(int page) {
    try {
      return remoteDataSource.fetchCollectionList(page);
    } on NetworkException catch (e) {
      _log.severe('Failed to fetch posts remotely $e');
      throw RepositoryException(e.message);
    } on CacheException catch (e) {
      _log.severe('Failed to fetch posts locally $e');
      throw RepositoryException(e.message);
    } catch (e) {
      _log.severe('Failed to fetch posts else $e');
      throw const RepositoryException('');
    }
  }
}
