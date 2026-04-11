import 'package:shared_preferences/shared_preferences.dart';

class AuthLocalDataSource {
  Future<void> saveAuthData({
    required String token,
    required String tokenType,
    required String username,
    required bool rememberMe,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
    await prefs.setString('token_type', tokenType);
    await prefs.setString('username', username);
    await prefs.setBool('remember_me', rememberMe);
  }

  Future<Map<String, dynamic>?> getAuthData() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    if (token == null) return null;

    return {
      'token': token,
      'tokenType': prefs.getString('token_type') ?? 'Bearer',
      'username': prefs.getString('username') ?? '',
      'rememberMe': prefs.getBool('remember_me') ?? false,
    };
  }

  Future<void> clearAuthData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
    await prefs.remove('token_type');
    await prefs.remove('username');
    await prefs.remove('remember_me');
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  Future<String?> getTokenType() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token_type') ?? 'Bearer';
  }

  Future<Map<String, String>> getAuthHeaders() async {
    final token = await getToken();
    final tokenType = await getTokenType();

    if (token != null && token.isNotEmpty) {
      return {
        'Authorization': '$tokenType $token',
        'Content-Type': 'application/json',
      };
    }

    return {'Content-Type': 'application/json'};
  }
}
