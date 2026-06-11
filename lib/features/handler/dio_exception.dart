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
          message: ErrorMessage.longTime,
        );

      case DioExceptionType.cancel:
        return const CancelFailure(
          message: ErrorMessage.requestCancel,
        );

      case DioExceptionType.connectionError:
        return const NetworkFailure(
          message: ErrorMessage.noInternet,
        );

      case DioExceptionType.badResponse:
        switch (response?.statusCode) {
          case 400:
            return ValidationFailure(
              message: _serverMessage ?? ErrorMessage.userNotFound,
            );

          case 401:
            return UnauthorizedFailure(
              message: _serverMessage ?? ErrorMessage.unatorized,
            );

          case 403:
            return ForbiddenFailure(
              message: _serverMessage ?? ErrorMessage.forbidden,
            );

          case 404:
            return NotFoundFailure(
              message: _serverMessage ?? ErrorMessage.noFound,
            );

          case 409:
            return ValidationFailure(
              message: _serverMessage ?? ErrorMessage.validation409,
            );

          case 422:
            return ValidationFailure(
              message: _serverMessage ?? ErrorMessage.validation422,
            );

          case 429:
            return RateLimitFailure(
              message: _serverMessage ?? ErrorMessage.tooManyrequest,
            );

          case 500:
          case 502:
          case 503:
          case 504:
            return ServerFailure(
              message: _serverMessage ?? ErrorMessage.server500to504,
            );

          default:
            return const ServerFailure(
              message: ErrorMessage.somethingUnexcepted,
            );
        }

      case DioExceptionType.unknown:
        return const UnknownFailure(
          message: ErrorMessage.defaultError,
        );

      default:
        return const UnknownFailure(
          message: ErrorMessage.unknownError,
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
