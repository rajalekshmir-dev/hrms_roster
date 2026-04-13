import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object> get props => [message];

  @override
  String toString() => message;
}

// Authentication Failures
class AuthFailure extends Failure {
  const AuthFailure(super.message);
}

// Network Failures
class NetworkFailure extends Failure {
  const NetworkFailure(super.message);
}

// Server Failures
class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

// Cache Failures
class CacheFailure extends Failure {
  const CacheFailure(super.message);
}

// Validation Failures
class ValidationFailure extends Failure {
  const ValidationFailure(super.message);
}

// Permission Failures
class PermissionFailure extends Failure {
  const PermissionFailure(super.message);
}

// Not Found Failure
class NotFoundFailure extends Failure {
  const NotFoundFailure(super.message);
}

// Format Failure (for parsing errors)
class FormatFailure extends Failure {
  const FormatFailure(super.message);
}
