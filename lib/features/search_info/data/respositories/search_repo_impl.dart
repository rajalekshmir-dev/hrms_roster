import 'package:hrms_roster/features/login/data/datasources/auth_local_datasource.dart';
import 'package:http/http.dart' as http;

import '../../domain/repositories/search_repositories.dart';
import '../data_sources/local/search_local_data_source.dart';
import '../data_sources/remote/search_remote_data_source.dart';
import '../models/search_info_model.dart';

class EmployeeRepositoryImpl implements EmployeeRepository {
  final EmployeeRemoteDataSource remoteDataSource;
  final EmployeeLocalDataSource localDataSource;
  final http.Client client;
  final AuthLocalDataSource authLocalDataSource;

  EmployeeRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.client,
    required this.authLocalDataSource,
  });

  @override
  Future<EmployeeModel> searchEmployees(String query) async {
    print("REPOSITORY START");
    try {
      final remoteResult = await remoteDataSource.searchEmployees(query);
      await localDataSource.cacheEmployees(remoteResult);
      print('serach repo implement $remoteResult');
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
