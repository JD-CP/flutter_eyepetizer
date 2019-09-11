import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_eyepetizer/data/entity/category_entity.dart';
import 'package:flutter_eyepetizer/data/entity/issue_entity.dart';
import 'package:flutter_eyepetizer/http/http.dart';
import 'package:flutter_eyepetizer/util/constant.dart';

class DiscoveryPageModel extends ChangeNotifier {
  bool isInit;

  List<Item> followItemList;
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
      var response = await Future.wait([
        /// 热门分类
        HttpUtil.buildDio().get(
          Constant.categoryUrl,
          options: Options(
            headers: httpHeaders,
            responseType: ResponseType.plain,
          ),
        ),
        // 推荐关注
        HttpUtil.buildDio().get(
          Constant.followUrl,
          options: Options(headers: httpHeaders),
        ),
      ]);
      var resJson = json.decode(response[0].toString());
      var dataList = List<CategoryEntity>.from(
        resJson.map((i) => CategoryEntity.fromJson(i)),
      );

      Map map = json.decode(response[1].toString());
      var followEntity = Issue.fromJson(map);
      nextPageUrl = followEntity.nextPageUrl;
      var followItemList = followEntity.itemList;

      initPage(false);
      this.categoryList = dataList;
      this.followItemList = followItemList;
      notifyListeners();
    } catch (e, s) {
      print(e.toString());
    }
  }

  loadNextPage() async {
    try {
      var response = await HttpUtil.buildDio().get(
        null == nextPageUrl ? Constant.followUrl : nextPageUrl,
        options: Options(headers: httpHeaders),
      );
      Map map = json.decode(response.toString());
      var followEntity = Issue.fromJson(map);
      nextPageUrl = followEntity.nextPageUrl;
      var followItemList = followEntity.itemList;
      this.followItemList = followItemList;
      notifyListeners();
    } catch (e, s) {
      print(e.toString());
    }
  }
}
