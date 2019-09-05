import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_eyepetizer/pages/search/search_page.dart';
import 'package:flutter_eyepetizer/provider/home_page_model.dart';
import 'package:flutter_eyepetizer/provider/provider_widget.dart';
import 'package:flutter_eyepetizer/widget/loading_widget.dart';
import 'package:flutter_eyepetizer/widget/refresh/load_more_footer.dart';
import 'package:flutter_eyepetizer/widget/refresh/refresh_header.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import 'home_page_item.dart';
import 'time_title_item.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ProviderWidget(
      model: HomePageModel(),
      onModelInitial: (model) {
        model.init();
      },
      builder: (context, model, child) {
        return MaterialApp(
          home: Scaffold(
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
                    showSearch(context: context, delegate: SearchBarDelegate());
                  },
                ),
              ],
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
        return Divider(
          height: .5,
          color: Color(0xFFDDDDDD),

          /// indent: 前间距, endIndent: 后间距
          indent: 15,
        );
      },
      itemCount: model.itemList.length,
    );
  }
}
