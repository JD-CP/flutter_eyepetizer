import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eyepetizer/entity/tab_info_entity.dart';
import 'package:flutter_eyepetizer/http/http.dart';
import 'package:flutter_eyepetizer/util/constant.dart';
import '../pages/hot/rank_page_provider.dart';

class HotPageModel extends ChangeNotifier {
  List<Widget> tabPages = [];
  List<TabInfoItem> tabItems = [];

  bool isInit;

  /// 初始化
  init() async {
    _initPage(true);
    await getTabInfo();
  }

  void _initPage(bool isInit) {
    this.isInit = isInit;
    notifyListeners();
  }

  getTabInfo() async {
    try {
      var response = await HttpUtil.buildDio().get(
        Constant.rankListUrl,
        options: Options(headers: httpHeaders),
      );
      Map map = json.decode(response.toString());
      var tabInfoEntity = TabInfoEntity.fromJson(map);
      this.tabItems = tabInfoEntity.tabInfo.tabList;
      this.tabPages = this
          .tabItems
          .map((tabInfoItem) => RankPage(pageUrl: tabInfoItem.apiUrl))
          .toList();
      _initPage(false);
      notifyListeners();
    } catch (e, s) {
      print(e);
    }
  }
}
