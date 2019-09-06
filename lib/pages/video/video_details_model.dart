import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_eyepetizer/data/entity/issue_entity.dart';
import 'package:flutter_eyepetizer/http/http.dart';
import 'package:flutter_eyepetizer/util/constant.dart';

class VideoDetailsModel extends ChangeNotifier {
  List<Item> itemList = [];

  int id;
  bool isInit;

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
  Future<List<Item>> loadData() async {
    try {
      var response = await HttpUtil.buildDio().get(
        Constant.videoRelatedUrl,
        queryParameters: {
          "id": this.id,
        },
        options: Options(
          headers: httpHeaders,
        ),
      );
      Map map = json.decode(response.toString());
      var issue = Issue.fromJson(map);
      itemList = issue.itemList;
      if (isInit) {
        initPage(false);
      }
      notifyListeners();
      return itemList;
    } catch (e, s) {
      return null;
    }
  }
}
