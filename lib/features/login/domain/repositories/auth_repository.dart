import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> login({
    required String username,
    required String password,
    required bool rememberMe,
  });

  Future<Either<Failure, Unit>> logout();

  Future<Either<Failure, User>> checkAuthStatus();
}
