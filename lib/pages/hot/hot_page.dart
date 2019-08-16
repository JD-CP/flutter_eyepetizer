import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_eyepetizer/entity/issue_entity.dart';
import 'package:flutter_eyepetizer/http/http.dart';
import 'package:flutter_eyepetizer/util/constant.dart';

import 'month_rank_page.dart';

class HotPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HotPageState();
}

class HotPageState extends State<HotPage> with SingleTickerProviderStateMixin {
  TabController _tabController;

  List<String> tabs = ['周排行', '月排行', '年排行'];

  List<Widget> tabPages = [MonthRankPage(), MonthRankPage(), MonthRankPage()];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('每日精选', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        elevation: 0,
        bottom: TabBar(
          labelColor: Colors.black87,
          unselectedLabelColor: Colors.black54,
          controller: _tabController,
          indicatorColor: Colors.deepPurple,
          indicatorSize: TabBarIndicatorSize.label,
          tabs: tabs.map((e) => Tab(text: e)).toList(),
        ),
      ),
      body: TabBarView(
        children: tabPages,
        controller: _tabController,
      ),
    );
  }
}
