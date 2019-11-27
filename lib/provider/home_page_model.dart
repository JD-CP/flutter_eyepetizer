import 'dart:convert';
import 'package:flutter_eyepetizer/data/entity/issue_entity.dart';
import 'package:flutter_eyepetizer/data/remote_repository.dart';
import 'package:flutter_eyepetizer/provider/refresh_loadmore_model.dart';
import 'package:flutter_eyepetizer/util/constant.dart';
import 'package:flutter_eyepetizer/util/logger_util.dart';

class HomePageModel<Item> extends RefreshLoadMoreModel {

  @override
  Future<List> loadData() async {
    LoggerUtil.instance().d("HomePageModel start http ---> ${isRefresh ? Constant.homePageUrl : nextPageUrl}");
    var response = await Repository.getHomePageList(
        isRefresh ? Constant.homePageUrl : nextPageUrl);
    Map map = json.decode(response.toString());
    var issueEntity = IssueEntity.fromJson(map);
    nextPageUrl = issueEntity.nextPageUrl;
    var list = issueEntity.issueList[0].itemList;
    list.removeWhere((item) {
      return item.type == 'banner2';
    });
    LoggerUtil.instance().v("HomePageModel http success ---> ${map.toString()}");
    return list;
  }

  @override
  Future<List> onRefresh() {
    isRefresh = true;
    return loadRemoteData();
  }

  @override
  Future<List> onLoadMore() {
    isRefresh = false;
    return loadRemoteData();
  }

  /*Future<List<Item>> loadBanner() async {
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
  }*/

}
