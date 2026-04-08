import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../models/search_info_model.dart';

abstract class EmployeeRemoteDataSource {
  Future<EmployeeModel> searchEmployees(String query);
}

class EmployeeRemoteDataSourceImpl implements EmployeeRemoteDataSource {
  final http.Client client;

  EmployeeRemoteDataSourceImpl({required this.client});

  @override
  Future<EmployeeModel> searchEmployees(String query) async {
    final response = await client.post(
      Uri.parse("http://your-api-url/api/search"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"query": query}),
    );

    if (response.statusCode == 200) {
      final decoded = json.decode(response.body);

      return EmployeeModel.fromJson(decoded);
    } else {
      throw Exception("Server Error");
    }
  }
}
