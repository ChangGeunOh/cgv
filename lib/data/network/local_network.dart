import 'package:dio/dio.dart';

class LocalNetwork {
  static Dio get dio {
    final dio = Dio();
    dio.interceptors.add(CustomInterceptor());
    return dio;
  }
}

class CustomInterceptor extends Interceptor {

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    print(handler.toString());
    print('onError');
    // super.onError(err, handler);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    super.onRequest(options, handler);
    print('onRequest');
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);
    print('onResponse');
  }
}
