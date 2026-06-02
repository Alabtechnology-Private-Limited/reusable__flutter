// ignore_for_file: inference_failure_on_function_invocation
part of 'failer_and_success_handler.dart';

/// Internal model used to store failed requests that are waiting
/// for the access token refresh process to complete.
///
/// When multiple API requests receive a 401 response at the same time,
/// they are temporarily queued instead of immediately failing.
///
/// Once the refresh token API succeeds, all queued requests are retried.
///
/// This class is intended for internal use only.
class _RequestModel {
  _RequestModel({required this.requestOptions, required this.handler});

  /// Original request that failed with a 401 response.
  final RequestOptions requestOptions;

  /// Dio handler used to either retry the request
  /// or reject it after the refresh process completes.
  final ErrorInterceptorHandler handler;
}

/// Manages automatic access token refresh and request retry logic.
///
/// This class prevents multiple refresh token API calls from being
/// executed simultaneously when several requests receive a 401 response.
///
/// Workflow:
///
/// 1. An API request returns 401 Unauthorized.
/// 2. The failed request is added to a queue.
/// 3. A refresh token API call is executed.
/// 4. If refresh succeeds:
///    - A new access token is stored.
///    - All queued requests are retried.
/// 5. If refresh fails:
///    - All queued requests are rejected.
///    - Stored authentication data is cleared.
///
/// Benefits:
///
/// - Prevents duplicate refresh API calls.
/// - Prevents race conditions.
/// - Automatically retries failed requests.
/// - Centralizes token refresh logic.
///
/// Example:
///
/// ```text
/// Request A -> 401
/// Request B -> 401
/// Request C -> 401
///
/// Refresh Token API -> Called Once
///
/// New Token Received
///
/// Request A -> Retry
/// Request B -> Retry
/// Request C -> Retry
/// ```
final class TokenManager {
  /// Creates a token manager responsible for handling
  /// access token refresh operations.
  ///
  /// Parameters:
  ///
  /// - [baseUrl] Base API URL.
  /// - [curdRep] Storage implementation used to read and write tokens.
  /// - [refreshApiEndPoint] Endpoint responsible for generating
  ///   a new access token.
  /// - [contentType] Request content type.
  /// - [connectTimeOut] Connection timeout in seconds.
  /// - [receiveTimeOut] Response timeout in seconds.
  TokenManager({
    required String baseUrl,
    required this.curdRep,
    required this.refreshApiEndPoint,
    String contentType = 'application/json',
    int connectTimeOut = 8,
    int receiveTimeOut = 8,
  }) : refreshDio = Dio()
          ..options = BaseOptions(
            baseUrl: baseUrl,
            validateStatus: (_) => true,
            contentType: 'application/json',
            connectTimeout: Duration(seconds: connectTimeOut),
            receiveTimeout: Duration(seconds: receiveTimeOut),
          );

  /// Dedicated Dio instance used exclusively for refresh token requests.
  ///
  /// Using a separate Dio instance avoids interceptor loops and
  /// prevents refresh requests from triggering the same interceptor.
  final Dio refreshDio;

  /// Storage abstraction used for token persistence.
  ///
  /// Expected responsibilities:
  ///
  /// - Read refresh token
  /// - Store new access token
  /// - Clear authentication data during logout
  final CurdRep curdRep;

  /// API endpoint used to obtain a new access token.
  final String refreshApiEndPoint;

  /// Queue containing requests waiting for the refresh process.
  final Queue<_RequestModel> _apiQueue = Queue<_RequestModel>();

  /// Indicates whether a refresh operation is currently running.
  ///
  /// If null:
  /// - No refresh request is in progress.
  ///
  /// If not null:
  /// - Other requests must wait until the refresh process completes.
  Completer<bool>? _isRefreshApiOnWork;

  /// Adds a failed request to the retry queue.
  ///
  /// Requests are retried automatically after a successful
  /// refresh token operation.
  void _addToQueue(RequestOptions apiCall, ErrorInterceptorHandler handler) =>
      _apiQueue.add(_RequestModel(requestOptions: apiCall, handler: handler));

  /// Retries all queued requests using the newly acquired access token.
  ///
  /// This method is executed only after a successful refresh response.
  Future<void> _executeQueue() async {
    while (_apiQueue.isNotEmpty) {
      final requestOption = _apiQueue.removeFirst();
      await refreshDio.fetch(requestOption.requestOptions).then(
            requestOption.handler.resolve,
            onError: (Object err) =>
                requestOption.handler.reject(err as DioException),
          );
    }
  }

  /// Rejects all queued requests.
  ///
  /// Called when refresh token validation fails
  /// or when the user must be logged out.
  Future<void> _rejectAll(DioException err) async {
    while (_apiQueue.isNotEmpty) {
      final requestOption = _apiQueue.removeFirst();
      requestOption.handler.reject(err);
    }
  }

  /// Removes all pending requests from the queue.
  void _clearAllQueue() => _apiQueue.clear();

  /// Handles Dio 401 Unauthorized responses.
  ///
  /// Behavior:
  ///
  /// - First 401 request triggers the refresh process.
  /// - Subsequent 401 requests wait in the queue.
  /// - Successful refresh retries queued requests.
  /// - Failed refresh rejects queued requests.
  ///
  /// Non-401 errors are forwarded directly to Dio.
  void errorHandler(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode != 401) return handler.next(err);
    if (_isRefreshApiOnWork == null) {
      _clearAllQueue();
      _isRefreshApiOnWork = Completer<bool>();
      _addToQueue(err.requestOptions, handler);
      final logOut = await _refreshApiCall();
      if (logOut) {
        await _rejectAll(err);
        _isRefreshApiOnWork?.complete(false);
        return;
      } else {
        await _executeQueue();
        _isRefreshApiOnWork?.complete(true);
      }
      _isRefreshApiOnWork = null;
    } else {
      _addToQueue(err.requestOptions, handler);
      final isCompleted = await _isRefreshApiOnWork?.future;
      if (!(isCompleted ?? false)) {
        handler.next(err);
      }
    }
  }

  /// Executes the refresh token API request.
  ///
  /// Returns:
  ///
  /// - `false` -> Refresh successful.
  /// - `true` -> User should be logged out.
  ///
  /// Logout scenarios:
  ///
  /// - Refresh token expired.
  /// - Refresh token invalid.
  /// - Refresh API request failed.
  /// - Storage operation failed.
  ///
  /// On success:
  ///
  /// - Reads refresh token.
  /// - Requests a new access token.
  /// - Persists the new token.
  Future<bool> _refreshApiCall() async {
    try {
      final String? refreshToken = await curdRep.read();
      if (refreshToken == null) return true;
      final refreshApiResponse = await refreshDio.post(
        refreshApiEndPoint,
        data: {'refreshToken': refreshToken},
      );
      if (refreshApiResponse.statusCode == 200) {
        final refreshResponseBody =
            refreshApiResponse.data as Map<String, dynamic>;
        await curdRep.write(
          value: refreshResponseBody['accessToken'] as String,
        );
      } else if (refreshApiResponse.statusCode == 401) {
        Loges.log(
          'Refresh token is expired or invalid, logging out',
          'Token Manager',
        );
        await curdRep.deletAll();
      }
      return refreshApiResponse.statusCode == 401;
    } catch (e) {
      Loges.log(e.toString(), 'Token Manager');
      return true;
    }
  }
}
