import 'dart:convert';

import 'package:hrms_roster/core/network/authenticated_api_client.dart';
import 'package:hrms_roster/features/Home/data/models/directory_contact_model';

import '../models/department_model.dart';

abstract class HomeRemoteDataSource {
  Future<List<DirectoryContactModel>> getEmployeeDirectory();

  Future<List<DepartmentModel>> getDepartmentStats();
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

        // Handle different response structures
        if (responseData is List) {
          employees = responseData
              .map((json) => DirectoryContactModel.fromJson(json))
              .toList();
        } else if (responseData is Map<String, dynamic>) {
          if (responseData.containsKey('employees') &&
              responseData['employees'] is List) {
            employees = (responseData['employees'] as List)
                .map((json) => DirectoryContactModel.fromJson(json))
                .toList();
          } else if (responseData.containsKey('data') &&
              responseData['data'] is List) {
            employees = (responseData['data'] as List)
                .map((json) => DirectoryContactModel.fromJson(json))
                .toList();
          } else if (responseData.containsKey('results') &&
              responseData['results'] is List) {
            employees = (responseData['results'] as List)
                .map((json) => DirectoryContactModel.fromJson(json))
                .toList();
          }
        }

        print('Parsed ${employees.length} employees');

        if (employees.isEmpty) {
          print('No employees found, using mock data');
          return getMockEmployeeDirectory();
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
      return throw Exception('Failed to fetch employees: $e');
      ;
    }
  }

  @override
  Future<List<DepartmentModel>> getDepartmentStats() async {
    try {
      final response = await authenticatedClient.get(
        '/dashboard/department_stats',
      );

      if (response.statusCode == 200) {
        final dynamic responseData = jsonDecode(response.body);
        List<DepartmentModel> departments = [];

        if (responseData is List) {
          departments = responseData
              .map((json) => DepartmentModel.fromJson(json))
              .toList();
        } else if (responseData is Map<String, dynamic>) {
          if (responseData.containsKey('departments') &&
              responseData['departments'] is List) {
            departments = (responseData['departments'] as List)
                .map((json) => DepartmentModel.fromJson(json))
                .toList();
          } else if (responseData.containsKey('data') &&
              responseData['data'] is List) {
            departments = (responseData['data'] as List)
                .map((json) => DepartmentModel.fromJson(json))
                .toList();
          }
        }

        return departments;
      } else {
        throw Exception('Failed to load department stats');
      }
    } catch (e) {
      print('Error fetching department stats: $e');
      return getMockDepartmentStats();
    }
  }

  List<DirectoryContactModel> getMockEmployeeDirectory() {
    return [
      const DirectoryContactModel(
        name: 'Ourgan',
        title: 'Cloud and Mobile Apps · Sr Principal Engineer (Software)',
        location: 'Ourgan',
        occupancyPercent: 0,
      ),
      const DirectoryContactModel(
        name: 'Khushboo Varshney',
        title: 'Cloud and Mobile Apps · Director - Software',
        location: 'Ourgan',
        occupancyPercent: 0,
      ),
      const DirectoryContactModel(
        name: 'Vikash Kumar Jangid',
        title: 'Cloud and Mobile Apps · Sr Principal Engineer (Software)',
        location: '1/100',
        occupancyPercent: 1,
      ),
      const DirectoryContactModel(
        name: 'Vinoy Raghu',
        title: 'AVP - Cloud & Mobile Apps',
        location: 'Kochi',
        occupancyPercent: 0,
      ),
      const DirectoryContactModel(
        name: 'Shivar Mittal',
        title: 'Sr Engineer (Software)',
        location: 'VVDN/34948',
        occupancyPercent: 0,
      ),
      const DirectoryContactModel(
        name: 'Naveen M',
        title: 'Software Engineer',
        location: 'Kochi',
        occupancyPercent: 0,
      ),
      const DirectoryContactModel(
        name: 'Aman Singh',
        title: 'Senior Developer',
        location: 'Bangalore',
        occupancyPercent: 0,
      ),
    ];
  }

  List<DepartmentModel> getMockDepartmentStats() {
    return [
      const DepartmentModel(name: 'Engineering', count: 250, percentage: 50.0),
      const DepartmentModel(name: 'Product', count: 100, percentage: 20.0),
      const DepartmentModel(name: 'Sales', count: 80, percentage: 16.0),
      const DepartmentModel(name: 'HR', count: 40, percentage: 8.0),
      const DepartmentModel(name: 'Finance', count: 30, percentage: 6.0),
    ];
  }
}
