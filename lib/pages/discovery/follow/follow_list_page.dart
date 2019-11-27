import 'package:flutter/material.dart';
import 'package:flutter_eyepetizer/provider/follow_list_model.dart';
import 'package:flutter_eyepetizer/provider/provider_widget.dart';
import 'package:flutter_eyepetizer/widget/loading_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
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
          body: SmartRefresher(
            header: WaterDropHeader(),
            footer: ClassicFooter(
              loadStyle: LoadStyle.ShowAlways,
            ),
            enablePullUp: true,
            controller: model.refreshController,
            onRefresh: model.onRefresh,
            onLoading: model.onLoadMore,
            child: Container(
              child: FollowListWidget(),
            ),
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
        return FollowItemDetailsWidget(item: model.dataList[index]);
      },
      separatorBuilder: (context, index) {
        return Divider(
          height: .5,
        );
      },
      itemCount: model.dataList.length,
    );
  }
}
