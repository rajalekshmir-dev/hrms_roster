import 'package:dartz/dartz.dart';

import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<Either<AuthFailure, User>> execute({
    required String username,
    required String password,
    required bool rememberMe,
  }) async {
    if (username.isEmpty || password.isEmpty) {
      return Left(AuthFailure('Username and password cannot be empty'));
    }

    return await repository.login(
      username: username,
      password: password,
      rememberMe: rememberMe,
    );
  }
}
