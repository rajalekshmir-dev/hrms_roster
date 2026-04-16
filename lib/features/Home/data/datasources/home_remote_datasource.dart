import 'dart:convert';
import 'package:hrms_roster/core/network/authenticated_api_client.dart';
import 'package:hrms_roster/features/Home/data/models/dashboard_count_model.dart';
import 'package:hrms_roster/features/Home/data/models/directory_contact_model.dart';

abstract class HomeRemoteDataSource {
  Future<List<DirectoryContactModel>> getEmployeeDirectory({
    int page = 1,
    int limit = 20,
  });
  Future<DashboardCountModel> getDashboardCount();
  Future<DirectoryContactModel> getEmployeeDetails(String employeeId);
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final AuthenticatedApiClient authenticatedClient;

  HomeRemoteDataSourceImpl({required this.authenticatedClient});

  @override
  Future<List<DirectoryContactModel>> getEmployeeDirectory({
    int page = 1,
    int limit = 20,
  }) async {
    try {
      final response = await authenticatedClient.get(
        '/dashboard/employee_directory?page=$page&limit=$limit',
      );

      print('=== API RESPONSE DEBUG ===');
      print('Status Code: ${response.statusCode}');

      if (response.statusCode == 200) {
        final dynamic responseData = jsonDecode(response.body);
        List<DirectoryContactModel> employees = [];

        // Handle the response structure: {"status":"success","employees":[...]}
        if (responseData is Map<String, dynamic>) {
          // Check if the response has an 'employees' key
          if (responseData.containsKey('employees') && responseData['employees'] is List) {
            employees = (responseData['employees'] as List)
                .map((json) => DirectoryContactModel.fromJson(json))
                .toList();
          } 
          // Check if the response has a 'data' key
          else if (responseData.containsKey('data') && responseData['data'] is List) {
            employees = (responseData['data'] as List)
                .map((json) => DirectoryContactModel.fromJson(json))
                .toList();
          } 
          // Check if the response has a 'results' key
          else if (responseData.containsKey('results') && responseData['results'] is List) {
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

        // Apply pagination if needed
        if (employees.length > limit && page > 1) {
          final startIndex = (page - 1) * limit;
          final endIndex = startIndex + limit;
          if (startIndex < employees.length) {
            employees = employees.sublist(
              startIndex,
              endIndex > employees.length ? employees.length : endIndex,
            );
          } else {
            employees = [];
          }
        }

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
      final response = await authenticatedClient.get('/dashboard/count_data');

      print('=== DASHBOARD COUNT API RESPONSE ===');
      print('Status Code: ${response.statusCode}');

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        return DashboardCountModel.fromJson(responseData);
      } else if (response.statusCode == 401) {
        throw Exception('Unauthorized');
      } else {
        throw Exception(
          'Failed to load dashboard count: ${response.statusCode}',
        );
      }
    } catch (e) {
      print('Error fetching dashboard count: $e');
      throw Exception('Failed to fetch dashboard count: $e');
    }
  }

 @override
Future<DirectoryContactModel> getEmployeeDetails(String employeeId) async {
  try {
    // If the employeeId contains '/', extract the numeric part
    String finalEmployeeId = employeeId;
    if (employeeId.contains('/')) {
      final parts = employeeId.split('/');
      finalEmployeeId = parts.last;
      print('Converting ID from $employeeId to $finalEmployeeId');
    }
    
    final response = await authenticatedClient.get(
      '/employees/$finalEmployeeId',
    );

    print('=== EMPLOYEE DETAILS API RESPONSE ===');
    print('Status Code: ${response.statusCode}');
    print('Requested Employee ID: $finalEmployeeId');

    if (response.statusCode == 200) {
      final dynamic responseData = jsonDecode(response.body);

      if (responseData is Map<String, dynamic> &&
          responseData.containsKey('employee') &&
          responseData['employee'] is Map<String, dynamic>) {
        final employeeData = responseData['employee'] as Map<String, dynamic>;

        // Use the factory method for detailed employee data
        return DirectoryContactModel.fromEmployeeDetailsJson(employeeData);
      } else {
        throw Exception('Invalid response format: missing employee data');
      }
    } else if (response.statusCode == 401) {
      throw Exception('Unauthorized access');
    } else if (response.statusCode == 404) {
      throw Exception('Employee not found');
    } else {
      throw Exception(
        'Failed to load employee details: ${response.statusCode}',
      );
    }
  } catch (e) {
    print('Error fetching employee details: $e');
    throw Exception('Failed to fetch employee details: $e');
  }
}
}
