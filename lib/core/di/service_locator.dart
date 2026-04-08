import 'package:get_it/get_it.dart';
import 'package:hrms_roster/features/search_info/data/data_sources/local/search_local_data_source.dart';
import 'package:hrms_roster/features/search_info/data/data_sources/remote/search_remote_data_source.dart';
import 'package:hrms_roster/features/search_info/data/respositories/search_repo_impl.dart';
import 'package:hrms_roster/features/search_info/domain/repositories/search_repositories.dart';
import 'package:hrms_roster/features/search_info/presentation/bloc/search_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/datasources/auth_local_datasource.dart';
import '../../data/datasources/auth_remote_datasource.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/check_auth_usecase.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';
import '../../presentation/bloc/auth_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Register HTTP Client
  sl.registerLazySingleton<http.Client>(() => http.Client());

  // Register SharedPreferences
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

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

  // Bloc
  sl.registerFactory(
    () => AuthBloc(
      loginUseCase: sl(),
      logoutUseCase: sl(),
      checkAuthUseCase: sl(),
    ),
  );

  // Use Cases
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => LogoutUseCase(sl()));
  sl.registerLazySingleton(() => CheckAuthUseCase(sl()));

  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: sl(), localDataSource: sl()),
  );

  // Data Sources
  sl.registerLazySingleton(() => AuthRemoteDataSource());
  sl.registerLazySingleton(() => AuthLocalDataSource());
}
