// ignore_for_file: avoid_dynamic_calls

part of 'failer_and_success_handler.dart';

/// Provides a convenient way to convert a [DioException]
/// into a strongly typed [FailureHandler].
///
/// This extension maps Dio-specific exceptions and HTTP status codes
/// into application-friendly failure objects that can be handled
/// consistently throughout the app.
///
/// Example:
///
/// ```dart
/// try {
///   await dio.get('/users');
/// } on DioException catch (exception) {
///   final failure = exception.failure;
///
///   switch (failure) {
///     case UnauthorizedFailure():
///       // Navigate to login screen
///       break;
///
///     case NetworkFailure():
///       // Show internet connection message
///       break;
///
///     default:
///       // Handle other failures
///   }
/// }
/// ```
///
/// Mapping Overview:
///
/// Dio Exception Type             -> Failure Type
/// ------------------------------------------------
/// connectionTimeout             -> TimeoutFailure
/// sendTimeout                   -> TimeoutFailure
/// receiveTimeout                -> TimeoutFailure
/// cancel                        -> CancelFailure
/// connectionError               -> NetworkFailure
/// badResponse                   -> Status code based failure
/// unknown                       -> UnknownFailure
///
/// HTTP Status Code Mapping:
///
/// 400 -> ValidationFailure
/// 401 -> UnauthorizedFailure
/// 403 -> ForbiddenFailure
/// 404 -> NotFoundFailure
/// 422 -> ValidationFailure
/// 429 -> RateLimitFailure
/// 500 -> ServerFailure
/// 502 -> ServerFailure
/// 503 -> ServerFailure
extension DioExceptionExtenstion on DioException {
  /// Converts the current [DioException] into a corresponding
  /// [FailureHandler].
  ///
  /// The returned failure contains a user-friendly message that can be
  /// displayed directly in the UI or used for logging purposes.
  FailureHandler get failure {
    switch (type) {
      case DioExceptionType.connectionTimeout ||
            DioExceptionType.sendTimeout ||
            DioExceptionType.receiveTimeout:
        return const TimeoutFailure(
          message: 'The request took too long to complete. Please try again.',
        );

      case DioExceptionType.cancel:
        return const CancelFailure(
          message: 'The request was cancelled.',
        );

      case DioExceptionType.connectionError:
        return const NetworkFailure(
          message:
              'Unable to connect to the internet. Please check your network connection.',
        );

      case DioExceptionType.badResponse:
        switch (response?.statusCode) {
          case 400:
            return ValidationFailure(
              message: _serverMessage ?? 'The request could not be processed.',
            );

          case 401:
            return UnauthorizedFailure(
              message: _serverMessage ??
                  'Your session has expired. Please sign in again.',
            );

          case 403:
            return ForbiddenFailure(
              message: _serverMessage ??
                  'You do not have permission to perform this action.',
            );

          case 404:
            return NotFoundFailure(
              message: _serverMessage ??
                  'The requested resource could not be found.',
            );

          case 422:
            return ValidationFailure(
              message: _serverMessage ?? 'The submitted data is invalid.',
            );

          case 429:
            return RateLimitFailure(
              message: _serverMessage ??
                  'Too many requests. Please try again later.',
            );

          case 500:
          case 502:
          case 503:
            return ServerFailure(
              message: _serverMessage ??
                  'The server is currently unavailable. Please try again later.',
            );

          default:
            return ServerFailure(
              message:
                  'An unexpected server error occurred (${response?.statusCode}).',
            );
        }

      case DioExceptionType.unknown:
        return UnknownFailure(
          message: message ?? 'An unexpected error occurred. Please try again.',
        );

      default:
        return const UnknownFailure(
          message: 'Something went wrong. Please try again.',
        );
    }
  }

  String? get _serverMessage {
    final data = response?.data;

    if (data is Map<String, dynamic>) {
      return data['message'] as String?;
    }

    return null;
  }
}
