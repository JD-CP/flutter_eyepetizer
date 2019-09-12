import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_eyepetizer/data/entity/category_entity.dart';
import 'package:flutter_eyepetizer/data/entity/issue_entity.dart';
import 'package:flutter_eyepetizer/http/http.dart';
import 'package:flutter_eyepetizer/util/constant.dart';

class DiscoveryPageModel extends ChangeNotifier {
  bool isInit;

  List<CategoryEntity> categoryList;

  String nextPageUrl;

  void initPage(bool isInit) {
    this.isInit = isInit;
    notifyListeners();
  }

  /// 初始化
  init() async {
    initPage(true);
    await loadData();
  }

  /// 加载数据
  loadData({String url}) async {
    try {
      /// 发起并发请求
      var response = await HttpUtil.buildDio().get(
        Constant.categoryUrl,
        options: Options(
          headers: httpHeaders,
          responseType: ResponseType.plain,
        ),
      );
      var resJson = json.decode(response.toString());
      var dataList = List<CategoryEntity>.from(
        resJson.map((i) => CategoryEntity.fromJson(i)),
      );

      initPage(false);
      this.categoryList = dataList;
      notifyListeners();
    } catch (e, s) {
      print(e.toString());
    }
  }
}
