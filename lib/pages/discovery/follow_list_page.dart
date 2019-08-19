import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_eyepetizer/entity/category_entity.dart';
import 'package:flutter_eyepetizer/entity/follow_entity.dart';
import 'package:flutter_eyepetizer/http/http.dart';
import 'package:flutter_eyepetizer/util/constant.dart';
import 'category_item_widget.dart';
import 'follow_item_details_widget.dart';
import 'follow_item_widget.dart';

class FollowListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => FollowListPageState();
}

class FollowListPageState extends State<FollowListPage> {
  String nextPageUrl = Constant.followUrl;

  /// 表示是否正在上拉加载
  bool isLoadingMore = false;
  List<FollowItem> _followItemList = [];

  void getPageData() async {
    var dio = Dio();
    dio.interceptors.add(LogInterceptor());
    var responseFollow = await dio.get(Constant.followUrl,
        options: Options(headers: httpHeaders));

    Map map = json.decode(responseFollow.toString());
    var followEntity = FollowEntity.fromJson(map);

    this.setState(() {
      nextPageUrl = followEntity.nextPageUrl;
      if (this.isLoadingMore) {
        this.isLoadingMore = false;
        _followItemList.addAll(followEntity.itemList);
      } else {
        _followItemList = followEntity.itemList;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getPageData();
  }

  Future _onRefresh() {
    return Future(() {
      /// getHomePageData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('热门关注'),
        elevation: 0,
      ),
      body: Container(
          child: RefreshIndicator(
            child: ListView.separated(
              itemBuilder: (context, index) {
                return FollowItemDetailsWidget(item: _followItemList[index]);
              },
              separatorBuilder: (context, index) {
                return Divider(
                  height: .5,
                );
              },
              itemCount: _followItemList.length,
            ),
            onRefresh: _onRefresh,
          )),
    );
  }
}
