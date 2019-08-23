import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eyepetizer/entity/tab_info_entity.dart';
import 'package:flutter_eyepetizer/http/http.dart';
import 'package:flutter_eyepetizer/util/constant.dart';
import 'rank_page.dart';

/// 热门
class HotPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HotPageState();
}

class HotPageState extends State<HotPage> with SingleTickerProviderStateMixin {
  List<TabInfoItem> tabItems = [];

  List<Widget> tabPages = [];

  @override
  void initState() {
    super.initState();
    getRankList();
  }

  void getRankList() async {
    HttpUtil.doGet(
      Constant.rankListUrl,
      success: (response) {
        Map map = json.decode(response.toString());
        var tabInfoEntity = TabInfoEntity.fromJson(map);
        setState(() {
          this.tabItems = tabInfoEntity.tabInfo.tabList;
          this.tabPages = this
              .tabItems
              .map((tabInfoItem) => RankPage(pageUrl: tabInfoItem.apiUrl))
              .toList();
        });
      },
      fail: (exception) {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('每日精选', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        elevation: 0,
      ),
      body: DefaultTabController(
        length: this.tabItems.length,
        child: Column(
          children: <Widget>[
            Material(
              color: Colors.white,
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: TabBar(
                  tabs: this
                      .tabItems
                      .map((tabItem) => Tab(
                            text: tabItem.name,
                          ))
                      .toList(),
                  indicatorColor: Colors.black87,
                  indicatorSize: TabBarIndicatorSize.label,
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                children: tabPages,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
