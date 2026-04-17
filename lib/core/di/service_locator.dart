
import 'package:get_it/get_it.dart';
import 'package:hrms_roster/features/Home/domain/usecases/get_dashboard_count.dart';
import 'package:hrms_roster/features/Home/domain/usecases/get_employee_details_usecase.dart';
import 'package:hrms_roster/features/upskill/data/datasources/upskill_remote_datasource.dart';
import 'package:hrms_roster/features/upskill/domain/repositories/upskill_repository.dart';
import 'package:hrms_roster/features/upskill/domain/usecases/get_upskill_suggestions.dart';
import 'package:hrms_roster/features/upskill/presentation/bloc/upskill_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../features/Home/data/datasources/home_remote_datasource.dart';
import '../../features/Home/data/repositories/home_repository_impl.dart';
import '../../features/Home/domain/repositories/home_repository.dart';
import '../../features/Home/domain/usecases/get_employee_directory_usecase.dart';
import '../../features/Home/presentation/bloc/home_bloc.dart';
import '../../features/hrms_shell/presentation/bloc/hrms_navigation_bloc.dart';
import '../../features/login/data/datasources/auth_local_datasource.dart';
import '../../features/login/data/datasources/auth_remote_datasource.dart';
import '../../features/login/data/repositories/auth_repository_impl.dart';
import '../../features/login/domain/repositories/auth_repository.dart';
import '../../features/login/domain/usecases/check_auth_usecase.dart';
import '../../features/login/domain/usecases/login_usecase.dart';
import '../../features/login/domain/usecases/logout_usecase.dart';
import '../../features/login/presentation/bloc/auth_bloc.dart';
import '../../features/search_info/data/data_sources/local/search_local_data_source.dart';
import '../../features/search_info/data/data_sources/remote/search_remote_data_source.dart';
import '../../features/search_info/data/respositories/search_repo_impl.dart';
import '../../features/search_info/domain/repositories/search_repositories.dart';
import '../../features/search_info/presentation/bloc/search_bloc.dart';
import '../../features/theme/bloc/theme_bloc.dart' show ThemeBloc;
import '../../features/theme/repository/theme_repo.dart';
import '../../features/upskill/data/repositories/upskill_repository_impl.dart';
import '../../features/users_info/data/repositories/user_info_implementation.dart';
import '../../features/users_info/data_sources/remote/users_info_remote.dart';
import '../../features/users_info/domain/repository/users_info_repositories.dart';
import '../../features/users_info/presentation/bloc/users_info_bloc.dart';
import '../network/authenticated_api_client.dart';

final sl = GetIt.instance;

Future<void> init() async {
  /// =============================
  /// EXTERNAL
  /// =============================
  final sharedPreferences = await SharedPreferences.getInstance();

  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());

  /// =============================
  /// DATA SOURCES 
  /// =============================

  sl.registerLazySingleton<AuthLocalDataSource>(() => AuthLocalDataSource());

  sl.registerLazySingleton<AuthRemoteDataSource>(() => AuthRemoteDataSource());

  sl.registerLazySingleton<UpskillRemoteDataSource>(
  () => UpskillRemoteDataSourceImpl(authenticatedClient: sl()),
);

  /// =============================
  /// CORE CLIENT
  /// =============================

  sl.registerLazySingleton<AuthenticatedApiClient>(
    () => AuthenticatedApiClient(
      localDataSource: sl<AuthLocalDataSource>(),
      baseUrl: 'https://roster.vvdnice.com/api',
    ),
  );

  /// USERS
  sl.registerLazySingleton<UserInfoRemoteDataSource>(
    () => UserInfoRemoteDataSourceImpl(client: sl(), authLocalDataSource: sl()),
  );

  /// SEARCH
  sl.registerLazySingleton<EmployeeRemoteDataSource>(
    () => EmployeeRemoteDataSourceImpl(client: sl(), authLocalDataSource: sl()),
  );

  sl.registerLazySingleton<EmployeeLocalDataSource>(
    () => EmployeeLocalDataSourceImpl(sharedPreferences: sl()),
  );

  /// HOME
  sl.registerLazySingleton<HomeRemoteDataSource>(
    () => HomeRemoteDataSourceImpl(authenticatedClient: sl()),
  );

  /// =============================
  /// REPOSITORIES
  /// =============================

  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: sl(), localDataSource: sl()),
  );

  sl.registerLazySingleton<UserInfoRepository>(
    () => UserInfoRepositoryImpl(remoteDataSource: sl()),
  );

  sl.registerLazySingleton<EmployeeRepository>(
    () => EmployeeRepositoryImpl(
      authLocalDataSource: sl(),
      client: sl(),
      remoteDataSource: sl(),
      localDataSource: sl(),
    ),
  );

  sl.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(remoteDataSource: sl()),
  );

  sl.registerLazySingleton<UpskillRepository>(
  () => UpskillRepositoryImpl(remoteDataSource: sl()),
);

  /// =============================
  /// USE CASES 
  /// =============================

  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => LogoutUseCase(sl()));
  sl.registerLazySingleton(() => CheckAuthUseCase(sl()));
  sl.registerLazySingleton(() => GetEmployeeDirectory(sl()));
  sl.registerLazySingleton(() => GetDashboardCount(sl()));
    sl.registerLazySingleton(() => GetEmployeeDetails(sl()));
    sl.registerLazySingleton(() => GetUpskillSuggestions(sl()));


  /// =============================
  /// BLOCS
  /// =============================

  sl.registerFactory(
    () => AuthBloc(
      loginUseCase: sl(),
      logoutUseCase: sl(),
      checkAuthUseCase: sl(),
    ),
  );

 
  sl.registerFactory(
    () => HomeBloc(
      getEmployeeDirectory: sl(),
       getDashboardCount: sl(),
    ),
  );

  sl.registerFactory(() => NavigationBloc());
  sl.registerFactory(() => UserInfoBloc(sl()));
  sl.registerFactory(() => EmployeeSearchBloc(sl()));
  sl.registerFactory(() => UpskillBloc(getUpskillSuggestions: sl()));

  /// =============================
  /// THEME
  /// =============================

  sl.registerLazySingleton(() => ThemeRepository());
  sl.registerFactory(() => ThemeBloc(sl()));
}