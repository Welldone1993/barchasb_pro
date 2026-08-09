import 'package:dio/dio.dart';

import '../utils/logger.dart';

class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    logger.i(
      'REQUEST[${options.method}] => PATH: ${options.baseUrl}${options.path} \n Query: ${options.queryParameters}',
    );

    logger.i('HEADER => ${options.headers}');
    if (options.data != null) {
      logger.d('PAYLOAD: ${options.data}');
    }
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    logger.i(
      'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}',
    );
    logger.d('DATA: ${response.data}');
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    logger.e(
      'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}',
    );
    logger.e('ERROR_MESSAGE: ${err.message}');
    if (err.response?.data != null) {
      logger.e('ERROR_DATA: ${err.response?.data}');
    }
    return super.onError(err, handler);
  }
}
