import 'package:dio/dio.dart';
import 'package:talent_app/logger/app_logger.dart';

class BearerTokenInterceptor extends Interceptor {
 // final TokenBox tokenBox;
  final String tokenBox;

  BearerTokenInterceptor(this.tokenBox);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {

    options.headers.addAll({"Authorization": "${tokenBox}"});

    AppLogger.logD(
        'REQUEST[\nMethod: => ${options.method}]\nPATH: => ${options.path}\nHeaders: => ${options.headers}');
    return super.onRequest(options, handler);
  }
}
