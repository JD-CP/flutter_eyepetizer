import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_eyepetizer/data/entity/issue_entity.dart';
import 'package:flutter_eyepetizer/data/eyepetizer_repository.dart';
import 'package:flutter_eyepetizer/util/constant.dart';

class CategoryListModel extends ChangeNotifier {
  EasyRefreshController controller = EasyRefreshController();
  ScrollController scrollController = ScrollController();

  int id;
  String nextPageUrl;
  List<Item> itemList = [];

  bool isInit;
  bool isRefresh = true;

  /// 初始化
  init(id) async {
    this.id = id;
    initPage(true);
    await loadData();
  }

  void initPage(bool isInit) {
    this.isInit = isInit;
    notifyListeners();
  }

  /// 加载数据
  Future<List<Item>> loadData({String url}) async {
    try {
      var response = await EptRepository.getCategoryList(
          isRefresh ? Constant.categoryDetailsUrl : nextPageUrl, id);
      Map map = json.decode(response.toString());
      var issueEntity = Issue.fromJson(map);
      nextPageUrl = issueEntity.nextPageUrl;
      var list = issueEntity.itemList;
      if (isInit) {
        initPage(false);
      }
      if(isRefresh){
        itemList.clear();
        controller.resetRefreshState();
        controller.finishRefresh();
      } else {
        controller.finishLoad();
      }
      itemList.addAll(list);
      notifyListeners();
      return itemList;
    } catch (e, s) {
      if(isRefresh){
        controller.resetRefreshState();
        controller.finishRefresh();
      } else {
        controller.finishLoad();
      }
      return null;
    }
  }

  /// 上拉加载
  Future<List<Item>> onRefresh() async {
    isRefresh = true;
    return await loadData();
  }

  /// 上拉加载
  Future<List<Item>> onLoadMore() async {
    isRefresh = false;
    return await loadData();
  }
}
