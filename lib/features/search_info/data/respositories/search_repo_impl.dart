import '../../domain/repositories/search_repositories.dart';
import '../data_sources/local/search_local_data_source.dart';
import '../data_sources/remote/search_remote_data_source.dart';
import '../models/search_info_model.dart';

class EmployeeRepositoryImpl implements EmployeeRepository {
  final EmployeeRemoteDataSource remoteDataSource;
  final EmployeeLocalDataSource localDataSource;

  EmployeeRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<EmployeeModel> searchEmployees(String query) async {
    try {
      final remoteResult = await remoteDataSource.searchEmployees(query);

      await localDataSource.cacheEmployees(remoteResult);

      return remoteResult;
    } catch (e) {
      final cached = await localDataSource.getCachedEmployees();

      if (cached != null) {
        return cached;
      }

      rethrow;
    }
  }
}
