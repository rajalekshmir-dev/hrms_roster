import 'package:dartz/dartz.dart';
import 'package:hrms_roster/features/Home/domain/entities/dashboard_count.dart';
import '../../../../core/error/failures.dart';
import '../repositories/home_repository.dart';

class GetDashboardCount {
  final HomeRepository repository;

  GetDashboardCount(this.repository);

  Future<Either<Failure, DashboardCount>> call() async {
    return await repository.getDashboardCount();
  }
}