// import 'package:dartz/dartz.dart';
// import '../../../../core/error/exceptions.dart';
// import '../../../../core/error/failures.dart';
// import '../../domain/entities/user.dart';
// import '../../domain/repositories/auth_repository.dart';
// import '../datasources/auth_remote_datasource.dart';
// import '../datasources/auth_local_datasource.dart';
// import '../models/user_model.dart';

// class AuthRepositoryImpl implements AuthRepository {
//   final AuthRemoteDataSource remoteDataSource;
//   final AuthLocalDataSource localDataSource;

//   AuthRepositoryImpl({
//     required this.remoteDataSource,
//     required this.localDataSource,
//   });

//   @override
//   Future<Either<Failure, User>> login({
//     required String username,
//     required String password,
//     required bool rememberMe,
//   }) async {
//     try {
//       final response = await remoteDataSource.login(
//         username: username,
//         password: password,
//       );

//       final user = UserModel.fromJson({
//         ...response,
//         'username': username,
//       });

//       if (rememberMe) {
//         await localDataSource.saveAuthData(
//           token: user.token,
//           tokenType: user.tokenType,
//           username: user.username,
//           rememberMe: rememberMe,
//         );
//       }

//       return Right(user);
//     } on InvalidCredentialsException {
//       return Left(AuthFailure('Invalid username or password'));
//     } on NetworkException {
//       return Left(NetworkFailure('Network error. Please check your connection'));
//     } on ServerException {
//       return Left(ServerFailure('Server error. Please try again later'));
//     } catch (e) {
//       return Left(UnknownFailure('An unexpected error occurred'));
//     }
//   }

//   @override
//   Future<Either<Failure, Unit>> logout() async {
//     try {
//       await localDataSource.clearAuthData();
//       return const Right(unit);
//     } catch (e) {
//       return Left(UnknownFailure('Error during logout'));
//     }
//   }

//   @override
//   Future<Either<Failure, User>> checkAuthStatus() async {
//     try {
//       final authData = await localDataSource.getAuthData();

//       if (authData != null) {
//         final user = UserModel(
//           username: authData['username'],
//           token: authData['token'],
//           tokenType: authData['tokenType'],
//         );
//         return Right(user);
//       }

//       return Left(AuthFailure('Not authenticated'));
//     } catch (e) {
//       return Left(UnknownFailure('Error checking auth status'));
//     }
//   }
// }

import 'package:dartz/dartz.dart';
import 'package:hrms_roster/core/error/exceptions.dart';
import 'package:hrms_roster/core/error/failures.dart';
import 'package:hrms_roster/features/login/data/datasources/auth_local_datasource.dart';
import 'package:hrms_roster/features/login/data/datasources/auth_remote_datasource.dart';
import 'package:hrms_roster/features/login/domain/entities/user.dart';
import 'package:hrms_roster/features/login/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, User>> login({
    required String username,
    required String password,
    required bool rememberMe,
  }) async {
    try {
      final response = await remoteDataSource.login(
        username: username,
        password: password,
      );

      print('=== LOGIN RESPONSE ===');
      print('Response: $response');

      String token = '';
      String tokenType = 'Bearer';

      if (response.containsKey('access_token')) {
        token = response['access_token'];
        tokenType = response['token_type'] ?? 'Bearer';
      } else if (response.containsKey('token')) {
        token = response['token'];
        tokenType = response['token_type'] ?? 'Bearer';
      } else if (response.containsKey('data')) {
        token =
            response['data']['token'] ?? response['data']['access_token'] ?? '';
        tokenType = response['data']['token_type'] ?? 'Bearer';
      }

      if (token.isEmpty) {
        print('Token not found in response');
        return Left(AuthFailure('Token not found in response'));
      }

      print('Extracted Token: $token');
      print('Token Type: $tokenType');

      await localDataSource.saveAuthData(
        token: token,
        tokenType: tokenType,
        username: username,
        rememberMe: rememberMe,
      );

      print(' Token saved successfully to SharedPreferences');

      final user = User(username: username, token: token, tokenType: tokenType);

      return Right(user);
    } on InvalidCredentialsException {
      return Left(AuthFailure('Invalid username or password'));
    } on NetworkException {
      return Left(
        NetworkFailure('Network error occurred. Please check your connection.'),
      );
    } on ServerException {
      return Left(
        ServerFailure('Server error occurred. Please try again later.'),
      );
    } catch (e) {
      print('Unexpected error: $e');
      return Left(AuthFailure('Unexpected error: $e'));
    }
  }

  @override
  Future<Either<Failure, User>> checkAuthStatus() async {
    try {
      final authData = await localDataSource.getAuthData();

      if (authData != null) {
        final token = authData['token'] as String;
        final tokenType = authData['tokenType'] as String;
        final username = authData['username'] as String;

        if (token.isNotEmpty) {
          print(' User already authenticated: $username');
          final user = User(
            username: username,
            token: token,
            tokenType: tokenType,
          );
          return Right(user);
        }
      }

      print(' No saved auth data found');
      return Left(AuthFailure('Not authenticated'));
    } catch (e) {
      print('Error checking auth status: $e');
      return Left(AuthFailure('Error checking authentication status'));
    }
  }

  @override
  Future<Either<Failure, Unit>> logout() async {
    try {
      await localDataSource.clearAuthData();
      print('Auth data cleared successfully');
      return const Right(unit);
    } catch (e) {
      print('Error logging out: $e');
      return Left(AuthFailure('Error logging out'));
    }
  }
}
