import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';

import '../../core/http/basic_http.dart';

part 'wan_api.g.dart';

///todo: must run the command: dart run build_runner watch
@RestApi()
abstract class WanApi {
  factory WanApi({Dio? dio, String? baseUrl}) {
    dio ??= dio = HttpSingleton().getDio();
    //如有不同于GlobalConfigs.baseUrl 的url，可在此配置
    // dio.options.baseUrl = GlobalConfigs.baseUrl;
    return _WanApi(dio);
  }

  ///获取banner示例
  @GET('banner/json')
  Future<dynamic> getBannerList();
}
