abstract class CacheService {
  Future<void> init();

  Future<String> getMainInfo();

  Future<void> putMainInfo(String info);

  Future<String> getHomeInfo();

  Future<void> putHomeInfo(String info);

  Future<String> getCatalogInfo();

  Future<void> putCatalogInfo(String info);

  Future<String> getRecommendInfo();

  Future<void> putRecommendInfo(String info);

  Future<String> getUpdateInfo();

  Future<void> putUpdateInfo(String info);

  Future<String> getRankInfo();

  Future<void> putRankInfo(String info);
}
