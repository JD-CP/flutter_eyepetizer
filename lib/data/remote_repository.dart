import 'package:device_info/device_info.dart';
import 'package:dio/dio.dart';
import 'package:flutter_eyepetizer/http/http.dart';

class Repository {
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

  static Future getCategoryList(url, id) async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    var response = await HttpUtil.buildDio().get(
      url,
      queryParameters: {
        "id": id,
        "udid": 'd2807c895f0348a180148c9dfa6f2feeac0781b5',
        "deviceModel": androidInfo.device,
      },
      options: Options(
        connectTimeout: 5000,
        receiveTimeout: 5000,
        headers: httpHeaders,
      ),
    );
    return response;
  }

}
