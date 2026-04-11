import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

/// AUTH
import '../../features/login/data/datasources/auth_local_datasource.dart';
import '../../features/login/data/datasources/auth_remote_datasource.dart';
import '../../features/login/data/repositories/auth_repository_impl.dart';
import '../../features/login/domain/repositories/auth_repository.dart';
import '../../features/login/domain/usecases/check_auth_usecase.dart';
import '../../features/login/domain/usecases/login_usecase.dart';
import '../../features/login/domain/usecases/logout_usecase.dart';
import '../../features/login/presentation/bloc/auth_bloc.dart';

/// NAVIGATION
import '../../features/hrms_shell/presentation/bloc/hrms_navigation_bloc.dart';

/// USERS
import '../../features/users_info/data_sources/remote/users_info_remote.dart';
import '../../features/users_info/data/repositories/user_info_implementation.dart';
import '../../features/users_info/domain/repository/users_info_repositories.dart';
import '../../features/users_info/presentation/bloc/users_info_bloc.dart';

/// SEARCH
import '../../features/search_info/data/data_sources/local/search_local_data_source.dart';
import '../../features/search_info/data/data_sources/remote/search_remote_data_source.dart';
import '../../features/search_info/data/respositories/search_repo_impl.dart';
import '../../features/search_info/domain/repositories/search_repositories.dart';
import '../../features/search_info/presentation/bloc/search_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  /// =========================
  /// EXTERNAL DEPENDENCIES
  /// =========================

  final sharedPreferences = await SharedPreferences.getInstance();

  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());

  /// =========================
  /// DATA SOURCES
  /// =========================

  /// AUTH
  sl.registerLazySingleton<AuthRemoteDataSource>(() => AuthRemoteDataSource());

  sl.registerLazySingleton<AuthLocalDataSource>(() => AuthLocalDataSource());

  /// USERS
  sl.registerLazySingleton<UserInfoRemoteDataSourceImpl>(
    () => UserInfoRemoteDataSourceImpl(client: sl(), authLocalDataSource: sl()),
  );

  /// SEARCH
  sl.registerLazySingleton<EmployeeRemoteDataSource>(
    () => EmployeeRemoteDataSourceImpl(client: sl(), authLocalDataSource: sl()),
  );

  sl.registerLazySingleton<EmployeeLocalDataSource>(
    () => EmployeeLocalDataSourceImpl(sharedPreferences: sl()),
  );

  /// =========================
  /// REPOSITORIES
  /// =========================

  /// AUTH
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: sl(), localDataSource: sl()),
  );

  /// USERS
  sl.registerLazySingleton<UserInfoRepository>(
    () => UserInfoRepositoryImpl(remoteDataSource: sl()),
  );

  /// SEARCH
  sl.registerLazySingleton<EmployeeRepository>(
    () => EmployeeRepositoryImpl(
      authLocalDataSource: sl(),
      client: sl(),
      remoteDataSource: sl(),
      localDataSource: sl(),
    ),
  );

  /// =========================
  /// USE CASES
  /// =========================

  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => LogoutUseCase(sl()));
  sl.registerLazySingleton(() => CheckAuthUseCase(sl()));

  /// =========================
  /// BLOCS
  /// =========================

  sl.registerFactory(
    () => AuthBloc(
      loginUseCase: sl(),
      logoutUseCase: sl(),
      checkAuthUseCase: sl(),
    ),
  );

  sl.registerFactory(() => NavigationBloc());

  sl.registerFactory(() => UserInfoBloc(sl()));

  sl.registerFactory(() => EmployeeSearchBloc(sl()));
}
