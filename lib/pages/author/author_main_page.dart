import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_eyepetizer/entity/issue_entity.dart';
import 'package:flutter_eyepetizer/http/http.dart';
import 'package:flutter_eyepetizer/pages/author/collection_card.dart';
import 'package:flutter_eyepetizer/pages/author/video_welcom_page.dart';
import 'package:flutter_eyepetizer/pages/discovery/follow/follow_item_details_widget.dart';
import 'package:flutter_eyepetizer/pages/video/video_related_page.dart';
import 'package:flutter_eyepetizer/widget/loading_widget.dart';
import 'package:flutter_eyepetizer/widget/no_data_widget.dart';

class AuthorMainPage extends StatefulWidget {
  final String apiUrl;

  AuthorMainPage({Key key, this.apiUrl});

  @override
  State<StatefulWidget> createState() => AuthorMainPageState();
}

class AuthorMainPageState extends State<AuthorMainPage>
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
        : (itemList.length == 0
            ? NoDataWidget()
            : Container(
                color: Colors.white,
                child: CustomScrollView(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  slivers: <Widget>[
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          if (this.itemList[index].type ==
                              'videoCollectionOfHorizontalScrollCard') {
                            return CollectionCard(
                              item: this.itemList[index],
                              childIndex: index,
                            );
                          } else if (this.itemList[index].type ==
                              'textHeader') {
                            return Padding(
                              padding: EdgeInsets.only(
                                left: 10,
                                bottom: 10,
                              ),
                              child: Text(
                                this.itemList[index].data.text,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            );
                          } else if (this.itemList[index].type ==
                              'textFooter') {
                            return Container(
                              alignment: Alignment.centerRight,
                              padding: EdgeInsets.all(10),
                              child: Text(
                                '${this.itemList[index].data.text}>',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.deepPurple[500],
                                ),
                              ),
                            );
                          } else if (this.itemList[index].type == 'video') {
                            return VideoWelcomePage(
                              item: this.itemList[index],
                            );
                          } else if (this.itemList[index].type ==
                              'videoCollectionWithBrief') {
                            return FollowItemDetailsWidget(
                              item: this.itemList[index],
                            );
                          }
                          return Text(this.itemList[index].type);
                        },
                        childCount: this.itemList.length,
                      ),
                    ),
                  ],
                ),
              ));
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
