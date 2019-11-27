import 'package:flutter/material.dart';
import 'package:flutter_eyepetizer/pages/search/search_page.dart';
import 'package:flutter_eyepetizer/provider/provider_widget.dart';
import 'package:flutter_eyepetizer/widget/loading_widget.dart';
import 'package:flutter_eyepetizer/widget/search/search_bar.dart' as search_bar;
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:provider/provider.dart';

import 'home_page_item.dart';
import '../../provider/home_page_model.dart';
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
                  search_bar.showSearch(
                    context: context,
                    delegate: SearchBarDelegate(),
                  );
                },
              ),
            ],
          ),
          body: Container(
            color: Color(0xFFF4F4F4),
            child: RefreshConfiguration(
              enableLoadingWhenNoData: false,
              child: SmartRefresher(
                header: WaterDropHeader(),
                footer: ClassicFooter(
                  loadStyle: LoadStyle.ShowAlways,
                ),
                enablePullUp: true,
                controller: model.refreshController,
                onRefresh: model.onRefresh,
                onLoading: model.onLoadMore,
                child: Container(
                  child: HomePageListWidget(),
                ),
              ),
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
        var item = model.dataList[index];
        if (item.type == 'textHeader') {
          return TimeTitleItem(timeTitle: item.data.text);
        }
        return HomePageItem(item: item);
      },
      separatorBuilder: (context, index) {
        var item = model.dataList[index];
        var itemNext = model.dataList[index + 1];
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
      itemCount: model.dataList.length,
    );
  }
}
