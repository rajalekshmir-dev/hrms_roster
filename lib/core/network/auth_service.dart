import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  static const String baseUrl = 'http://172.25.247.15:8000/api';
  static const String loginEndpoint = '/login';
  
  static String? _authToken;
  
  static String? get authToken => _authToken;
  
  static void setAuthToken(String token) {
    _authToken = token;
  }
  
  static void clearAuthToken() {
    _authToken = null;
  }

  Future<Map<String, dynamic>> login({
    required String username,
    required String password,
  }) async {
    try {
      final Uri url = Uri.parse('$baseUrl$loginEndpoint');
      
      print('Request URL: $url'); 
      
      final Map<String, String> headers = {
        'Content-Type': 'application/json',
      };
      
      final Map<String, String> body = {
        'username': username,
        'password': password,
      };
      
      print('Request Body: ${jsonEncode(body)}'); 
      
      final response = await http.post(
        url,
        headers: headers,
        body: jsonEncode(body),
      );

      print('Response Status: ${response.statusCode}');
      print('Response Body: ${response.body}');
      
      if (response.statusCode == 200) {
        final decodedResponse = jsonDecode(response.body);
        
     
        String token = '';
        String tokenType = '';
        
        if (decodedResponse is Map<String, dynamic>) {
          token = decodedResponse['access_token'] ?? '';
          tokenType = decodedResponse['token_type'] ?? 'Bearer';
          
       
          if (token.isNotEmpty) {
            _authToken = token;
            print('Token stored successfully');
            print('Token: $token');
            print('Token Type: $tokenType');
          }
        }
        
        return {
          'success': true,
          'token': token,
          'tokenType': tokenType,
          'data': decodedResponse,
        };
      } else if (response.statusCode == 401) {
        throw Exception('Invalid credentials');
      } else if (response.statusCode == 400) {
        throw Exception('Invalid request. Please check your input.');
      } else if (response.statusCode == 404) {
        throw Exception('API endpoint not found. Please check the URL.');
      } else {
        throw Exception('Login failed with status ${response.statusCode}. Please try again.');
      }
    } catch (e) {
      print('Login Error: $e');
      
      if (e.toString().contains('Invalid credentials')) {
        throw Exception('Invalid credentials');
      } else if (e.toString().contains('SocketException') || 
                 e.toString().contains('Connection refused') ||
                 e.toString().contains('Failed to connect')) {
        throw Exception('Cannot connect to server. Please check your network and server address.');
      } else {
        throw Exception('Network error: ${e.toString()}');
      }
    }
  }
  
  static Future<http.Response> authenticatedGet(String endpoint) async {
    final Uri url = Uri.parse('$baseUrl$endpoint');
    
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $_authToken',
    };
    
    return await http.get(url, headers: headers);
  }
  
  static Future<http.Response> authenticatedPost(String endpoint, Map<String, dynamic> body) async {
    final Uri url = Uri.parse('$baseUrl$endpoint');
    
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $_authToken',
    };
    
    return await http.post(
      url,
      headers: headers,
      body: jsonEncode(body),
    );
  }
}