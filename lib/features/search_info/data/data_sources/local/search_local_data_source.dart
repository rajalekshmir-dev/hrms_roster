import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../models/search_info_model.dart';

abstract class EmployeeLocalDataSource {
  Future<void> cacheEmployees(EmployeeModel model);

  Future<EmployeeModel?> getCachedEmployees();
}

class EmployeeLocalDataSourceImpl implements EmployeeLocalDataSource {
  final SharedPreferences sharedPreferences;

  EmployeeLocalDataSourceImpl({required this.sharedPreferences});

  static const String CACHE_KEY = "CACHED_EMPLOYEES";

  @override
  Future<void> cacheEmployees(EmployeeModel model) async {
    final jsonString = jsonEncode(model.toJson());

    await sharedPreferences.setString(CACHE_KEY, jsonString);
  }

  @override
  Future<EmployeeModel?> getCachedEmployees() async {
    final jsonString = sharedPreferences.getString(CACHE_KEY);

    if (jsonString != null) {
      final decoded = jsonDecode(jsonString);
      return EmployeeModel.fromJson(decoded);
    }

    return null;
  }
}
