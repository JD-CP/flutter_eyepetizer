import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_eyepetizer/entity/follow_entity.dart';
import 'package:flutter_eyepetizer/http/http.dart';
import 'package:flutter_eyepetizer/util/constant.dart';
import 'follow_item_details_widget.dart';

class FollowListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => FollowListPageState();
}

class FollowListPageState extends State<FollowListPage> {
  String nextPageUrl = Constant.followUrl;

  /// 表示是否正在上拉加载
  bool isLoadingMore = false;
  List<FollowItem> _followItemList = [];

  ScrollController scrollController = ScrollController();

  void getPageData() async {
    if (!isLoadingMore) {
      nextPageUrl = Constant.followUrl;
    }
    var dio = Dio();
    dio.interceptors.add(LogInterceptor());
    var responseFollow =
        await dio.get(this.nextPageUrl, options: Options(headers: httpHeaders));

    Map map = json.decode(responseFollow.toString());
    var followEntity = FollowEntity.fromJson(map);
    this.nextPageUrl = followEntity.nextPageUrl;

    this.setState(() {
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
    scrollController.addListener(() {
      if (!isLoadingMore &&
          scrollController.position.pixels >=
              scrollController.position.maxScrollExtent) {
        this.setState(() {
          this.isLoadingMore = true;
          this.getPageData();
        });
      }
    });
    getPageData();
  }

  Future _onRefresh() {
    return Future(() {
      getPageData();
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
          controller: this.scrollController,
          itemBuilder: (context, index) {
            if (index < this._followItemList.length) {
              return FollowItemDetailsWidget(item: _followItemList[index]);
            }
            return renderLoadMoreView();
          },
          separatorBuilder: (context, index) {
            return Divider(
              height: .5,
            );
          },
          itemCount: _followItemList.length + 1,
        ),
        onRefresh: _onRefresh,
      )),
    );
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
