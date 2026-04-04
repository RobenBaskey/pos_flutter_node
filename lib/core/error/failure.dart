import 'package:dio/dio.dart';

import 'exceptions.dart';

class DioErrorHandler {
  static ApiException handleError(DioException error) {
    if (error.response != null) {
      final statusCode = error.response!.statusCode;

      final message = error.response!.data['message'] ?? 'Unknown error';

      switch (statusCode) {
        case 400:
          return ApiException(message: '$message', statusCode: statusCode);
        case 401:
          return ApiException(
              message: 'Unauthorized: $message', statusCode: statusCode);
        case 403:
          return ApiException(message: '$message', statusCode: statusCode);
        case 404:
          return ApiException(message: '$message', statusCode: statusCode);
        case 422:
          final message = error.response!.data['errors'];
          return ApiException(message: message[0], statusCode: statusCode);
        case 500:
          return ApiException(
              message: 'Internal Server Error: $message',
              statusCode: statusCode);
        default:
          return ApiException(
              message: 'Unexpected error: $message', statusCode: statusCode);
      }
    } else {
      // Handle network or timeout errors
      return ApiException(
          message: error.message ?? 'Network error occurred', statusCode: null);
    }
  }
}