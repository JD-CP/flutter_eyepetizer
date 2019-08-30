import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_eyepetizer/entity/issue_entity.dart';
import 'package:flutter_eyepetizer/http/http.dart';
import 'package:flutter_eyepetizer/pages/author/issue_item_widget.dart';
import 'package:flutter_eyepetizer/widget/loading_widget.dart';

class AuthorIssuePage extends StatefulWidget {
  final String apiUrl;

  AuthorIssuePage({Key key, this.apiUrl});

  @override
  State<StatefulWidget> createState() => AuthorIssuePageState();
}

class AuthorIssuePageState extends State<AuthorIssuePage>
    with AutomaticKeepAliveClientMixin {
  List<Item> itemList;

  @override
  void initState() {
    super.initState();
    _getPageData();
  }

  @override
  Widget build(BuildContext context) {
    return null == itemList
        ? LoadingWidget()
        : Container(
            child: ListView.separated(
              itemBuilder: (context, index) {
                return IssueItemWidget(
                  item: itemList[index],
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
              itemCount: itemList.length,
            ),
          );
  }

  void _getPageData() async {
    HttpUtil.doGet(widget.apiUrl, success: (response) {
      Map map = json.decode(response.toString());
      var issue = Issue.fromJson(map);
      this.setState(() {
        this.itemList = issue.itemList;
      });
    }, fail: (exception) {});
  }

  @override
  bool get wantKeepAlive => true;
}
