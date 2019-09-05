import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_eyepetizer/provider/follow_list_model.dart';
import 'package:flutter_eyepetizer/provider/provider_widget.dart';
import 'package:flutter_eyepetizer/widget/loading_widget.dart';
import 'package:flutter_eyepetizer/widget/refresh/load_more_footer.dart';
import 'package:flutter_eyepetizer/widget/refresh/refresh_header.dart';
import 'package:provider/provider.dart';

import 'follow_item_details_widget.dart';

/// 推荐关注更多页
class FollowListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => FollowListPageState();
}

class FollowListPageState extends State<FollowListPage> {
  @override
  Widget build(BuildContext context) {
    return ProviderWidget<FollowListModel>(
      model: FollowListModel(),
      onModelInitial: (model) {
        model.init();
      },
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text('热门关注'),
            elevation: 0,
          ),
          body: EasyRefresh.custom(
            enableControlFinishRefresh: true,
            enableControlFinishLoad: true,
            taskIndependence: true,
            header: MyClassicalHeader(enableInfiniteRefresh: false),
            footer: MyClassicalFooter(enableInfiniteLoad: false),
            controller: model.controller,
            scrollController: model.scrollController,
            onRefresh: model.onRefresh,
            onLoad: model.onLoadMore,
            slivers: <Widget>[
              SliverToBoxAdapter(
                child: Container(
                  child: FollowListWidget(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class FollowListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FollowListModel model = Provider.of(context);
    if (model.isInit) {
      return LoadingWidget();
    }
    return ListView.separated(
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return FollowItemDetailsWidget(item: model.itemList[index]);
      },
      separatorBuilder: (context, index) {
        return Divider(
          height: .5,
        );
      },
      itemCount: model.itemList.length,
    );
  }
}
