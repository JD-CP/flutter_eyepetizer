import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_eyepetizer/data/entity/issue_entity.dart';
import 'package:flutter_eyepetizer/data/eyepetizer_repository.dart';
import 'package:flutter_eyepetizer/util/constant.dart';

class HomePageModel extends ChangeNotifier {
  EasyRefreshController controller = EasyRefreshController();
  ScrollController scrollController = ScrollController();

  String nextPageUrl;
  bool isRefresh = true;
  List<Item> itemList = [];
  List<Item> bannerList = [];

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

  Future<List<Item>> loadBanner() async {
    try {
      var response = await EptRepository.getHomePageList(Constant.homePageUrl);
      Map map = json.decode(response.toString());
      var issueEntity = IssueEntity.fromJson(map);
      nextPageUrl = issueEntity.nextPageUrl;
      await loadData(url: nextPageUrl);
      var list = issueEntity.issueList[0].itemList;
      list.removeWhere((item) {
        return item.type == 'banner2';
      });
      bannerList.clear();
      bannerList.addAll(list);
      return bannerList;
    } catch (e, s) {
      return null;
    }
  }

  /// 加载数据
  Future<List<Item>> loadData({String url}) async {
    try {
      var response = await EptRepository.getHomePageList(url);
      Map map = json.decode(response.toString());
      var issueEntity = IssueEntity.fromJson(map);
      nextPageUrl = issueEntity.nextPageUrl;
      var list = issueEntity.issueList[0].itemList;
      list.removeWhere((item) {
        return item.type == 'banner2';
      });
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
    return await loadData(url: Constant.homePageUrl);
  }

  /// 上拉加载
  Future<List<Item>> onLoadMore() async {
    isRefresh = false;
    return await loadData(url: nextPageUrl);
  }
}
