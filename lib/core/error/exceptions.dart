//route
class RouteException implements Exception {
  final String message;
  const RouteException(this.message);
}

class ApiException implements Exception {
  final String message;
  final int? statusCode;

  ApiException({required this.message, this.statusCode});

  @override
  String toString() => 'ApiException: $message (status code: $statusCode)';
}
