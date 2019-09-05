import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_eyepetizer/pages/discovery/follow/follow_list_page.dart';
import 'package:flutter_eyepetizer/provider/discovery_page_model.dart';
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
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ProviderWidget(
      model: DiscoveryPageModel(),
      onModelInitial: (model) {
        model.init();
      },
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('发现', style: TextStyle(color: Colors.black)),
            centerTitle: true,
            elevation: 0,
            backgroundColor: Colors.white,
          ),
          body: EasyRefresh.custom(
            slivers: <Widget>[
              SliverToBoxAdapter(
                child: Container(
                  child: DiscoveryPageWidget(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class DiscoveryPageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DiscoveryPageModel model = Provider.of(context);
    if (model.isInit) {
      return LoadingWidget();
    }
    return renderBodyWidget(context, model);
  }

  /// 热门分类标题
  Widget renderCategoryTitleWidget() {
    return Container(
      color: Color(0xFFF4F4F4),
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Text(
          '热门分类',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Widget renderBodyWidget(context, DiscoveryPageModel model) {
    return Container(
      color: Colors.white,
      child: CustomScrollView(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: renderFollowTitleWidget(context),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                /// 实现了每个 item 下面加一条分割线
                var i = index;
                i -= 1;
                if (i.isOdd) {
                  i = (i + 1) ~/ 2;
                  return FollowItemWidget(
                    item: model.followItemList[i],
                  );
                }
                i = i ~/ 2;
                return Divider(
                  height: .5,
                  indent: 65,
                  color: Color(0xFFDDDDDD),
                );
              },
              childCount: model.followItemList.length * 2,
            ),
          ),
          SliverToBoxAdapter(
            child: renderCategoryTitleWidget(),
          ),
          SliverPadding(
            padding: EdgeInsets.all(10),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return CategoryItemWidget(item: model.categoryList[index]);
                },
                childCount: model.categoryList.length,
              ),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                /// 设置横纵轴间距
                crossAxisCount: 4,
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 推荐关注标题
  Widget renderFollowTitleWidget(context) {
    return Container(
      padding: EdgeInsets.all(15),
      color: Color(0xFFF4F4F4),
      child: Row(
        children: <Widget>[
          Text(
            '推荐关注',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
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
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
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
}
