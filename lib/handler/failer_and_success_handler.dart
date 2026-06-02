import 'package:dio/dio.dart';
part 'dio_exception.dart';

/// Base class for all application failures.
///
/// Every failure type extends this class and provides a
/// human-readable message describing the error.
sealed class FailureHandler {
  const FailureHandler({required this.message});

  /// Error message that can be displayed to the user
  /// or used for debugging purposes.
  final String message;
}

/// Represents a validation error.
///
/// Used when user-provided data does not satisfy
/// business or form validation rules.
///
/// Example:
/// - Empty required field
/// - Invalid email address
/// - Invalid phone number
final class ValidationFailure extends FailureHandler {
  const ValidationFailure({required super.message});
}

/// Represents a rate limit error.
///
/// Used when the client exceeds the allowed number
/// of requests within a given time period.
///
/// Example:
/// - HTTP 429 Too Many Requests
final class RateLimitFailure extends FailureHandler {
  const RateLimitFailure({required super.message});
}

/// Represents a resource-not-found error.
///
/// Used when the requested resource does not exist.
///
/// Example:
/// - User not found
/// - Product not found
/// - Record not found
final class NotFoundFailure extends FailureHandler {
  const NotFoundFailure({required super.message});
}

/// Represents an authentication failure.
///
/// Used when the user is not authenticated or
/// provides invalid authentication credentials.
///
/// Example:
/// - Invalid access token
/// - Expired session
/// - Missing authentication header
final class UnauthorizedFailure extends FailureHandler {
  const UnauthorizedFailure({required super.message});
}

/// Represents an authorization failure.
///
/// Used when the authenticated user does not have
/// permission to perform the requested action.
///
/// Example:
/// - Accessing admin-only resources
/// - Insufficient privileges
final class ForbiddenFailure extends FailureHandler {
  const ForbiddenFailure({required super.message});
}

/// Represents a server-side failure.
///
/// Used when an unexpected error occurs on the server.
///
/// Example:
/// - HTTP 500 Internal Server Error
/// - Unhandled backend exception
final class ServerFailure extends FailureHandler {
  const ServerFailure({required super.message});
}

/// Represents a request timeout.
///
/// Used when the server does not respond within
/// the configured timeout duration.
///
/// Example:
/// - Connection timeout
/// - Receive timeout
final class TimeoutFailure extends FailureHandler {
  const TimeoutFailure({required super.message});
}

/// Represents a network-related failure.
///
/// Used when the device cannot communicate with
/// the server due to connectivity issues.
///
/// Example:
/// - No internet connection
/// - DNS resolution failure
/// - Socket exception
final class NetworkFailure extends FailureHandler {
  const NetworkFailure({required super.message});
}

/// Represents a cancelled request.
///
/// Used when an operation is intentionally cancelled
/// before completion.
///
/// Example:
/// - User cancels an upload
/// - API request cancellation
final class CancelFailure extends FailureHandler {
  const CancelFailure({required super.message});
}

/// Represents an unexpected or unclassified failure.
///
/// Used as a fallback when a specific failure type
/// cannot be determined.
final class UnknownFailure extends FailureHandler {
  const UnknownFailure({required super.message});
}

/// Base class representing a successful operation.
///
/// Contains the data returned from a successful
/// business or network operation.
sealed class SuccessHandler<T> {
  const SuccessHandler({required this.data});

  /// Payload returned from the successful operation.
  final T data;
}

/// Represents a successful response containing data.
///
/// Example:
/// ```dart
/// SuccessData<User>(
///   data: user,
/// );
/// ```
final class SuccessData<T> extends SuccessHandler<T> {
  const SuccessData({required super.data});
}
