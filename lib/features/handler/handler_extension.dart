part of 'failer_and_success_handler.dart';

extension FailureHandlerWhen on FailureHandler {
  T when<T>({
    required T Function(ValidationFailure failure) validation,
    required T Function(RateLimitFailure failure) rateLimit,
    required T Function(NotFoundFailure failure) notFound,
    required T Function(UnauthorizedFailure failure) unauthorized,
    required T Function(ForbiddenFailure failure) forbidden,
    required T Function(ServerFailure failure) server,
    required T Function(TimeoutFailure failure) timeout,
    required T Function(NetworkFailure failure) network,
    required T Function(CancelFailure failure) cancel,
    required T Function(UnknownFailure failure) unknown,
  }) {
    return switch (this) {
      final ValidationFailure failure => validation(failure),
      final RateLimitFailure failure => rateLimit(failure),
      final NotFoundFailure failure => notFound(failure),
      final UnauthorizedFailure failure => unauthorized(failure),
      final ForbiddenFailure failure => forbidden(failure),
      final ServerFailure failure => server(failure),
      final TimeoutFailure failure => timeout(failure),
      final NetworkFailure failure => network(failure),
      final CancelFailure failure => cancel(failure),
      final UnknownFailure failure => unknown(failure),
    };
  }
}

extension FailureHandlerMaybeWhen on FailureHandler {
  T maybeWhen<T>({
    required T Function() onError,
    T Function(ValidationFailure failure)? validation,
    T Function(RateLimitFailure failure)? rateLimit,
    T Function(NotFoundFailure failure)? notFound,
    T Function(UnauthorizedFailure failure)? unauthorized,
    T Function(ForbiddenFailure failure)? forbidden,
    T Function(ServerFailure failure)? server,
    T Function(TimeoutFailure failure)? timeout,
    T Function(NetworkFailure failure)? network,
    T Function(CancelFailure failure)? cancel,
    T Function(UnknownFailure failure)? unknown,
  }) {
    return switch (this) {
      final ValidationFailure failure when validation != null =>
        validation(failure),
      final RateLimitFailure failure when rateLimit != null =>
        rateLimit(failure),
      final NotFoundFailure failure when notFound != null => notFound(failure),
      final UnauthorizedFailure failure when unauthorized != null =>
        unauthorized(failure),
      final ForbiddenFailure failure when forbidden != null =>
        forbidden(failure),
      final ServerFailure failure when server != null => server(failure),
      final TimeoutFailure failure when timeout != null => timeout(failure),
      final NetworkFailure failure when network != null => network(failure),
      final CancelFailure failure when cancel != null => cancel(failure),
      final UnknownFailure failure when unknown != null => unknown(failure),
      _ => onError(),
    };
  }
}
