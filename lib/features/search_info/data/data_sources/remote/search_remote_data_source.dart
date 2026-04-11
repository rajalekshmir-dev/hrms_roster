import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../login/data/datasources/auth_local_datasource.dart';
import '../../models/search_info_model.dart';

abstract class EmployeeRemoteDataSource {
  Future<EmployeeModel> searchEmployees(String query);
}

class EmployeeRemoteDataSourceImpl implements EmployeeRemoteDataSource {
  final http.Client client;
  final AuthLocalDataSource authLocalDataSource;

  EmployeeRemoteDataSourceImpl({
    required this.client,
    required this.authLocalDataSource,
  });

  @override
  Future<EmployeeModel> searchEmployees(String query) async {
    final headers = await authLocalDataSource.getAuthHeaders();

    final uri = Uri.parse(
      "https://roster.vvdnice.com/api/search-rank-simplified-new",
    );

    print("REQUEST URL: $uri");
    print("HEADERS: $headers");

    final response = await client.post(
      uri,
      headers: headers,
      body: jsonEncode({"query": query}),
    );

    print("STATUS CODE: ${response.statusCode}");
    print("RESPONSE BODY: ${response.body}");

    if (response.statusCode == 200) {
      return EmployeeModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Server Error ${response.statusCode}");
    }
  }
}
