import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_eyepetizer/data/entity/issue_entity.dart';
import 'package:flutter_eyepetizer/http/http.dart';
import 'package:flutter_ijkplayer/flutter_ijkplayer.dart';

class AuthorWorksModel extends ChangeNotifier {
  List<Item> itemList = [];
  List<DataSource> list = [];

  bool isInit;
  String url;

  /// 初始化
  init(apiUrl) async {
    this.url = apiUrl;
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
        url,
        queryParameters: {
          "udid": 'd2807c895f0348a180148c9dfa6f2feeac0781b5',
        },
        options: Options(
          headers: httpHeaders,
        ),
      );
      Map map = json.decode(response.toString());
      var issue = Issue.fromJson(map);
      this.itemList = issue.itemList;
      for (var item in itemList) {
        List<PlayInfo> playInfoList = item.data.playInfo;
        if (playInfoList.length > 1) {
          for (var playInfo in playInfoList) {
            if (playInfo.type == 'high') {
              list.add(DataSource.network(playInfo.url));
            }
          }
        }
      }
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
