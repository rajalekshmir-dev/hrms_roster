import '../../domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.username,
    required super.token,
    required super.tokenType,
  });

  factory UserModel.fromJson(Map<String, dynamic> json, {String? username}) {
       String token = '';
    
    if (json.containsKey('access_token')) {
      token = json['access_token'] ?? '';
    } else if (json.containsKey('token')) {
      token = json['token'] ?? '';
    } else if (json.containsKey('data') && json['data'] is Map) {
      token = json['data']['token'] ?? json['data']['access_token'] ?? '';
    }
    
   
    String tokenType = 'Bearer';
    if (json.containsKey('token_type')) {
      tokenType = json['token_type'] ?? 'Bearer';
    } else if (json.containsKey('type')) {
      tokenType = json['type'] ?? 'Bearer';
    }
    
    print('Extracted Token: $token');
    print('Extracted TokenType: $tokenType');
    
    return UserModel(
      username: username ?? json['username'] ?? json['user']['username'] ?? '',
      token: token,
      tokenType: tokenType,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'access_token': token,
      'token_type': tokenType,
    };
  }
}