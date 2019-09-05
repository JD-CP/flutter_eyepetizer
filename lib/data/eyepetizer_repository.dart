import 'package:dio/dio.dart';
import 'package:flutter_eyepetizer/http/http.dart';

class EptRepository {
  static Future getHomePageList(url) async {
    var response = await HttpUtil.buildDio().get(
      url,
      options: Options(
        connectTimeout: 5000,
        receiveTimeout: 5000,
        headers: httpHeaders,
      ),
    );
    return response;
  }

  static Future getFollowList(url) async {
    var response = await HttpUtil.buildDio().get(
      url,
      options: Options(
        connectTimeout: 5000,
        receiveTimeout: 5000,
        headers: httpHeaders,
      ),
    );
    return response;
  }

}
