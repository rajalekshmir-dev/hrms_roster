import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/model/user_info_model.dart';

abstract class UserInfoLocalDataSource {
  Future<void> cacheUserInfo(UserInfoModel model);
  Future<UserInfoModel?> getCachedUserInfo();
}

class UserInfoLocalDataSourceImpl implements UserInfoLocalDataSource {
  static const String key = "USER_INFO_CACHE";

  @override
  Future<void> cacheUserInfo(UserInfoModel model) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, jsonEncode(model.toJson()));
  }

  @override
  Future<UserInfoModel?> getCachedUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(key);

    if (jsonString != null) {
      return UserInfoModel.fromJson(jsonDecode(jsonString));
    }
    return null;
  }
}
