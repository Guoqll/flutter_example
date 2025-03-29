import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:flutter_example/core/global_configuration.dart';

import 'basic_interceptor.dart';

class HttpSingleton {
  static final HttpSingleton _instance = HttpSingleton._internal();

  factory HttpSingleton() {
    return _instance;
  }

  late Dio _mDio;

  HttpSingleton._internal() {
    _initHttp();
  }

  void _initHttp() {
    List<Interceptor> mInterceptorList = [
      BasicInterceptor(),
    ];
    _mDio = getDioInstance(mCustomInterceptors: mInterceptorList);
  }

  Dio getDio() {
    return _mDio;
  }

  Dio getDioInstance({List<Interceptor>? mCustomInterceptors}) {
    Dio dio = Dio();
    dio.options = BaseOptions(
      baseUrl: GlobalConfiguration.baseUrl,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
      sendTimeout: const Duration(seconds: 3),
      responseType: ResponseType.json,
      /*contentType: Headers.formUrlEncodedContentType,*/
    );
    dio.interceptors.add(
      RetryInterceptor(
        dio: dio,
        logPrint: print, // specify log function (optional)
        retries: 3, // retry count (optional)
        retryDelays: const [
          // set delays between retries (optional)
          Duration(seconds: 1), // wait 1 sec before the first retry
          Duration(seconds: 2), // wait 2 sec before the second retry
          Duration(seconds: 3), // wait 3 sec before the third retry
        ],
      ),
    );

    if (kDebugMode) {
      dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
      ));
    }
    mCustomInterceptors?.forEach((element) {
      dio.interceptors.add(element);
    });
    return dio;
  }
}
