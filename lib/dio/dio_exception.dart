import 'package:dio/dio.dart';

class DioException implements Exception {
  late String errroMessage;
  DioException.fromDioError(DioError dioError) {
    switch (dioError.type) {
      case DioErrorType.cancel:
        errroMessage = 'Request to service was cancelled.';
        break;
      case DioErrorType.connectTimeout:
        errroMessage = 'Connection timed out.';
        break;
      case DioErrorType.receiveTimeout:
        errroMessage = 'Recevie timed out';
        break;
      case DioErrorType.sendTimeout:
        errroMessage = 'Send timed out';
        break;
      case DioErrorType.response:
        errroMessage = _handleStatusCode(dioError.response?.statusCode);
        break;
      case DioErrorType.other:
        if (dioError.message.contains('SocketException')) {
          errroMessage = 'No internet';
          break;
        }
        errroMessage = 'Unexpected error occured';
        break;
      default:
        errroMessage = 'Something went wrong';
    }
  }
  String _handleStatusCode(int? statusCode) {
    switch (statusCode) {
      case 400:
        return 'Bad request';
      case 401:
        return 'Authenticaion failed';
      case 403:
        return 'The authenticated user is not allowed to access the specified API endpoint.';
      case 404:
        return 'The requested resource does not exist.';
      case 405:
        return 'Method not allowed. Please check the Allow header for the allowed HTTP methods.';
      case 415:
        return 'Unsupported media type. The requested content type or version number is invalid.';
      case 422:
        return 'Data validation failed.';
      case 429:
        return 'Too many requests.';
      case 500:
        return 'Internal server error.';
      default:
        return 'Oops something went wrong!';
    }
  }

  @override
  String toString() => errroMessage;
}
