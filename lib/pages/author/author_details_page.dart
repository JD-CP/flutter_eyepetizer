import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_eyepetizer/entity/author_info_entity.dart';
import 'package:flutter_eyepetizer/entity/issue_entity.dart';
import 'package:flutter_eyepetizer/http/http.dart';
import 'package:flutter_eyepetizer/pages/author/author_works_page.dart';
import 'package:flutter_eyepetizer/util/constant.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_eyepetizer/widget/loading_widget.dart';

import 'author_issue_page.dart';
import 'author_main_page.dart';

class AuthorDetailsPage extends StatelessWidget {
  final Item item;

  AuthorDetailsPage({Key key, this.item});

  @override
  Widget build(BuildContext context) => AuthorInfoPage(item: item);
}

class AuthorInfoPage extends StatefulWidget {
  final Item item;

  AuthorInfoPage({Key key, this.item});

  @override
  State<StatefulWidget> createState() => AuthorInfoState();
}

class AuthorInfoState extends State<AuthorInfoPage>
    with SingleTickerProviderStateMixin {
  List<TabItem> tabItems = [];
  List<Widget> pages = [];

  @override
  void initState() {
    super.initState();
    _getPageData();
  }

  @override
  Widget build(BuildContext context) {
    return tabItems.length == 0
        ? LoadingWidget()
        : Scaffold(
            appBar: AppBar(
              title: Text(
                widget.item.data.author == null
                    ? widget.item.data.header.title
                    : widget.item.data.author.name,
              ),
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
                      children: pages,
                    ),
                  ),
                ],
              ),
            ),
          );
  }

  void _getPageData() async {
    HttpUtil.doGet(
      Constant.authorUrl,
      queryParameters: {
        'id': widget.item.data.author == null
            ? widget.item.data.header.id
            : widget.item.data.author.id,
        "udid": 'd2807c895f0348a180148c9dfa6f2feeac0781b5',
      },
      success: (response) {
        Map map = json.decode(response.toString());
        var authorInfoEntity = AuthorInfoEntity.fromJson(map);
        var tabItemList = authorInfoEntity.tabInfo.tabList;
        this.setState(() {
          this.tabItems = tabItemList;
          if (tabItemList.length == 2) {
            pages = [
              AuthorMainPage(
                apiUrl: tabItemList[0].apiUrl,
              ),
              AuthorWorksPage(
                apiUrl: tabItemList[1].apiUrl,
              )
            ];
          } else if (tabItemList.length == 3) {
            pages = [
              AuthorMainPage(
                apiUrl: tabItemList[0].apiUrl,
              ),
              AuthorWorksPage(
                apiUrl: tabItemList[1].apiUrl,
              ),
              AuthorIssuePage(
                apiUrl: tabItemList[2].apiUrl,
              )
            ];
          }
        });
      },
      fail: (exception) {},
    );
  }
}

class StickyTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar child;

  StickyTabBarDelegate({@required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return this.child;
  }

  @override
  double get maxExtent => this.child.preferredSize.height;

  @override
  double get minExtent => this.child.preferredSize.height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
