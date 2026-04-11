import 'package:dartz/dartz.dart';
import 'package:hrms_roster/core/error/failures.dart';
import '../repositories/auth_repository.dart';
import '../entities/user.dart';


class CheckAuthUseCase {
  final AuthRepository repository;

  CheckAuthUseCase(this.repository);

  Future<Either<Failure, User>> execute() async {
    return await repository.checkAuthStatus();
  }
}
