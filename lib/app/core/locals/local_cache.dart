import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class LocalCache {
  static final LocalCache _instance = LocalCache._internal();

  factory LocalCache() {
    return _instance;
  }

  LocalCache._internal();

  static final CacheManager _cacheManager = CacheManager(
    Config("news-images", stalePeriod: Duration(days: 7)),
  );

  CacheManager get cacheManager {
    return _cacheManager;
  }
}
