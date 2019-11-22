import 'dart:ui';
import 'package:flutter/material.dart' hide NestedScrollView;
import 'package:flutter_eyepetizer/data/entity/issue_entity.dart';
import 'package:flutter_eyepetizer/provider/author_details_model.dart';
import 'package:flutter_eyepetizer/provider/provider_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_eyepetizer/util/fluro_convert_util.dart';
import 'package:flutter_eyepetizer/widget/extended_nested_scroll_view.dart';
import 'package:flutter_eyepetizer/widget/loading_widget.dart';

class AuthorDetailsPage extends StatefulWidget {
  final String itemJson;

  AuthorDetailsPage({Key key, this.itemJson});

  @override
  State<StatefulWidget> createState() => AuthorDetailsPageState();
}

class AuthorDetailsPageState extends State<AuthorDetailsPage>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    Item item = Item.fromJson(FluroConvertUtils.string2map(widget.itemJson));

    return ProviderWidget<AuthorDetailsModel>(
      model: AuthorDetailsModel(vsync: this),
      onModelInitial: (model) {
        model.init(
          item.data.author == null ? item.data.header.id : item.data.author.id,
        );
      },
      builder: (context, model, child) {
        var data = item.data;
        if (model.isInit) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                data.author == null ? data.header.title : data.author.name,
              ),
            ),
            body: Center(
              child: LoadingWidget(),
            ),
          );
        }

        final double statusBarHeight = MediaQuery.of(context).padding.top;
        var primaryTabBar = new TabBar(
          controller: model.tabController,
          indicatorColor: Colors.black87,
          indicatorSize: TabBarIndicatorSize.label,
          tabs:
              model.tabItems.map((tabItem) => Tab(text: tabItem.name)).toList(),
        );
        var pinnedHeaderHeight = statusBarHeight + kToolbarHeight;
        return Scaffold(
          body: NestedScrollView(
            headerSliverBuilder: (c, f) {
              return <Widget>[
                SliverAppBar(
                  floating: false,
                  pinned: true,
                  elevation: 0,
                  expandedHeight: 200,
                  title: Text(
                    data.author == null ? data.header.title : data.author.name,
                  ),
                  flexibleSpace: FlexibleSpaceBar(
                    background: SafeArea(
                      child: Container(
                        decoration: model.info.cover != null
                            ? BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: CachedNetworkImageProvider(
                                    model.info.cover,
                                  ),
                                ),
                              )
                            : BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage("images/bg_title.png"),
                                ),
                              ),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 0.0, sigmaY: 0.0),
                          child: Column(
                            children: <Widget>[
                              Container(
                                width: double.infinity,
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.only(
                                  left: 10,
                                  right: 10,
                                  top: kToolbarHeight,
                                ),
                                child: Row(
                                  children: <Widget>[
                                    ClipOval(
                                      child: Image.network(
                                        data.author == null
                                            ? data.header.icon
                                            : data.author.icon,
                                        width: 45,
                                        height: 45,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            model.info.description,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.white,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            model.info.brief,
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.white70,
                                            ),
                                          ),
                                        ],
                                      ),
                                      flex: 1,
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  children: <Widget>[],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(bottom: 10),
                                padding: EdgeInsets.only(
                                  top: 10,
                                  bottom: 10,
                                ),
                                width: double.infinity,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          '${model.info.videoCount}',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 6,
                                        ),
                                        Text(
                                          '作品',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          '${model.info.followCount}',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 6,
                                        ),
                                        Text(
                                          '关注',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          '${model.info.myFollowCount}',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 6,
                                        ),
                                        Text(
                                          '粉丝',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ];
            },
            pinnedHeaderSliverHeightBuilder: () {
              return pinnedHeaderHeight;
            },
            body: Column(
              children: <Widget>[
                primaryTabBar,
                Expanded(
                  child: TabBarView(
                    controller: model.tabController,
                    children: model.pages,
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
