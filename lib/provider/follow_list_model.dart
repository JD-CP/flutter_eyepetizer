import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_eyepetizer/data/entity/issue_entity.dart';
import 'package:flutter_eyepetizer/data/eyepetizer_repository.dart';
import 'package:flutter_eyepetizer/util/constant.dart';

class FollowListModel extends ChangeNotifier {
  EasyRefreshController controller = EasyRefreshController();
  ScrollController scrollController = ScrollController();

  String nextPageUrl;
  bool isRefresh = true;
  List<Item> itemList = [];

  bool isInit;

  /// 初始化
  init() async {
    initPage(true);
    await loadData(url: Constant.homePageUrl);
  }

  void initPage(bool isInit) {
    this.isInit = isInit;
    notifyListeners();
  }

  /// 加载数据
  Future<List<Item>> loadData({String url}) async {
    try {
      var response = await EptRepository.getHomePageList(
        isRefresh ? Constant.followUrl : nextPageUrl,
      );
      Map map = json.decode(response.toString());
      var followEntity = Issue.fromJson(map);
      var list = followEntity.itemList;
      this.nextPageUrl = followEntity.nextPageUrl;
      if (isInit) {
        initPage(false);
      }
      if (isRefresh) {
        itemList.clear();
        itemList.addAll(list);
        controller.resetLoadState();
        controller.finishRefresh();
      } else {
        itemList.addAll(list);
        controller.finishLoad();
      }
      notifyListeners();
      return itemList;
    } catch (e, s) {
      if (isRefresh) {
        controller.resetLoadState();
        controller.finishRefresh(
          success: false,
        );
      } else {
        controller.finishLoad();
      }
      return null;
    }
  }

  /// 下拉刷新
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
