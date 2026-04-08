import 'package:dartz/dartz.dart';

import '../entities/user.dart';

abstract class AuthRepository {
  Future<Either<AuthFailure, User>> login({
    required String username,
    required String password,
    required bool rememberMe,
  });

  Future<Either<AuthFailure, Unit>> logout();

  Future<Either<AuthFailure, User>> checkAuthStatus();
}

class AuthFailure {
  final String message;

  AuthFailure(this.message);
}
