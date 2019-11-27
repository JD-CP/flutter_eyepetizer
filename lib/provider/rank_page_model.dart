import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_eyepetizer/data/entity/issue_entity.dart';
import 'package:flutter_eyepetizer/http/http.dart';
import 'package:flutter_eyepetizer/provider/refresh_loadmore_model.dart';

class RankPageModel extends RefreshLoadMoreModel {
  final String pageUrl;

  RankPageModel(this.pageUrl);

  @override
  Future<List> loadData() async {
    var response = await HttpUtil.buildDio().get(
      pageUrl,
      options: Options(
        headers: httpHeaders,
      ),
    );
    Map map = json.decode(response.toString());
    var issueEntity = Issue.fromJson(map);
    var itemList = issueEntity.itemList;
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
