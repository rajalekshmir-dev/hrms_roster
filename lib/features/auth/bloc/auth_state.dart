part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class Authenticated extends AuthState {
  final String username;
  final bool rememberMe;
  final String token;
  final String tokenType;

  const Authenticated({
    required this.username,
    required this.rememberMe,
    required this.token,
    required this.tokenType,
  });

  @override
  List<Object?> get props => [username, rememberMe, token, tokenType];
}

class Unauthenticated extends AuthState {}

class AuthError extends AuthState {
  final String message;

  const AuthError(this.message);

  @override
  List<Object?> get props => [message];
}