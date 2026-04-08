import 'package:dartz/dartz.dart';
import '../repositories/auth_repository.dart';
import '../entities/user.dart';

class CheckAuthUseCase {
  final AuthRepository repository;

  CheckAuthUseCase(this.repository);

  Future<Either<AuthFailure, User>> execute() async {
    return await repository.checkAuthStatus();
  }
}