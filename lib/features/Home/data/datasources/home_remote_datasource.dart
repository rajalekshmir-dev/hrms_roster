import 'dart:convert';
import 'package:hrms_roster/core/network/authenticated_api_client.dart';
import 'package:hrms_roster/features/Home/data/models/dashboard_count_model.dart';
import 'package:hrms_roster/features/Home/data/models/directory_contact_model.dart';

abstract class HomeRemoteDataSource {
  Future<List<DirectoryContactModel>> getEmployeeDirectory();
  Future<DashboardCountModel> getDashboardCount();
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final AuthenticatedApiClient authenticatedClient;

  HomeRemoteDataSourceImpl({required this.authenticatedClient});

  @override
  Future<List<DirectoryContactModel>> getEmployeeDirectory() async {
    try {
      final response = await authenticatedClient.get(
        '/dashboard/employee_directory',
      );

      print('=== API RESPONSE DEBUG ===');
      print('Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final dynamic responseData = jsonDecode(response.body);
        List<DirectoryContactModel> employees = [];

        if (responseData is Map<String, dynamic>) {
          if (responseData.containsKey('employees') && responseData['employees'] is List) {
            employees = (responseData['employees'] as List)
                .map((json) => DirectoryContactModel.fromJson(json))
                .toList();
          } else if (responseData.containsKey('data') && responseData['data'] is List) {
            employees = (responseData['data'] as List)
                .map((json) => DirectoryContactModel.fromJson(json))
                .toList();
          } else if (responseData.containsKey('results') && responseData['results'] is List) {
            employees = (responseData['results'] as List)
                .map((json) => DirectoryContactModel.fromJson(json))
                .toList();
          }
        } else if (responseData is List) {
          employees = responseData
              .map((json) => DirectoryContactModel.fromJson(json))
              .toList();
        }

        print('Parsed ${employees.length} employees');
        return employees;
      } else if (response.statusCode == 401) {
        throw Exception('Unauthorized');
      } else {
        throw Exception(
          'Failed to load employee directory: ${response.statusCode}',
        );
      }
    } catch (e) {
      print('Error fetching employee directory: $e');
      throw Exception('Failed to fetch employees: $e');
    }
  }

  @override
  Future<DashboardCountModel> getDashboardCount() async {
    try {
      final response = await authenticatedClient.get(
        '/dashboard/count_data',
      );

      print('=== DASHBOARD COUNT API RESPONSE ===');
      print('Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        return DashboardCountModel.fromJson(responseData);
      } else if (response.statusCode == 401) {
        throw Exception('Unauthorized');
      } else {
        throw Exception('Failed to load dashboard count: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching dashboard count: $e');
      throw Exception('Failed to fetch dashboard count: $e');
    }
  }
}