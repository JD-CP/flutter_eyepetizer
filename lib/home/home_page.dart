import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_eyepetizer/http/http.dart';
import '../entity/issue_entity.dart';
import 'home_page_item.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  bool isLoadingMore = false;
  List<Item> _dataList = [];

  ScrollController scrollController = ScrollController();

  Future onRefresh() {
    return Future(() {
      httpGet();
    });
  }

  void httpGet() async {
    var dio = Dio();
    dio.interceptors.add(LogInterceptor());
    var response = await dio.get(
        'http://baobab.kaiyanapp.com/api/v2/feed?num=1',
        options: Options(headers: httpHeaders));
    Map map = json.decode(response.toString());
    var issueEntity = new IssueEntity.fromJson(map);
    var list = issueEntity.issueList[0].itemList;
    list.removeWhere((item) {
      return item.type == 'banner2';
    });
    setState(() {
      _dataList = list;
    });
  }

  void loadMore() async {}

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
                this.loadMore();
              })
            }
        });
    httpGet();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        child: ListView.separated(
            controller: this.scrollController,
            itemBuilder: (context, index) {
              if (index < _dataList.length) {
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
              '努力加载中...',
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
