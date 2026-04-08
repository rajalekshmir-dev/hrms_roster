import 'dart:convert';

import 'package:hrms_roster/data/datasources/auth_local_datasource.dart';
import 'package:http/http.dart' as http;

import '../error/exceptions.dart';

class AuthenticatedApiClient {
  final AuthLocalDataSource localDataSource;
  final String baseUrl;

  AuthenticatedApiClient({
    required this.localDataSource,
    required this.baseUrl,
  });

  Future<Map<String, String>> _getAuthHeaders() async {
    return await localDataSource.getAuthHeaders();
  }

  Future<http.Response> get(String endpoint) async {
    try {
      final headers = await _getAuthHeaders();
      final url = Uri.parse('$baseUrl$endpoint');

      final response = await http.get(url, headers: headers);

      if (response.statusCode == 401) {
        throw UnauthorizedException();
      }

      return response;
    } on http.ClientException {
      throw NetworkException();
    }
  }

  Future<http.Response> post(
    String endpoint, {
    Map<String, dynamic>? body,
  }) async {
    try {
      final headers = await _getAuthHeaders();
      final url = Uri.parse('$baseUrl$endpoint');

      final response = await http.post(
        url,
        headers: headers,
        body: body != null ? jsonEncode(body) : null,
      );

      if (response.statusCode == 401) {
        throw UnauthorizedException();
      }

      return response;
    } on http.ClientException {
      throw NetworkException();
    }
  }

  Future<http.Response> put(
    String endpoint, {
    Map<String, dynamic>? body,
  }) async {
    try {
      final headers = await _getAuthHeaders();
      final url = Uri.parse('$baseUrl$endpoint');

      final response = await http.put(
        url,
        headers: headers,
        body: body != null ? jsonEncode(body) : null,
      );

      if (response.statusCode == 401) {
        throw UnauthorizedException();
      }

      return response;
    } on http.ClientException {
      throw NetworkException();
    }
  }

  Future<http.Response> delete(String endpoint) async {
    try {
      final headers = await _getAuthHeaders();
      final url = Uri.parse('$baseUrl$endpoint');

      final response = await http.delete(url, headers: headers);

      if (response.statusCode == 401) {
        throw UnauthorizedException();
      }

      return response;
    } on http.ClientException {
      throw NetworkException();
    }
  }
}
