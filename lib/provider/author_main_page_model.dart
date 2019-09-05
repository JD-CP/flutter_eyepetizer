import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_eyepetizer/entity/issue_entity.dart';
import 'package:flutter_eyepetizer/http/http.dart';

class AuthorMainPageModel extends ChangeNotifier {
  List<Item> itemList = [];

  bool isInit;

  /// 初始化
  init(apiUrl) async {
    initPage(true);
    await loadData(url: apiUrl);
  }

  void initPage(bool isInit) {
    this.isInit = isInit;
    notifyListeners();
  }

  /// 加载数据
  Future<List<Item>> loadData({String url}) async {
    try {
      var response = await HttpUtil.buildDio().get(
        url,
        options: Options(
          headers: httpHeaders,
        ),
      );
      Map map = json.decode(response.toString());
      var issue = Issue.fromJson(map);
      itemList = issue.itemList;
      if (isInit) {
        initPage(false);
      }
      notifyListeners();
      return itemList;
    } catch (e, s) {
      return null;
    }
  }
}
