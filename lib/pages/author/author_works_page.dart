import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_eyepetizer/entity/issue_entity.dart';
import 'package:flutter_eyepetizer/http/http.dart';
import 'package:flutter_eyepetizer/pages/author/work_item_widget.dart';
import 'package:flutter_eyepetizer/pages/home/home_page_item.dart';
import 'package:flutter_eyepetizer/widget/loading_widget.dart';
import 'package:flutter_ijkplayer/flutter_ijkplayer.dart';

class AuthorWorksPage extends StatefulWidget {
  final String apiUrl;

  AuthorWorksPage({Key key, this.apiUrl});

  @override
  State<StatefulWidget> createState() => AuthorWorksPageState();
}

class AuthorWorksPageState extends State<AuthorWorksPage>
    with AutomaticKeepAliveClientMixin {
  List<Item> itemList = [];
  List<DataSource> _list = [];

//  var map = <DataSource, IjkMediaController>{};

  @override
  void initState() {
    super.initState();
    _getPageData();
  }

  @override
  void dispose() {
    /*map.values.forEach((c) {
      c.dispose();
    });*/
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return itemList.length == 0
        ? LoadingWidget()
        : Container(
            child: ListView.separated(
              itemBuilder: (context, index) {
                return WorkItemWidget(
                  item: this.itemList[index],
                  dataSource: _list[index],
                );
              },
              separatorBuilder: (context, index) {
                return Divider(
                  height: .5,
                  color: Color(0xFFDDDDDD),

                  /// indent: 前间距, endIndent: 后间距
                  indent: 15,
                );
              },
              itemCount: this.itemList.length,
            ),
          );
  }

  void _getPageData() async {
    HttpUtil.doGet(widget.apiUrl, queryParameters: {
      "udid": 'd2807c895f0348a180148c9dfa6f2feeac0781b5',
    }, success: (response) {
      Map map = json.decode(response.toString());
      var issue = Issue.fromJson(map);
      this.setState(() {
        this.itemList = issue.itemList;
        for (var item in itemList) {
          List<PlayInfo> playInfoList = item.data.playInfo;
          if (playInfoList.length > 1) {
            for (var playInfo in playInfoList) {
              if (playInfo.type == 'high') {
                _list.add(DataSource.network(playInfo.url));
              }
            }
          }
        }
        /*for (var data in _list) {
          var controller = IjkMediaController();
          map[data] = controller;
        }*/
      });
    }, fail: (exception) {});
  }

  @override
  bool get wantKeepAlive => true;
}
