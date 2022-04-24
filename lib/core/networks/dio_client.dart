import 'dart:developer';

import 'package:dio/dio.dart';

class DioClient {
  final String apiBaseUrl;

  DioClient(this.apiBaseUrl);

  Dio get dio => _getDio();

  Dio _getDio() {
    BaseOptions options = BaseOptions(
      baseUrl: apiBaseUrl,
      connectTimeout: 50000,
      receiveTimeout: 30000,
    );
    Dio dio = Dio(options);
    dio.interceptors.addAll(<Interceptor>[CustomInterceptors()]);

    return dio;
  }
}

class CustomInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    log('METHOD[${options.method}] => PATH: ${options.baseUrl}${options.path}');
    log('REQUEST => ${options.data}');
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    log('RESPONSE[${response.statusCode}] => DATA: ${response.data}');
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    log('ERROR[${err.response?.statusCode}] => DATA: ${err.response?.data}');
    return super.onError(err, handler);
  }
}
