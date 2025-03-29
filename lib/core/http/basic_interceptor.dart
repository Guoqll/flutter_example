import 'package:dio/dio.dart';

class BasicInterceptor extends Interceptor {
  Map<String, dynamic> commonHeader() {
    return {
      'app_id': 'xx-app',
      'token': "token-value",
    };
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    ///add common header: token
    options.headers.addAll(commonHeader());
    // print('请求头: ${options.headers}');

    ///set content-type
    options.contentType = Headers.jsonContentType;

    ///sort request params
    //options.data = _handlerQueryParams(options.data);
    super.onRequest(options, handler);
  }

  Map<String, dynamic> _handlerQueryParams(Map<String, dynamic> queryParams) {
    Map<String, dynamic> params = queryParams;
    //params.addAll(getCommonParams());
    return params;
  }
}
