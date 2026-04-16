import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/directory_contact.dart';
import '../repositories/home_repository.dart';

class GetEmployeeDetails {
  final HomeRepository repository;

  GetEmployeeDetails(this.repository);

  Future<Either<Failure, DirectoryContact>> call(String employeeId) async {
    return await repository.getEmployeeDetails(employeeId);
  }
}