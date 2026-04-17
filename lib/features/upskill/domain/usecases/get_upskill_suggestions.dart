import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/upskill_entities.dart';
import '../repositories/upskill_repository.dart';

class GetUpskillSuggestions {
  final UpskillRepository repository;

  GetUpskillSuggestions(this.repository);

  Future<Either<Failure, UpskillSuggestionResponse>> call() async {
    return await repository.getUpskillSuggestions();
  }
}