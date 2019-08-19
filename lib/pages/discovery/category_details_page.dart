import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter_eyepetizer/entity/category_entity.dart';
import 'package:flutter_eyepetizer/entity/issue_entity.dart';
import 'package:flutter_eyepetizer/http/http.dart';
import 'package:flutter_eyepetizer/pages/home/home_page_item.dart';
import 'package:flutter_eyepetizer/util/constant.dart';

import 'category_item.dart';

class CategoryDetailsPage extends StatefulWidget {
  final CategoryEntity item;

  CategoryDetailsPage({Key key, this.item}) : super(key: key);

  @override
  State<StatefulWidget> createState() => CategoryDetailsPageState();
}

class CategoryDetailsPageState extends State<CategoryDetailsPage> {
  List<Item> _dataList;
  String nextPageUrl = Constant.categoryDetailsUrl;

  /// 表示是否正在上拉加载
  bool isLoadingMore = false;

  ScrollController scrollController = ScrollController();

  void getPageData() async {
    if (!this.isLoadingMore) {
      nextPageUrl = Constant.categoryDetailsUrl;
    }

    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;

    var dio = Dio();
    dio.interceptors.add(LogInterceptor());
    var response = await dio.get(
      nextPageUrl,
      queryParameters: {
        "id": widget.item.id,
        "udid": 'd2807c895f0348a180148c9dfa6f2feeac0781b5',
        "deviceModel": 'PIC-AL00'
      },
      options: Options(headers: httpHeaders),
    );
    Map map = json.decode(response.toString());
    var issueEntity = Issue.fromJson(map);
    setState(() {
      if (this.isLoadingMore) {
        isLoadingMore = false;
        this._dataList.addAll(issueEntity.itemList);
      } else {
        this._dataList = issueEntity.itemList;
      }
      this.nextPageUrl = issueEntity.nextPageUrl;
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
                this.getPageData();
              })
            }
        });
    getPageData();
  }

  Widget renderLoadingWidget() {
    return Center(
      child: CircularProgressIndicator(
        strokeWidth: 2.5,
        backgroundColor: Colors.deepPurple[600],
      ),
    );
  }

  Widget renderScrollWidget() {
    return CustomScrollView(
      controller: this.scrollController,
      slivers: <Widget>[
        SliverAppBar(
          pinned: true,
          elevation: 0,
          expandedHeight: 225,
          flexibleSpace: FlexibleSpaceBar(
            title: Text(widget.item.name),
            background: Image.network(
              widget.item.bgPicture,
              fit: BoxFit.cover,
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            if (index < this._dataList.length) {
              return CategoryItem(
                item: _dataList[index],
              );
            }
            return renderLoadMoreView();
          }, childCount: _dataList.length + 1),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _dataList == null ? renderLoadingWidget() : renderScrollWidget(),
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
