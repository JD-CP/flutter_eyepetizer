import 'package:flutter/material.dart';
import 'package:flutter_eyepetizer/pages/home/home_page_item.dart';
import 'package:flutter_eyepetizer/provider/rank_page_model.dart';
import 'package:flutter_eyepetizer/provider/provider_widget.dart';
import 'package:flutter_eyepetizer/widget/loading_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:provider/provider.dart';

/// 热门排行
class RankPage extends StatefulWidget {
  final String pageUrl;

  RankPage({Key key, this.pageUrl}) : super(key: key);

  @override
  State<StatefulWidget> createState() => RankPageState();
}

class RankPageState extends State<RankPage> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ProviderWidget<RankPageModel>(
      model: RankPageModel(widget.pageUrl),
      onModelInitial: (model) {
        model.init();
      },
      builder: (context, model, child) {
        return Container(
          color: Color(0xFFF4F4F4),
          child: RefreshConfiguration(
            enableLoadingWhenNoData: false,
            child: SmartRefresher(
              header: WaterDropHeader(),
              footer: ClassicFooter(
                height: 50,
                textStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
                noDataText: "——— 我是有底线的 ———",
              ),
              enablePullUp: true,
              controller: model.refreshController,
              onRefresh: model.onRefresh,
              child: Container(
                child: RankPageWidget(),
              ),
            ),
          ) /*EasyRefresh.custom(
            enableControlFinishRefresh: true,
            header: MyClassicalHeader(
              enableInfiniteRefresh: false,
            ),
            controller: model.controller,
            scrollController: model.scrollController,
            onRefresh: model.onRefresh,
            slivers: <Widget>[
              SliverToBoxAdapter(
                child: Container(
                  child: RankPageWidget(),
                ),
              ),
            ],
          )*/
          ,
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class RankPageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    RankPageModel model = Provider.of(context);
    if (model.isInit) {
      return LoadingWidget();
    }
    return ListView.separated(
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return HomePageItem(item: model.dataList[index]);
      },
      separatorBuilder: (context, index) {
        return Divider(
          height: 10,
          color: Color(0xFFF4F4F4),
        );
      },
      itemCount: model.dataList.length,
    );
  }
}
