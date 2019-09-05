import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_eyepetizer/pages/home/home_page_item.dart';
import 'package:flutter_eyepetizer/pages/hot/rank_page_model.dart';
import 'package:flutter_eyepetizer/provider/provider_widget.dart';
import 'package:flutter_eyepetizer/widget/loading_widget.dart';
import 'package:flutter_eyepetizer/widget/refresh/refresh_header.dart';
import 'package:provider/provider.dart';

class RankPage extends StatefulWidget {
  final String pageUrl;

  RankPage({Key key, this.pageUrl}) : super(key: key);

  @override
  State<StatefulWidget> createState() => RankPageState();
}

class RankPageState extends State<RankPage> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return ProviderWidget<RankPageModel>(
      model: RankPageModel(),
      onModelInitial: (model) {
        model.init(widget.pageUrl);
      },
      builder: (context, model, child) {
        return EasyRefresh.custom(
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
        return HomePageItem(item: model.itemList[index]);
      },
      separatorBuilder: (context, index) {
        return Divider(
          height: .5,
          color: Color(0xFFDDDDDD),
          indent: 15,
        );
      },
      itemCount: model.itemList.length,
    );
  }
}
