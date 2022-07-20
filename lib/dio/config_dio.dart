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
                  {}
                  break;
                case DioErrorType.receiveTimeout:
                  {}
                  break;
                case DioErrorType.sendTimeout:
                  {}
                  break;
                case DioErrorType.cancel:
                  {}
                  break;
                case DioErrorType.response:
                  {}
                  break;
                case DioErrorType.other:
                  {}
                  break;
              }
              
            }),
      );
  }
}

Future requestInterceptor(
    RequestOptions options, RequestInterceptorHandler handler) async {}
