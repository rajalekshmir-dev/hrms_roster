// Server Exceptions
class ServerException implements Exception {
  final String message;

  ServerException([this.message = 'Server error occurred']);

  @override
  String toString() => 'ServerException: $message';
}

// Network Exceptions
class NetworkException implements Exception {
  final String message;

  NetworkException([this.message = 'Network error occurred']);

  @override
  String toString() => 'NetworkException: $message';
}

// Authentication Exceptions
class AuthException implements Exception {
  final String message;

  AuthException([this.message = 'Authentication error']);

  @override
  String toString() => 'AuthException: $message';
}

// Invalid Credentials Exception (401)
class InvalidCredentialsException implements Exception {
  final String message;

  InvalidCredentialsException([this.message = 'Invalid username or password']);

  @override
  String toString() => 'InvalidCredentialsException: $message';
}

// Invalid Request Exception (400)
class InvalidRequestException implements Exception {
  final String message;

  InvalidRequestException([this.message = 'Invalid request parameters']);

  @override
  String toString() => 'InvalidRequestException: $message';
}

// Unauthorized Exception (401)
class UnauthorizedException implements Exception {
  final String message;

  UnauthorizedException([this.message = 'Unauthorized access']);

  @override
  String toString() => 'UnauthorizedException: $message';
}

// Forbidden Exception (403)
class ForbiddenException implements Exception {
  final String message;

  ForbiddenException([this.message = 'Access forbidden']);

  @override
  String toString() => 'ForbiddenException: $message';
}

// Not Found Exception (404)
class NotFoundException implements Exception {
  final String message;

  NotFoundException([this.message = 'Resource not found']);

  @override
  String toString() => 'NotFoundException: $message';
}

// Conflict Exception (409)
class ConflictException implements Exception {
  final String message;

  ConflictException([this.message = 'Resource conflict']);

  @override
  String toString() => 'ConflictException: $message';
}

// Validation Exception (422)
class ValidationException implements Exception {
  final String message;
  final Map<String, dynamic>? errors;

  ValidationException([this.message = 'Validation failed', this.errors]);

  @override
  String toString() => 'ValidationException: $message';
}

// Cache Exception
class CacheException implements Exception {
  final String message;

  CacheException([this.message = 'Cache error occurred']);

  @override
  String toString() => 'CacheException: $message';
}

// Format Exception
class FormatException implements Exception {
  final String message;

  FormatException([this.message = 'Data format error']);

  @override
  String toString() => 'FormatException: $message';
}

// Timeout Exception
class TimeoutException implements Exception {
  final String message;

  TimeoutException([this.message = 'Request timeout']);

  @override
  String toString() => 'TimeoutException: $message';
}
