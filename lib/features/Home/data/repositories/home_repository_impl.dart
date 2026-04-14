
// import 'package:dartz/dartz.dart';
// import 'package:hrms_roster/features/Home/domain/entities/directory_contact.dart';

// import '../../../../core/error/failures.dart';
// import '../../domain/repositories/home_repository.dart';
// import '../datasources/home_remote_datasource.dart';

// class HomeRepositoryImpl implements HomeRepository {
//   final HomeRemoteDataSource remoteDataSource;

//   HomeRepositoryImpl({required this.remoteDataSource});

//   @override
//   Future<Either<Failure, List<DirectoryContact>>> getEmployeeDirectory() async {
//     try {
//       final employees = await remoteDataSource.getEmployeeDirectory();
//       return Right(employees);
//     } catch (e) {
//       return Left(ServerFailure(e.toString()));
//     }
//   }
// }




import 'package:dartz/dartz.dart';
import 'package:hrms_roster/features/Home/domain/entities/dashboard_count.dart';
import 'package:hrms_roster/features/Home/domain/entities/directory_contact.dart';

import '../../../../core/error/failures.dart';
import '../../domain/repositories/home_repository.dart';
import '../datasources/home_remote_datasource.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;

  HomeRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<DirectoryContact>>> getEmployeeDirectory() async {
    try {
      final employees = await remoteDataSource.getEmployeeDirectory();
      return Right(employees);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, DashboardCount>> getDashboardCount() async {
    try {
      final dashboardCount = await remoteDataSource.getDashboardCount();
      return Right(DashboardCount(
        freepoolCount: dashboardCount.freepoolCount,
        projectCount: dashboardCount.projectCount,
        employeeCount: dashboardCount.employeeCount,
      ));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}