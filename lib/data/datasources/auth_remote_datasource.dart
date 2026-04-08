import 'dart:async';
import 'dart:convert';
import 'package:hrms_roster/core/error/exceptions.dart';
import 'package:http/http.dart' as http;

class AuthRemoteDataSource {
  static const String baseUrl = 'http://172.25.247.15:8000/api';
  static const String loginEndpoint = '/login';

  Future<Map<String, dynamic>> login({
    required String username,
    required String password,
  }) async {
    try {
      final Uri url = Uri.parse('$baseUrl$loginEndpoint');
      
      print('=== API REQUEST ===');
      print('URL: $url');
      print('Body: {"username": "$username", "password": "***"}');

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'username': username, 'password': password}),
      ).timeout(const Duration(seconds: 30));

      print('=== API RESPONSE ===');
      print('Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final decodedResponse = jsonDecode(response.body);
        print('Decoded Response Keys: ${decodedResponse.keys}');
        return decodedResponse;
      } else if (response.statusCode == 401) {
        throw InvalidCredentialsException();
      } else if (response.statusCode == 400) {
        throw InvalidRequestException();
      } else {
        throw ServerException();
      }
    } on http.ClientException catch (e) {
      print('Network Exception: $e');
      throw NetworkException();
    } on TimeoutException catch (e) {
      print('Timeout Exception: $e');
      throw NetworkException();
    } catch (e) {
      print('Unexpected Exception: $e');
      rethrow;
    }
  }
}