import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_eyepetizer/pages/search/search_page.dart';
import 'package:flutter_eyepetizer/provider/home_page_model.dart';
import 'package:flutter_eyepetizer/provider/provider_widget.dart';
import 'package:flutter_eyepetizer/widget/loading_widget.dart';
import 'package:flutter_eyepetizer/widget/refresh/load_more_footer.dart';
import 'package:flutter_eyepetizer/widget/refresh/refresh_header.dart';
import 'package:flutter_eyepetizer/widget/search/search_bar.dart' as search_bar;
import 'package:provider/provider.dart';

import 'home_page_item.dart';
import 'time_title_item.dart';

/// 首页
class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ProviderWidget<HomePageModel>(
      model: HomePageModel(),
      onModelInitial: (model) {
        model.init();
      },
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(

            title: Text('每日精选', style: TextStyle(color: Colors.black)),
            centerTitle: true,
            backgroundColor: Colors.white,

            /// 去除阴影
            elevation: 0,
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.search,
                  color: Colors.black87,
                ),
                onPressed: () {
                  // showSearch(context: context, delegate: SearchBarDelegate());
                  search_bar.showSearch(context: context, delegate: SearchBarDelegate(hintText: "请输入关键词"));
                },
              ),
            ],
          ),
          body: Container(
            color: Color(0xFFF4F4F4),
            child: EasyRefresh.custom(
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
                    child: HomePageListWidget(),
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
}

class HomePageListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    HomePageModel model = Provider.of(context);
    if (model.isInit) {
      return LoadingWidget();
    }
    return ListView.separated(
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        var item = model.itemList[index];
        if (item.type == 'textHeader') {
          return TimeTitleItem(timeTitle: item.data.text);
        }
        return HomePageItem(item: item);
      },
      separatorBuilder: (context, index) {
        var item = model.itemList[index];
        var itemNext = model.itemList[index + 1];
        if (item.type == 'textHeader' || itemNext.type == 'textHeader') {
          return Divider(
            height: 0,
            color: Color(0xFFF4F4F4),

            /// indent: 前间距, endIndent: 后间距
          );
        }
        return Divider(
          height: 10,
          color: Color(0xFFF4F4F4),

          /// indent: 前间距, endIndent: 后间距
        );
      },
      itemCount: model.itemList.length,
    );
  }
}
