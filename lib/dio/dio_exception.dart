import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';

class DioException implements Exception {
  late String errroMessage;
  DioException.fromDioError(DioError dioError) {
    switch (dioError.type) {
      case DioErrorType.cancel:
        errroMessage = tr('err_cancel');
        break;
      case DioErrorType.connectTimeout:
        errroMessage = tr('err_connect');
        break;
      case DioErrorType.receiveTimeout:
        errroMessage = tr('err_receive');
        break;
      case DioErrorType.sendTimeout:
        errroMessage = tr('err_send');
        break;
      case DioErrorType.response:
        errroMessage = _handleStatusCode(dioError.response?.statusCode);
        break;
      case DioErrorType.other:
        if (dioError.message.contains('SocketException')) {
          errroMessage = tr('err_internet');
          break;
        }
        errroMessage = tr('err_other1');
        break;
      default:
        errroMessage = tr('err_other2');
    }
  }
  String _handleStatusCode(int? statusCode) {
    switch (statusCode) {
      case 400:
        return tr('err_400');
      case 401:
        return tr('err_401');
      case 403:
        return tr('err_403');
      case 404:
        return tr('err_404');
      case 405:
        return tr('err_405');
      case 415:
        return tr('err_415');
      case 422:
        return tr('err_422');
      case 429:
        return tr('err_429');
      case 500:
        return tr('err_500');
      default:
        return tr('err_other3');
    }
  }

  @override
  String toString() => errroMessage;
}
