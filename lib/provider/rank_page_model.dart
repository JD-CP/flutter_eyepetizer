import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_eyepetizer/data/entity/issue_entity.dart';
import 'package:flutter_eyepetizer/http/http.dart';

class RankPageModel extends ChangeNotifier {
  EasyRefreshController controller = EasyRefreshController();
  ScrollController scrollController = ScrollController();

  List<Item> itemList = [];
  bool isInit;
  String pageUrl;

  void _initPage(bool isInit) {
    this.isInit = isInit;
    notifyListeners();
  }

  /// 初始化
  init(String pageUrl) async {
    this.pageUrl = pageUrl;
    _initPage(true);
    await _loadData();
  }

  Future<List<Item>> _loadData() async {
    try {
      var response = await HttpUtil.buildDio().get(
        pageUrl,
        options: Options(
          headers: httpHeaders,
        ),
      );
      Map map = json.decode(response.toString());
      var issueEntity = Issue.fromJson(map);
      this.itemList = issueEntity.itemList;
      _initPage(false);
      controller.resetLoadState();
      controller.finishRefresh();
      notifyListeners();
      return itemList;
    } catch (e, s) {
      controller.resetLoadState();
      controller.finishRefresh();
      return null;
    }
  }

  /// 下拉刷新
  Future<List<Item>> onRefresh() async {
    return await _loadData();
  }
}
