import 'package:dartz/dartz.dart';
import 'package:hrms_roster/features/Home/domain/entities/department.dart';
import 'package:hrms_roster/features/Home/domain/entities/directory_contact.dart';
import '../../../../core/error/failures.dart';


abstract class HomeRepository {
  Future<Either<Failure, List<DirectoryContact>>> getEmployeeDirectory();
  Future<Either<Failure, List<Department>>> getDepartmentStats();
}