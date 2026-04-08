import 'package:get_it/get_it.dart';
import 'package:hrms_roster/features/search_info/data/data_sources/local/search_local_data_source.dart';
import 'package:hrms_roster/features/search_info/data/data_sources/remote/search_remote_data_source.dart';
import 'package:hrms_roster/features/search_info/data/respositories/search_repo_impl.dart';
import 'package:hrms_roster/features/search_info/domain/repositories/search_repositories.dart';
import 'package:hrms_roster/features/search_info/presentation/bloc/search_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  final prefs = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => prefs);

  /// BLoC
  sl.registerFactory(() => EmployeeSearchBloc(sl()));

  /// Repository
  sl.registerLazySingleton<EmployeeRepository>(
    () => EmployeeRepositoryImpl(remoteDataSource: sl(), localDataSource: sl()),
  );

  /// Data Sources
  /// Remote DataSource
  sl.registerLazySingleton<EmployeeRemoteDataSource>(
    () => EmployeeRemoteDataSourceImpl(client: sl()),
  );

  /// Local DataSource
  sl.registerLazySingleton<EmployeeLocalDataSource>(
    () => EmployeeLocalDataSourceImpl(sharedPreferences: sl()),
  );
}
