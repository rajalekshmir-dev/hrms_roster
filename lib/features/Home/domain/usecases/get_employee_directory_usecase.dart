import 'package:dartz/dartz.dart';
import 'package:hrms_roster/features/Home/domain/entities/directory_contact.dart';

import '../../../../core/error/failures.dart';
import '../repositories/home_repository.dart';

class GetEmployeeDirectory {
  final HomeRepository repository;

  GetEmployeeDirectory(this.repository);

  Future<Either<Failure, List<DirectoryContact>>> call() async {
    return await repository.getEmployeeDirectory();
  }
}
