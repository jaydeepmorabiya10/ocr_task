import 'package:dio/dio.dart';

class ApiErrorHandler {
  static String handleError(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
          return 'Connection timeout. Please check your internet connection.';
        case DioExceptionType.sendTimeout:
          return 'Send timeout. Please try again.';
        case DioExceptionType.receiveTimeout:
          return 'Receive timeout. Please try again.';
        case DioExceptionType.badResponse:
          return _handleStatusCode(error.response?.statusCode);
        case DioExceptionType.cancel:
          return 'Request cancelled.';
        case DioExceptionType.unknown:
          return 'Unknown error occurred. Please try again.';
        case DioExceptionType.badCertificate:
          return 'Bad certificate. Please check your connection.';
        case DioExceptionType.connectionError:
          return 'Connection error. Please check your internet connection.';
      }
    } else if (error is Exception) {
      return 'An unexpected error occurred.';
    } else {
      return 'Something went wrong.';
    }
  }

  static String _handleStatusCode(int? statusCode) {
    switch (statusCode) {
      case 400:
        return 'Bad request.';
      case 401:
        return 'Unauthorized. Please login again.';
      case 403:
        return 'Forbidden. You do not have permission.';
      case 404:
        return 'Not found.';
      case 409:
        return 'Conflict. Data already exists.';
      case 500:
        return 'Internal server error.';
      case 502:
        return 'Bad gateway.';
      case 503:
        return 'Service unavailable.';
      default:
        return 'Server error: $statusCode';
    }
  }
}
