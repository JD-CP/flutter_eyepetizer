import 'package:dio/dio.dart';

const httpHeaders = {
  'Accept': 'application/json, text/plain, */*',
  'Accept-Encoding': 'gzip, deflate, br',
  'Accept-Language': 'zh-CN,zh;q=0.9',
  'Connection': 'keep-alive',
  'Content-Type': 'application/json',
  'User-Agent':
      'Mozilla/5.0 (iPhone; CPU iPhone OS 11_0 like Mac OS X) AppleWebKit/604.1.38 (KHTML, like Gecko) Version/11.0 Mobile/15A372 Safari/604.1',
};

class HttpUtil {
  static Dio _dio;

  static Options _options = Options(
    connectTimeout: 5000,
    receiveTimeout: 5000,
    headers: httpHeaders,
  );

  /// 构造 Dio 对象
  static Dio buildDio() {
    _dio ??= Dio();

    /// _dio.interceptors.add(LogInterceptor());
    return _dio;
  }

  /// 执行 get 请求
  static doGet(
    String url, {
    queryParameters,
    options,
    Function success,
    Function fail,
  }) async {
    print('http request url: $url');
    try {
      Response response = await buildDio().get(
        url,
        queryParameters: queryParameters,
        options: _options,
      );
      success(response);
      print('http response: $response');
    } catch (exception) {
      fail(exception);
      print('http request fail: $url --- $exception');
    }
  }
}
