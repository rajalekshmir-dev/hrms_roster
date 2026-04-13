import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../login/data/datasources/auth_local_datasource.dart';
import '../../data/model/user_info_model.dart';

abstract class UserInfoRemoteDataSource {
  Future<UserInfoModel> fetchUserInfo();
}

class UserInfoRemoteDataSourceImpl implements UserInfoRemoteDataSource {
  final http.Client client;
  final AuthLocalDataSource authLocalDataSource;

  UserInfoRemoteDataSourceImpl({
    required this.client,
    required this.authLocalDataSource,
  });

  @override
  Future<UserInfoModel> fetchUserInfo() async {
    final headers = await authLocalDataSource.getAuthHeaders();

    final uri = Uri.parse(
      "https://roster.vvdnice.com/api/dashboard/employee_directory",
    );

    print("REQUEST URL: $uri");
    print("HEADERS: $headers");

    final response = await client.get(uri, headers: headers);

    print("STATUS CODE: ${response.statusCode}");
    print("RESPONSE BODY: ${response.body}");

    if (response.statusCode == 200) {
      return UserInfoModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Server Error ${response.statusCode}");
    }
  }
}
