// import 'package:get_it/get_it.dart';
// import 'package:hrms_roster/features/Home/data/datasources/home_remote_datasource.dart';
// import 'package:hrms_roster/features/Home/data/repositories/home_repository_impl.dart';
// import 'package:hrms_roster/features/Home/domain/repositories/home_repository.dart';
// import 'package:hrms_roster/features/Home/domain/usecases/get_department_stats.dart';
// import 'package:hrms_roster/features/Home/domain/usecases/get_employee_directory_usecase.dart';
// import 'package:hrms_roster/features/Home/presentation/bloc/home_bloc.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
// import '../network/authenticated_api_client.dart';
// import '../../features/login/data/datasources/auth_local_datasource.dart';
// import '../../features/login/data/datasources/auth_remote_datasource.dart';
// import '../../features/login/data/repositories/auth_repository_impl.dart';
// import '../../features/login/domain/repositories/auth_repository.dart';
// import '../../features/login/domain/usecases/login_usecase.dart';
// import '../../features/login/domain/usecases/logout_usecase.dart';
// import '../../features/login/domain/usecases/check_auth_usecase.dart';
// import '../../features/login/presentation/bloc/auth_bloc.dart';
//
// final sl = GetIt.instance;
//
// Future<void> init() async {
//   // External dependencies
//   final sharedPreferences = await SharedPreferences.getInstance();
//   sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
//
//   // HTTP Client (for non-authenticated requests)
//   sl.registerLazySingleton<http.Client>(() => http.Client());
//
//   // Core
//   sl.registerLazySingleton<AuthLocalDataSource>(() => AuthLocalDataSource());
//
//   // IMPORTANT: Register AuthenticatedApiClient FIRST
//   sl.registerLazySingleton<AuthenticatedApiClient>(
//     () => AuthenticatedApiClient(
//       localDataSource: sl(),
//       baseUrl: 'https://roster.vvdnice.com/api', // Use your actual base URL
//     ),
//   );
//
//   // Remote Data Sources
//   sl.registerLazySingleton<AuthRemoteDataSource>(() => AuthRemoteDataSource());
//
//   // ==================== HOME FEATURE ====================
//   // Home Remote Data Source
//   sl.registerLazySingleton<HomeRemoteDataSource>(
//     () => HomeRemoteDataSourceImpl(authenticatedClient: sl()),
//   );
//
//   // Home Repository
//   sl.registerLazySingleton<HomeRepository>(
//     () => HomeRepositoryImpl(remoteDataSource: sl()),
//   );
//
//   // Home Use Cases - Register WITHOUT "UseCase" suffix
//   sl.registerLazySingleton(
//     () => GetEmployeeDirectory(sl()),
//   ); // Note: No "UseCase"
//   sl.registerLazySingleton(
//     () => GetDepartmentStats(sl()),
//   ); // Note: No "UseCase"
//
//   // Home BLoC
//   sl.registerFactory(
//     () => HomeBloc(getEmployeeDirectory: sl(), getDepartmentStats: sl()),
//   );
//   // ==================== END HOME FEATURE ====================
//
//   // Auth Repositories
//   sl.registerLazySingleton<AuthRepository>(
//     () => AuthRepositoryImpl(remoteDataSource: sl(), localDataSource: sl()),
//   );
//
//   // Auth Use Cases
//   sl.registerLazySingleton(() => LoginUseCase(sl()));
//   sl.registerLazySingleton(() => LogoutUseCase(sl()));
//   sl.registerLazySingleton(() => CheckAuthUseCase(sl()));
//
//   // Auth BLoC
//   sl.registerFactory(
//     () => AuthBloc(
//       loginUseCase: sl(),
//       logoutUseCase: sl(),
//       checkAuthUseCase: sl(),
//     ),
//   );
// }
