import 'package:dartz/dartz.dart';
import 'package:hrms_roster/features/upskill/domain/repositories/upskill_repository.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/error/exceptions.dart';
import '../../domain/entities/upskill_entities.dart';
import '../datasources/upskill_remote_datasource.dart';

class UpskillRepositoryImpl implements UpskillRepository {
  final UpskillRemoteDataSource remoteDataSource;

  UpskillRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, UpskillSuggestionResponse>> getUpskillSuggestions() async {
    try {
      final response = await remoteDataSource.getUpskillSuggestions();
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Unexpected error: ${e.toString()}'));
    }
  }
}