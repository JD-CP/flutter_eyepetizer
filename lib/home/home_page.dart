import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_eyepetizer/http/http.dart';
import '../entity/issue_entity.dart';
import 'home_page_item.dart';
import 'time_title_item.dart';
import '../util/constant.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  String nextPageUrl = Constant.homePageUrl;

  /// 表示是否正在上拉加载
  bool isLoadingMore = false;
  List<Item> _dataList = [];

  ScrollController scrollController = ScrollController();

  Future onRefresh() {
    return Future(() {
      getHomePageData();
    });
  }

  void getHomePageData() async {
    if (!this.isLoadingMore) {
      nextPageUrl = Constant.homePageUrl;
    }
    var dio = Dio();
    dio.interceptors.add(LogInterceptor());
    var response =
        await dio.get(nextPageUrl, options: Options(headers: httpHeaders));
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
  }

  @override
  void initState() {
    super.initState();
    this.scrollController.addListener(() => {
          if (!this.isLoadingMore &&
              this.scrollController.position.pixels >=
                  this.scrollController.position.maxScrollExtent)
            {
              this.setState(() {
                this.isLoadingMore = true;
                this.getHomePageData();
              })
            }
        });
    getHomePageData();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        child: ListView.separated(
            controller: this.scrollController,
            itemBuilder: (context, index) {
              if (index < _dataList.length) {
                if (_dataList[index].type == 'textHeader') {
                  return TimeTitleItem(item: _dataList[index]);
                }
                return HomePageItem(item: _dataList[index]);
              }
              return renderLoadMoreView();
            },
            separatorBuilder: (context, index) {
              return Divider(
                height: .5,
                color: Color(0xFFDDDDDD),
                indent: 15,
              );
            },
            itemCount: _dataList.length + 1),
        onRefresh: this.onRefresh);
  }

  /// 上拉加载 Widget
  Widget renderLoadMoreView() {
    if (this.isLoadingMore) {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '努力加载中...  ',
              style: TextStyle(
                fontSize: 14,
                color: Colors.black54,
              ),
            ),
            SizedBox(
              width: 18,
              height: 18,
              child: CircularProgressIndicator(
                strokeWidth: 2.5,
                backgroundColor: Colors.deepPurple[600],
              ),
            )
          ],
        ),
      );
    } else {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        child: Text(
          '上拉加载更多',
          style: TextStyle(
            fontSize: 14,
            color: Colors.black54,
          ),
        ),
      );
    }
  }
}
