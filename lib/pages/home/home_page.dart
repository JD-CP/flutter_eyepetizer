import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eyepetizer/entity/issue_entity.dart';
import 'package:flutter_eyepetizer/http/http.dart';
import 'package:flutter_eyepetizer/pages/search/search_page.dart';
import 'package:flutter_eyepetizer/util/constant.dart';
import 'package:flutter_eyepetizer/widget/load_more_widget.dart';
import 'package:flutter_eyepetizer/widget/loading_widget.dart';
import 'home_page_item.dart';
import 'time_title_item.dart';

/// 每日精选
class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  /// 下一页的请求地址
  String nextPageUrl = Constant.homePageUrl;

  /// 表示是否正在上拉加载
  bool isLoadingMore = false;
  List<Item> _dataList;

  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    /// 判断是否需要上拉加载
    this.scrollController.addListener(() =>
    {
      if (!this.isLoadingMore &&
          this.scrollController.position.pixels >=
              this.scrollController.position.maxScrollExtent)
        {this.loadMoreData()}
    });
    getPageData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      /// TODO 自己封装实现 AppBar
      appBar: AppBar(
        title: Text('每日精选', style: TextStyle(color: Colors.black)),
        centerTitle: true,

        /// 去除阴影
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.black87,
            ),
            onPressed: () {
              showSearch(context: context, delegate: SearchBarDelegate());
            },
          ),
        ],
      ),
      body: _dataList == null ? LoadingWidget() : renderRefreshWidget(),
    );
  }

  /// 构造下拉刷新 ListView
  Widget renderRefreshWidget() {
    return RefreshIndicator(
      child: ListView.separated(
          controller: this.scrollController,
          itemBuilder: (context, index) {
            if (index < _dataList.length) {
              if (_dataList[index].type == 'textHeader') {
                return TimeTitleItem(timeTitle: _dataList[index].data.text);
              }
              return HomePageItem(item: _dataList[index]);
            }
            return LoadMoreWidget(isLoadMore: this.isLoadingMore);
          },

          /// 构造分割线
          separatorBuilder: (context, index) {
            return Divider(
              height: .5,
              color: Color(0xFFDDDDDD),

              /// indent: 前间距, endIndent: 后间距
              indent: 15,
            );
          },
          itemCount: _dataList.length + 1),
      onRefresh: this.onRefresh,
    );
  }

  /// 下拉刷新
  Future onRefresh() {
    return Future(() {
      getPageData();
    });
  }

  /// 上拉加载
  void loadMoreData() {
    setState(() {
      this.isLoadingMore = true;
    });
    getPageData();
  }

  /// 异步获取数据
  void getPageData() async {
    if (!this.isLoadingMore) {
      nextPageUrl = Constant.homePageUrl;
    }

    HttpUtil.doGet(nextPageUrl, success: (response) {
      Map map = json.decode(response.toString());
      var issueEntity = IssueEntity.fromJson(map);
      this.nextPageUrl = issueEntity.nextPageUrl;
      var list = issueEntity.issueList[0].itemList;
      list.removeWhere((item) {
        return item.type == 'banner2';
      });

      /// 上拉加载，下拉刷新逻辑处理
      setState(() {
        if (this.isLoadingMore) {
          this.isLoadingMore = false;
          _dataList.addAll(list);
        } else {
          _dataList = list;
        }
      });
    }, fail: (exception) {
      /// TODO 需要进一步细分异常
    });
  }
}
