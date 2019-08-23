import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_eyepetizer/entity/author_info_entity.dart';
import 'package:flutter_eyepetizer/entity/issue_entity.dart';
import 'package:flutter_eyepetizer/http/http.dart';
import 'package:flutter_eyepetizer/util/constant.dart';
import 'package:cached_network_image/cached_network_image.dart';

class AuthorDetailsPage extends StatelessWidget {
  final Item item;

  AuthorDetailsPage({Key key, this.item});

  @override
  Widget build(BuildContext context) => AuthorInfoPage(
        item: item,
      );
}

class AuthorInfoPage extends StatefulWidget {
  final Item item;

  AuthorInfoPage({Key key, this.item});

  @override
  State<StatefulWidget> createState() => AuthorInfoState();
}

class AuthorInfoState extends State<AuthorInfoPage>
    with SingleTickerProviderStateMixin {
  TabController tabController;

  @override
  void initState() {
    super.initState();
    this.tabController = TabController(length: 2, vsync: this);
    this.tabController.addListener(() {
      print(tabController.offset);
    });
    _getPageData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        title: Text('作者信息'),
      ),*/
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            elevation: 0,
            expandedHeight: 200,
            title: Text('作者信息'),
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                widget.item.data.cover.feed,
                fit: BoxFit.cover,
              ),
            ),
            /*bottom: PreferredSize(
              child: Container(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    CachedNetworkImage(
                      imageUrl: widget.item.data.author.icon,
                      width: 50,
                      height: 50,
                    ),
                  ],
                ),
              ),
              preferredSize: Size.fromHeight(0),
            ),*/
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: StickyTabBarDelegate(
              child: TabBar(
                labelColor: Colors.black,
                controller: this.tabController,
                tabs: <Widget>[
                  Tab(text: 'Home'),
                  Tab(text: 'Profile'),
                ],
              ),
            ),
          ),
          SliverFillRemaining(
            child: TabBarView(
              controller: this.tabController,
              children: <Widget>[
                Center(child: Text('Content of Home')),
                Center(child: Text('Content of Profile')),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _getPageData() async {
    HttpUtil.doGet(
      Constant.authorUrl,
      queryParameters: {'id': widget.item.data.author.id},
      success: (response) {
        Map map = json.decode(response.toString());
        var authorInfoEntity = AuthorInfoEntity.fromJson(map);
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
