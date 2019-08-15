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
  List<Item> _dataList = [];

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

  @override
  void initState() {
    super.initState();
    httpGet();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        child: ListView.separated(
            itemBuilder: (context, index) {
              return HomePageItem(item: _dataList[index]);
            },
            separatorBuilder: (context, index) {
              return Divider(height: .5, color: Color(0xFFDDDDDD), indent: 15,);
            },
            itemCount: _dataList.length),
        onRefresh: this.onRefresh);
  }
}
