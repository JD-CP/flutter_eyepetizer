import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_eyepetizer/entity/issue_entity.dart';
import 'package:flutter_eyepetizer/http/http.dart';
import 'package:flutter_eyepetizer/util/constant.dart';
import 'package:flutter_eyepetizer/widget/load_more_widget.dart';
import 'package:flutter_eyepetizer/widget/loading_widget.dart';
import 'follow_item_details_widget.dart';

class FollowListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => FollowListPageState();
}

class FollowListPageState extends State<FollowListPage> {
  String nextPageUrl = Constant.followUrl;

  /// 表示是否正在上拉加载
  bool isLoadingMore = false;
  List<Item> _followItemList;

  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (!isLoadingMore &&
          scrollController.position.pixels >=
              scrollController.position.maxScrollExtent) {
        _loadMoreData();
      }
    });
    getPageData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('热门关注'),
        elevation: 0,
      ),
      body: _followItemList == null ? LoadingWidget() : renderRefreshWidget(),
    );
  }

  /// 下拉刷新
  Future _onRefresh() {
    return Future(() {
      getPageData();
    });
  }

  /// 上拉加载
  void _loadMoreData() {
    this.setState(() {
      this.isLoadingMore = true;
      this.getPageData();
    });
  }

  /// 获取列表数据
  void getPageData() async {
    if (!isLoadingMore) {
      nextPageUrl = Constant.followUrl;
    }

    HttpUtil.doGet(
      this.nextPageUrl,
      success: (response) {
        Map map = json.decode(response.toString());
        var followEntity = Issue.fromJson(map);
        this.nextPageUrl = followEntity.nextPageUrl;

        this.setState(() {
          if (this.isLoadingMore) {
            this.isLoadingMore = false;
            _followItemList.addAll(followEntity.itemList);
          } else {
            _followItemList = followEntity.itemList;
          }
        });
      },
      fail: (exception) {},
    );
  }

  Widget renderRefreshWidget() {
    return RefreshIndicator(
      child: ListView.separated(
        controller: this.scrollController,
        itemBuilder: (context, index) {
          if (index < this._followItemList.length) {
            return FollowItemDetailsWidget(item: _followItemList[index]);
          }
          return LoadMoreWidget(isLoadMore: this.isLoadingMore);
        },
        separatorBuilder: (context, index) {
          return Divider(
            height: .5,
          );
        },
        itemCount: _followItemList.length + 1,
      ),
      onRefresh: _onRefresh,
    );
  }
}
