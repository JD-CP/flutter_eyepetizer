import 'dart:convert';

import 'package:flutter_eyepetizer/data/entity/issue_entity.dart';
import 'package:flutter_eyepetizer/data/remote_repository.dart';
import 'package:flutter_eyepetizer/provider/refresh_loadmore_model.dart';
import 'package:flutter_eyepetizer/util/constant.dart';

class CategoryListModel<Item> extends RefreshLoadMoreModel {

  final int id;

  CategoryListModel(this.id);

  @override
  Future<List> loadData() async {
    var response = await Repository.getCategoryList(
        isRefresh ? Constant.categoryDetailsUrl : nextPageUrl, id);
    Map map = json.decode(response.toString());
    var issueEntity = Issue.fromJson(map);
    nextPageUrl = issueEntity.nextPageUrl;
    var list = issueEntity.itemList;
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

}
