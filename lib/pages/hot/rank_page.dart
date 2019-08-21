import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eyepetizer/entity/issue_entity.dart';
import 'package:flutter_eyepetizer/http/http.dart';
import 'package:flutter_eyepetizer/pages/home/home_page_item.dart';
import 'package:flutter_eyepetizer/widget/loading_widget.dart';

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
  List<Item> _dataList;

  @override
  void initState() {
    super.initState();
    getRankPageData();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return _dataList == null ? LoadingWidget() : renderRefreshWidget();
  }

  /// 获取排行数据
  void getRankPageData() async {
    HttpUtil.doGet(
      widget.pageUrl,
      success: (response) {
        Map map = json.decode(response.toString());
        var issueEntity = Issue.fromJson(map);
        setState(() {
          this._dataList = issueEntity.itemList;
        });
      },
      fail: (exception) {},
    );
  }

  /// 下拉刷新
  Future _onRefresh() {
    return Future(() {
      this.getRankPageData();
    });
  }

  Widget renderRefreshWidget() {
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
        itemCount: _dataList.length,
      ),
      onRefresh: this._onRefresh,
    );
  }

  @override
  bool get wantKeepAlive => true;
}
