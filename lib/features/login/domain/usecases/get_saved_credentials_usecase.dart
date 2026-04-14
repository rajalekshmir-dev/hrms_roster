
import 'package:dartz/dartz.dart';
import 'package:hrms_roster/core/error/failures.dart';
import '../repositories/auth_repository.dart';

class GetSavedCredentials {
  final AuthRepository repository;

  GetSavedCredentials(this.repository);

  Future<Either<Failure, Map<String, String>?>> execute() async {
    try {
    
      return const Right(null);
    } catch (e) {
      return Left(AuthFailure(e.toString()));
    }
  }
}