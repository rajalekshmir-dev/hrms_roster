import 'package:get_it/get_it.dart';
import 'package:hrms_roster/presentation/bloc/auth_bloc.dart';
import '../../data/datasources/auth_remote_datasource.dart';
import '../../data/datasources/auth_local_datasource.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';
import '../../domain/usecases/check_auth_usecase.dart';


final sl = GetIt.instance;

void init() {
  // Bloc
  sl.registerFactory(() => AuthBloc(
    loginUseCase: sl(),
    logoutUseCase: sl(),
    checkAuthUseCase: sl(),
  ));
  
  // Use Cases
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => LogoutUseCase(sl()));
  sl.registerLazySingleton(() => CheckAuthUseCase(sl()));
  
  // Repository
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(
    remoteDataSource: sl(),
    localDataSource: sl(),
  ));
  
  // Data Sources
  sl.registerLazySingleton(() => AuthRemoteDataSource());
  sl.registerLazySingleton(() => AuthLocalDataSource());
}