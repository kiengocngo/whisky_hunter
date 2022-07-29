import 'package:dio/dio.dart';

class NetworkManager {
  BaseOptions opts = BaseOptions(
    baseUrl: 'https://whiskyhunter.net/api',
    connectTimeout: 3000,
    receiveTimeout: 3000,
    contentType: 'application/json',
  );

  Dio creatDio() {
    return Dio(opts);
  }
}

late String message;
@override
String toString() => message;

extension AppDioExtension on Dio {
  Dio addInterceptors() {
    return this
      ..interceptors.add(
        InterceptorsWrapper(
            onRequest: (options, handler) {},
            onResponse: (response, handler) {},
            onError: (DioError error, ErrorInterceptorHandler handler) {
              switch (error.type) {
                case DioErrorType.connectTimeout:
                  message = "Connect time out with api";
                  break;
                case DioErrorType.receiveTimeout:
                  message = "Receive time out with api";
                  break;
                case DioErrorType.sendTimeout:
                  message = "Send time out with api";
                  break;
                case DioErrorType.cancel:
                  message = "Cancel api";
                  break;
                case DioErrorType.response:
                  message = _handelError(
                      error.response!.statusCode, error.response!.data);
                  break;
                case DioErrorType.other:
                  message = 'Other';
                  break;
              }
            }),
      );
  }
}

String _handelError(int? statusCode, dynamic error) {
  switch (statusCode) {
    case 400:
      return "Bad request";
    case 404:
      return error[message];
    default:
      return "Some things went wrong";
  }
}
