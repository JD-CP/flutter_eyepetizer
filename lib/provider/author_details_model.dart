import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eyepetizer/data/entity/author_info_entity.dart';
import 'package:flutter_eyepetizer/http/http.dart';
import 'package:flutter_eyepetizer/pages/author/author_details_page.dart';
import 'package:flutter_eyepetizer/pages/author/issue/author_issue_page.dart';
import 'package:flutter_eyepetizer/pages/author/main/author_main_page.dart';
import 'package:flutter_eyepetizer/pages/author/works/author_works_page.dart';
import 'package:flutter_eyepetizer/util/constant.dart';

class AuthorDetailsModel extends ChangeNotifier {
  AuthorDetailsPageState vsync;

  AuthorDetailsModel({this.vsync});

  int id;
  bool isInit;

  List<TabItem> tabItems = [];
  List<Widget> pages = [];
  List<Widget> pageList = [];

  AuthorInfoPgcinfo info;
  TabController tabController;

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
      print(
          "request url : ${Constant.authorUrl}?id=$id&udid=d2807c895f0348a180148c9dfa6f2feeac0781b5");
      Map map = json.decode(response.toString());
      var authorInfoEntity = AuthorInfoEntity.fromJson(map);
      var tabItemList = authorInfoEntity.tabInfo.tabList;
      this.info = authorInfoEntity.pgcInfo;
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

      if (isInit) {
        this.tabController =
            TabController(length: tabItemList.length, vsync: this.vsync);
      }

      _initPage(false);
      notifyListeners();
    } catch (e, s) {
      print(e);
    }
  }
}
