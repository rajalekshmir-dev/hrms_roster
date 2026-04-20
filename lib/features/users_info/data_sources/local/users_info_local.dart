import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/model/user_info_model.dart';

abstract class UserInfoLocalDataSource {
  Future<void> cacheUserInfo(UserInfoModel model);
  Future<UserInfoModel?> getCachedUserInfo();
  Future<void> clearCache();
}

class UserInfoLocalDataSourceImpl implements UserInfoLocalDataSource {
  static const _cacheKey = "USER_INFO_CACHE";
  static const _cacheTimeKey = "USER_INFO_CACHE_TIME";

  final SharedPreferences prefs;

  UserInfoLocalDataSourceImpl(this.prefs);

  @override
  Future<void> cacheUserInfo(UserInfoModel model) async {
    final jsonString = jsonEncode(model.toJson());

    await prefs.setString(_cacheKey, jsonString);
    await prefs.setInt(_cacheTimeKey, DateTime.now().millisecondsSinceEpoch);
  }

  @override
  Future<UserInfoModel?> getCachedUserInfo() async {
    try {
      final jsonString = prefs.getString(_cacheKey);

      if (jsonString == null) return null;

      /// Optional cache expiry (1 hour)
      final cacheTime = prefs.getInt(_cacheTimeKey);

      if (cacheTime != null) {
        final now = DateTime.now().millisecondsSinceEpoch;
        final diff = now - cacheTime;

        if (diff > Duration(hours: 1).inMilliseconds) {
          return null; // expired
        }
      }

      return UserInfoModel.fromJson(jsonDecode(jsonString));
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> clearCache() async {
    await prefs.remove(_cacheKey);
    await prefs.remove(_cacheTimeKey);
  }
}
