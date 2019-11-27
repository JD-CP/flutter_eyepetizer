import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter_eyepetizer/provider/discovery_follow_model.dart';
import 'package:flutter_eyepetizer/provider/discovery_category_model.dart';
import 'package:flutter_eyepetizer/provider/provider_widget.dart';
import 'package:flutter_eyepetizer/router/router_manager.dart';
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
            title: Text(
              '发现',
              style: TextStyle(color: Colors.black),
            ),
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
                      left: 15,
                      right: 15,
                      top: 13,
                      bottom: 13,
                    ),
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
                    padding: EdgeInsets.only(
                      left: 15,
                      right: 15,
                      bottom: 12,
                    ),
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
                        return Container(
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: model.followItemList.length,
                            itemBuilder: (context, index) {
                              return FollowItemWidget(
                                item: model.followItemList[index],
                              );
                            },
                          ),
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
  }

  @override
  bool get wantKeepAlive => true;

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
                    RouterManager.router.navigateTo(
                      context,
                      RouterManager.follow,
                      transition: TransitionType.inFromRight,
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
}
