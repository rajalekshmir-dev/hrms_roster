import 'package:dartz/dartz.dart';
import '../repositories/auth_repository.dart';

class LogoutUseCase {
  final AuthRepository repository;

  LogoutUseCase(this.repository);

  Future<Either<AuthFailure, Unit>> execute() async {
    return await repository.logout();
  }
}