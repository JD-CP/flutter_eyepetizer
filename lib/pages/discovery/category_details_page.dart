import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter_eyepetizer/entity/category_entity.dart';
import 'package:flutter_eyepetizer/entity/issue_entity.dart';
import 'package:flutter_eyepetizer/http/http.dart';
import 'package:flutter_eyepetizer/pages/home/home_page_item.dart';
import 'package:flutter_eyepetizer/util/constant.dart';
import 'package:flutter_eyepetizer/widget/load_more_widget.dart';
import 'package:flutter_eyepetizer/widget/loading_widget.dart';

import 'category_item.dart';

/// 热门分类详情
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

  @override
  void initState() {
    super.initState();
    this.scrollController.addListener(() => {
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
      body: _dataList == null ? LoadingWidget() : renderScrollWidget(),
    );
  }

  void loadMoreData() {
    this.setState(() {
      this.isLoadingMore = true;
      this.getPageData();
    });
  }

  void getPageData() async {
    if (!this.isLoadingMore) {
      nextPageUrl = Constant.categoryDetailsUrl;
    }

    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;

    HttpUtil.doGet(
      this.nextPageUrl,
      queryParameters: {
        "id": widget.item.id,
        "udid": 'd2807c895f0348a180148c9dfa6f2feeac0781b5',
        "deviceModel": androidInfo.device,
      },
      success: (response) {
        Map map = json.decode(response.toString());
        var issueEntity = Issue.fromJson(map);
        this.nextPageUrl = issueEntity.nextPageUrl;
        setState(() {
          if (this.isLoadingMore) {
            isLoadingMore = false;
            this._dataList.addAll(issueEntity.itemList);
          } else {
            this._dataList = issueEntity.itemList;
          }
        });
      },
      fail: (exception) {},
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
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              if (index < this._dataList.length) {
                return CategoryItem(
                  item: _dataList[index],
                );
              }
              return LoadMoreWidget(
                isLoadMore: this.isLoadingMore,
              );
            },
            childCount: _dataList.length + 1,
          ),
        ),
      ],
    );
  }
}
