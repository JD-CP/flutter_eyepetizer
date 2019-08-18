import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eyepetizer/entity/issue_entity.dart';
import 'package:flutter_eyepetizer/http/http.dart';
import 'package:flutter_eyepetizer/pages/home/home_page_item.dart';

class RankPage extends StatelessWidget {
  final String pageUrl;

  RankPage({Key key, this.pageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) => RankPageWidget(pageUrl: this.pageUrl);
}

class RankPageWidget extends StatefulWidget {
  final String pageUrl;

  RankPageWidget({Key key, this.pageUrl}) : super(key: key);

  @override
  State<StatefulWidget> createState() => RankPageState();
}

class RankPageState extends State<RankPageWidget>
    with AutomaticKeepAliveClientMixin {
  List<Item> _dataList = [];

  void getRankPageData() async {
    var dio = Dio();
    dio.interceptors.add(LogInterceptor());
    var response =
        await dio.get(widget.pageUrl, options: Options(headers: httpHeaders));
    Map map = json.decode(response.toString());
    var issueEntity = Issue.fromJson(map);
    setState(() {
      this._dataList = issueEntity.itemList;
    });
  }

  Future _onRefresh() {
    return Future(() {
      this.getRankPageData();
    });
  }

  @override
  void initState() {
    super.initState();
    getRankPageData();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshIndicator(
      child: ListView.separated(
          itemBuilder: (context, index) {
            return HomePageItem(item: _dataList[index]);
          },
          separatorBuilder: (context, index) {
            return Divider(
              height: .5,
              color: Color(0xFFDDDDDD),
              indent: 15,
            );
          },
          itemCount: _dataList.length),
      onRefresh: this._onRefresh,
    );
  }

  @override
  bool get wantKeepAlive => true;
}
