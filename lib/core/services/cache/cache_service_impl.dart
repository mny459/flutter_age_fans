import 'dart:convert';

import 'package:flutter_age_fans/core/helper/platform_helper.dart';
import 'package:flutter_age_fans/core/services/cache/cache_service.dart';
import 'package:flutter_disk_lru_cache/flutter_disk_lru_cache.dart';
import 'package:logging/logging.dart';
import 'package:path_provider/path_provider.dart';

class CacheServiceImpl implements CacheService {
  final _log = Logger('CacheServiceImpl');

  CacheServiceImpl() {
    init();
  }

  static const _kAniMain = 'aniMain';
  static const _kAniHome = 'aniHome';
  static const _kAniCatalog = 'aniCatalog';
  static const _kAniRecommend = 'aniRecommend';
  static const _kAniUpdate = 'aniUpdate';
  static const _kAniRank = 'aniRank';

  late DiskLruCache _diskLruCache;

  @override
  Future init() async {
    if (PlatformHelper.isWeb()) return;
    final tempDir = await getTemporaryDirectory();
    _diskLruCache = await DiskLruCache.open(tempDir);
  }

  Future<String> _getFromDisk(String key) async {
    if (PlatformHelper.isWeb()) return '';
    final snapshot = await _diskLruCache.get(key);
    var accessFile = snapshot?.getRandomAccessFile(0);
    final bytes = accessFile?.readSync(snapshot?.getLength(0) ?? 0);
    snapshot?.close();
    final result = bytes != null ? utf8.decode(bytes) : '';
    _log.finest('(Fetching) key: $key value: $result');
    return result;
  }

  Future<void> _saveToDisk(String key, String content) async {
    if (PlatformHelper.isWeb()) return;
    final edit = await _diskLruCache.edit(key);
    var faultHidingIOSink = edit?.newOutputIOSink(0);
    faultHidingIOSink?.write(content);
    faultHidingIOSink?.flush();
    faultHidingIOSink?.close();
    edit?.commit(_diskLruCache);
    _log.finest('(Saving) key: $key value: $content');
  }

  @override
  Future<String> getCatalogInfo() {
    return _getFromDisk(_kAniCatalog);
  }

  @override
  Future<String> getHomeInfo() {
    return _getFromDisk(_kAniHome);
  }

  @override
  Future<String> getMainInfo() {
    return _getFromDisk(_kAniMain);
  }

  @override
  Future<String> getRankInfo() {
    return _getFromDisk(_kAniRank);
  }

  @override
  Future<String> getRecommendInfo() {
    return _getFromDisk(_kAniRecommend);
  }

  @override
  Future<String> getUpdateInfo() {
    return _getFromDisk(_kAniUpdate);
  }

  @override
  Future<void> putCatalogInfo(String info) {
    return _saveToDisk(_kAniCatalog, info);
  }

  @override
  Future<void> putHomeInfo(String info) {
    return _saveToDisk(_kAniHome, info);
  }

  @override
  Future<void> putMainInfo(String info) {
    return _saveToDisk(_kAniMain, info);
  }

  @override
  Future<void> putRankInfo(String info) {
    return _saveToDisk(_kAniRank, info);
  }

  @override
  Future<void> putRecommendInfo(String info) {
    return _saveToDisk(_kAniRecommend, info);
  }

  @override
  Future<void> putUpdateInfo(String info) {
    return _saveToDisk(_kAniUpdate, info);
  }
}
