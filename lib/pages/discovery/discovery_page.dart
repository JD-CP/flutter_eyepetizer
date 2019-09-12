import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_eyepetizer/pages/discovery/follow/follow_list_page.dart';
import 'package:flutter_eyepetizer/provider/discovery_follow_model.dart';
import 'package:flutter_eyepetizer/provider/discovery_category_model.dart';
import 'package:flutter_eyepetizer/provider/provider_widget.dart';
import 'package:flutter_eyepetizer/widget/loading_widget.dart';
import 'package:provider/provider.dart';

import 'category_item_widget.dart';
import 'follow_item_widget.dart';

/// 发现页
class DiscoveryPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => DiscoveryPageState();
}

class DiscoveryPageState extends State<DiscoveryPage>
    with AutomaticKeepAliveClientMixin {
  /// 推荐关注标题
  Widget renderFollowTitleWidget(context) {
    return Container(
      padding: EdgeInsets.only(left: 15, right: 15, top: 13, bottom: 5),
      child: Row(
        children: <Widget>[
          Text(
            '推荐关注',
            style: TextStyle(
              fontSize: 14,
              color: Colors.black,
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                GestureDetector(
                  child: Text(
                    '查看更多 >>',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                  onTap: () {
                    /// 跳转热门关注列表页
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FollowListPage(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ProviderWidget2<DiscoveryPageModel, DiscoveryFollowModel>(
      model1: DiscoveryPageModel(),
      model2: DiscoveryFollowModel(),
      onModelInitial: (model1, model2) {
        model1.init();
        model2.init();
      },
      builder: (context, model1, model2, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('发现', style: TextStyle(color: Colors.black)),
            centerTitle: true,
            elevation: 0,
          ),
          body: Container(
            color: Colors.white,
            child: EasyRefresh.custom(
              slivers: <Widget>[
                SliverToBoxAdapter(
                  child: Container(
                    color: Color(0xFFF4F4F4),
                    width: double.infinity,
                    height: 8,
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: 15, right: 15, top: 13, bottom: 13),
                    child: Text(
                      '热门分类',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    padding: EdgeInsets.only(left: 15, right: 15, bottom: 12),
                    child: Consumer<DiscoveryPageModel>(
                      builder: (context, model, child) {
                        return GridView.builder(
                          shrinkWrap: true,
                          itemCount: model.categoryList.length,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 5,
                            mainAxisSpacing: 5,
                            crossAxisSpacing: 5,
                          ),
                          itemBuilder: (context, index) {
                            return CategoryItemWidget(
                              item: model.categoryList[index],
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    color: Color(0xFFF4F4F4),
                    width: double.infinity,
                    height: 8,
                  ),
                ),
                SliverToBoxAdapter(
                  child: renderFollowTitleWidget(context),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    child: Consumer<DiscoveryFollowModel>(
                      builder: (context, model, child) {
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: model.followItemList.length,
                          itemBuilder: (context, index) {
                            return FollowItemWidget(
                              item: model.followItemList[index],
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
                SliverPadding(
                  padding: EdgeInsets.only(bottom: 20, top: 10),
                  sliver: SliverToBoxAdapter(
                    child: Consumer<DiscoveryFollowModel>(
                      builder: (context, model, child) {
                        return Container(
                          alignment: Alignment.center,
                          child: Container(
                            width: 70,
                            height: 35,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Color(0xFFF4F4F4),
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(2),
                            ),
                            child: InkWell(
                              onTap: () {
                                model.loadNextPage();
                              },
                              child: Text(
                                '换一换',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
//    return ProviderWidget(
//      model: DiscoveryPageModel(),
//      onModelInitial: (model) {
//        model.init();
//      },
//      builder: (context, model, child) {
//        return Scaffold(
//          appBar: AppBar(
//            title: Text('发现', style: TextStyle(color: Colors.black)),
//            centerTitle: true,
//            elevation: 0,
//            backgroundColor: Colors.white,
//          ),
//          body: EasyRefresh.custom(
//            slivers: <Widget>[
//              SliverToBoxAdapter(
//                child: Container(
//                  child: DiscoveryPageWidget(),
//                ),
//              ),
//            ],
//          ),
//        );
//      },
//    );
  }

  @override
  bool get wantKeepAlive => true;
}

class CategoryWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return null;
  }
}

//class DiscoveryPageWidget extends StatelessWidget {
//
//  /// 热门分类标题
//  Widget renderCategoryTitleWidget() {
//    return Container(
//      child: Padding(
//        padding: EdgeInsets.only(left: 15, right: 15, top: 13, bottom: 13),
//        child: Text(
//          '热门分类',
//          style: TextStyle(
//            fontSize: 14,
//            color: Colors.black,
//          ),
//        ),
//      ),
//    );
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    DiscoveryPageModel model = Provider.of(context);
//    if (model.isInit) {
//      return LoadingWidget();
//    }
//    return Container(
//      color: Colors.white,
//      child: CustomScrollView(
//        shrinkWrap: true,
//        physics: BouncingScrollPhysics(),
//        slivers: <Widget>[
//          SliverToBoxAdapter(
//            child: Container(
//              width: double.infinity,
//              height: 10,
//              color: Color(0xFFF4F4F4),
//            ),
//          ),
//          SliverToBoxAdapter(
//            child: renderCategoryTitleWidget(),
//          ),
//          SliverPadding(
//            padding: EdgeInsets.only(left: 15, right: 15, bottom: 10),
//            sliver: SliverGrid(
//              delegate: SliverChildBuilderDelegate(
//                (context, index) {
//                  print('换一换 渲染');
//                  return Padding(
//                    padding: EdgeInsets.all(0),
//                    child: CategoryItemWidget(
//                      item: model.categoryList[index],
//                    ),
//                  );
//                },
//                childCount: model.categoryList.length,
//              ),
//              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                /// 设置横纵轴间距
//                crossAxisCount: 5,
//                mainAxisSpacing: 5,
//                crossAxisSpacing: 5,
//              ),
//            ),
//          ),
//          SliverToBoxAdapter(
//            child: Container(
//              width: double.infinity,
//              height: 10,
//              color: Color(0xFFF4F4F4),
//            ),
//          ),
//          SliverToBoxAdapter(
//            child: renderFollowTitleWidget(context),
//          ),
//          SliverList(
//            delegate: SliverChildBuilderDelegate(
//              (context, index) {
//                /// 实现了每个 item 下面加一条分割线
////                var i = index;
////                i -= 1;
////                if (i.isOdd) {
////                  i = (i + 1) ~/ 2;
////                  return FollowItemWidget(
////                    item: model.followItemList[i],
////                  );
////                }
////                i = i ~/ 2;
////                return Divider(
////                  height: .5,
////                  indent: 65,
////                  color: Color(0xFFDDDDDD),
////                );
//                return FollowItemWidget(
//                  item: model.followItemList[index],
//                );
//              },
//              childCount: model.followItemList.length,
//            ),
//          ),
//          SliverPadding(
//            padding: EdgeInsets.only(bottom: 20, top: 10),
//            sliver: SliverToBoxAdapter(
//              child: Container(
//                alignment: Alignment.center,
//                child: Container(
//                  width: 70,
//                  height: 35,
//                  alignment: Alignment.center,
//                  decoration: BoxDecoration(
//                    color: Color(0xFFF4F4F4),
//                    shape: BoxShape.rectangle,
//                    borderRadius: BorderRadius.circular(2),
//                  ),
//                  child: InkWell(
//                    onTap: () {
//                      model.loadNextPage();
//                    },
//                    child: Text(
//                      '换一换',
//                      style: TextStyle(
//                        fontSize: 12,
//                        color: Colors.black,
//                      ),
//                    ),
//                  ),
//                ),
//              ),
//            ),
//          )
//        ],
//      ),
//    );
//  }
//
//  /// 热门分类标题
//  Widget renderCategoryTitleWidget() {
//    return Container(
//      child: Padding(
//        padding: EdgeInsets.only(left: 15, right: 15, top: 13, bottom: 13),
//        child: Text(
//          '热门分类',
//          style: TextStyle(
//            fontSize: 14,
//            color: Colors.black,
//          ),
//        ),
//      ),
//    );
//  }
//
//  /// 推荐关注标题
//  Widget renderFollowTitleWidget(context) {
//    return Container(
//      padding: EdgeInsets.only(left: 15, right: 15, top: 13, bottom: 13),
//      child: Row(
//        children: <Widget>[
//          Text(
//            '推荐关注',
//            style: TextStyle(
//              fontSize: 14,
//              color: Colors.black,
//            ),
//          ),
//          Expanded(
//            flex: 1,
//            child: Row(
//              mainAxisAlignment: MainAxisAlignment.end,
//              children: <Widget>[
//                GestureDetector(
//                  child: Text(
//                    '查看更多 >>',
//                    style: TextStyle(
//                      fontSize: 12,
//                      color: Colors.grey,
//                    ),
//                  ),
//                  onTap: () {
//                    /// 跳转热门关注列表页
//                    Navigator.push(
//                      context,
//                      MaterialPageRoute(
//                        builder: (context) => FollowListPage(),
//                      ),
//                    );
//                  },
//                ),
//              ],
//            ),
//          ),
//        ],
//      ),
//    );
//  }
//}
