import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eyepetizer/entity/author_info_entity.dart';
import 'package:flutter_eyepetizer/http/http.dart';
import 'package:flutter_eyepetizer/pages/author/issue/author_issue_page.dart';
import 'package:flutter_eyepetizer/pages/author/main/author_main_page.dart';
import 'package:flutter_eyepetizer/pages/author/works/author_works_page.dart';
import 'package:flutter_eyepetizer/util/constant.dart';

class AuthorDetailsModel extends ChangeNotifier {
  int id;
  bool isInit;

  List<TabItem> tabItems = [];
  List<Widget> pages = [];
  List<Widget> pageList = [];

  /// 初始化
  init(id) async {
    this.id = id;
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
        Constant.authorUrl,
        queryParameters: {
          'id': id,
          "udid": 'd2807c895f0348a180148c9dfa6f2feeac0781b5',
        },
        options: Options(headers: httpHeaders),
      );
      Map map = json.decode(response.toString());
      var authorInfoEntity = AuthorInfoEntity.fromJson(map);
      var tabItemList = authorInfoEntity.tabInfo.tabList;
      this.tabItems = tabItemList;

      if (tabItemList.length == 2) {
        pages = [
          AuthorMainPage(
            apiUrl: tabItemList[0].apiUrl,
          ),
          AuthorWorksPage(
            apiUrl: tabItemList[1].apiUrl,
          )
        ];
      } else if (tabItemList.length == 3) {
        pages = [
          AuthorMainPage(
            apiUrl: tabItemList[0].apiUrl,
          ),
          AuthorWorksPage(
            apiUrl: tabItemList[1].apiUrl,
          ),
          AuthorIssuePage(
            apiUrl: tabItemList[2].apiUrl,
          )
        ];
      }

      _initPage(false);
      notifyListeners();
    } catch (e, s) {
      print(e);
    }
  }
}
