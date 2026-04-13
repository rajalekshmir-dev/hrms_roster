import 'package:dartz/dartz.dart';
import 'package:hrms_roster/features/Home/domain/entities/department.dart';

import '../../../../core/error/failures.dart';
import '../repositories/home_repository.dart';

class GetDepartmentStats {
  final HomeRepository repository;

  GetDepartmentStats(this.repository);

  Future<Either<Failure, List<Department>>> call() async {
    return await repository.getDepartmentStats();
  }
}
