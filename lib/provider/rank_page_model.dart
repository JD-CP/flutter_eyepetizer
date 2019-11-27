import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_eyepetizer/data/entity/issue_entity.dart';
import 'package:flutter_eyepetizer/http/http.dart';
import 'package:flutter_eyepetizer/provider/refresh_loadmore_model.dart';
import 'package:flutter_eyepetizer/util/logger_util.dart';

class RankPageModel extends RefreshLoadMoreModel {
  final String pageUrl;

  RankPageModel(this.pageUrl);

  @override
  Future<List> loadData() async {
    LoggerUtil.instance().d("RankPageModel start http ---> $pageUrl");
    var response = await HttpUtil.buildDio().get(
      pageUrl,
      options: Options(
        headers: httpHeaders,
      ),
    );
    Map map = json.decode(response.toString());
    var issueEntity = Issue.fromJson(map);
    var itemList = issueEntity.itemList;
    LoggerUtil.instance().v("RankPageModel http success ---> ${map.toString()}");
    return itemList;
  }

  @override
  Future<List> onRefresh() {
    return loadRemoteData();
  }

  @override
  Future<List> onLoadMore() {
    return null;
  }

}
