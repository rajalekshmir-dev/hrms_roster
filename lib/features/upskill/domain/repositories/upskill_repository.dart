import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/upskill_entities.dart';

abstract class UpskillRepository {
  Future<Either<Failure, UpskillSuggestionResponse>> getUpskillSuggestions();
}