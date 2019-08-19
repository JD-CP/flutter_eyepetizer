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
  List<Item> _dataList = [];
  String nextPageUrl;

  void getPageData() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;

    var dio = Dio();
    dio.interceptors.add(LogInterceptor());
    var response = await dio.get(
      Constant.categoryDetailsUrl,
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
      this._dataList = issueEntity.itemList;
      this.nextPageUrl = issueEntity.nextPageUrl;
    });
  }

  @override
  void initState() {
    super.initState();
    getPageData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
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
              return CategoryItem(
                item: _dataList[index],
              );
            }, childCount: _dataList.length),
          ),
        ],
      ),
    );
  }
}
