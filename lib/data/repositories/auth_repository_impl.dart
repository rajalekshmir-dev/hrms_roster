import 'package:dartz/dartz.dart';
import 'package:hrms_roster/core/error/exceptions.dart';
import 'package:hrms_roster/features/login/data/datasources/auth_local_datasource.dart';
import 'package:hrms_roster/features/login/data/datasources/auth_remote_datasource.dart';
import 'package:hrms_roster/features/login/data/models/user_model.dart';
import 'package:hrms_roster/features/login/domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<AuthFailure, User>> login({
    required String username,
    required String password,
    required bool rememberMe,
  }) async {
    try {
      print('Repository: Starting login for user: $username');

      final response = await remoteDataSource.login(
        username: username,
        password: password,
      );

      print('Repository: Raw response: $response');

      // Check if response contains expected data
      if (response.isEmpty) {
        return Left(AuthFailure('Empty response from server'));
      }

      final user = UserModel.fromJson(response, username: username);

      print(
        'Repository: Created user: ${user.username}, Token exists: ${user.token.isNotEmpty}',
      );

      if (user.token.isEmpty) {
        return Left(AuthFailure('No token received from server'));
      }

      if (rememberMe) {
        await localDataSource.saveAuthData(
          token: user.token,
          tokenType: user.tokenType,
          username: user.username,
          rememberMe: rememberMe,
        );
        print('Repository: Saved auth data locally');
      }

      return Right(user);
    } on InvalidCredentialsException {
      print('Repository: Invalid credentials');
      return Left(AuthFailure('Invalid username or password'));
    } on NetworkException {
      print('Repository: Network error');
      return Left(AuthFailure('Network error. Please check your connection'));
    } on ServerException {
      print('Repository: Server error');
      return Left(AuthFailure('Server error. Please try again later'));
    } catch (e, stackTrace) {
      print('Repository: Unexpected error: $e');
      print('Stack trace: $stackTrace');
      return Left(AuthFailure('An unexpected error occurred: ${e.toString()}'));
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> logout() async {
    try {
      await localDataSource.clearAuthData();
      return const Right(unit);
    } catch (e) {
      return Left(AuthFailure('Error during logout'));
    }
  }

  @override
  Future<Either<AuthFailure, User>> checkAuthStatus() async {
    try {
      final authData = await localDataSource.getAuthData();

      if (authData != null) {
        final user = UserModel(
          username: authData['username'],
          token: authData['token'],
          tokenType: authData['tokenType'],
        );
        return Right(user);
      }

      return Left(AuthFailure('Not authenticated'));
    } catch (e) {
      return Left(AuthFailure('Error checking auth status'));
    }
  }
}
