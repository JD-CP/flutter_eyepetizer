import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_eyepetizer/data/entity/category_entity.dart';
import 'package:flutter_eyepetizer/pages/discovery/category/category_list_model.dart';
import 'package:flutter_eyepetizer/provider/provider_widget.dart';
import 'package:flutter_eyepetizer/util/fluro_convert_util.dart';
import 'package:flutter_eyepetizer/widget/refresh/load_more_footer.dart';

import 'category_list_item.dart';

/// 分类列表
class CategoryListPage extends StatefulWidget {
  final String itemJson;

  CategoryListPage({Key key, this.itemJson}) : super(key: key);

  @override
  State<StatefulWidget> createState() => CategoryListPageState();
}

class CategoryListPageState extends State<CategoryListPage> {
  LinkHeaderNotifier _headerNotifier;

  @override
  void initState() {
    super.initState();
    _headerNotifier = LinkHeaderNotifier();
  }

  @override
  void dispose() {
    super.dispose();
    _headerNotifier.dispose();
  }

  @override
  Widget build(BuildContext context) {
    CategoryEntity item =
        CategoryEntity.fromJson(FluroConvertUtils.string2map(widget.itemJson));

    return ProviderWidget<CategoryListModel>(
      model: CategoryListModel(),
      onModelInitial: (model) {
        model.init(item.id);
      },
      builder: (context, model, child) {
        return Scaffold(
          body: Container(
            color: Color(0xFFF4F4F4),
            child: EasyRefresh.custom(
              header: LinkHeader(
                _headerNotifier,
                extent: 70.0,
                triggerDistance: 70.0,
                completeDuration: Duration(milliseconds: 500),
              ),
              footer: MyClassicalFooter(enableInfiniteLoad: false),
              onLoad: model.onLoadMore,
              onRefresh: model.onRefresh,
              slivers: <Widget>[
                SliverAppBar(
                  expandedHeight: 180.0,
                  pinned: true,
                  backgroundColor: Colors.white,
                  flexibleSpace: FlexibleSpaceBar(
                    centerTitle: false,
                    title: Text(item.name),
                    background: Image.network(
                      item.bgPicture,
                      fit: BoxFit.cover,
                    ),
                  ),
                  actions: <Widget>[
                    CircleHeader(_headerNotifier),
                  ],
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      var i = index;
                      i -= 1;
                      if (i.isOdd) {
                        i = (i + 1) ~/ 2;
                        return CategoryListItem(
                          item: model.itemList[i],
                        );
                      }
                      i = i ~/ 2;
                      return Divider(
                        height: 10,
                        color: Color(0xFFF4F4F4),
                      );

                      // return CategoryListItem(item: model.itemList[index]);
                    },
                    childCount: model.itemList.length * 2,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// 圆形Header
class CircleHeader extends StatefulWidget {
  final LinkHeaderNotifier linkNotifier;

  const CircleHeader(this.linkNotifier, {Key key}) : super(key: key);

  @override
  CircleHeaderState createState() {
    return CircleHeaderState();
  }
}

class CircleHeaderState extends State<CircleHeader> {
  // 指示器值
  double _indicatorValue = 0.0;

  RefreshMode get _refreshState => widget.linkNotifier.refreshState;

  double get _pulledExtent => widget.linkNotifier.pulledExtent;

  @override
  void initState() {
    super.initState();
    widget.linkNotifier.addListener(onLinkNotify);
  }

  void onLinkNotify() {
    setState(() {
      if (_refreshState == RefreshMode.armed ||
          _refreshState == RefreshMode.refresh) {
        _indicatorValue = null;
      } else if (_refreshState == RefreshMode.refreshed ||
          _refreshState == RefreshMode.done) {
        _indicatorValue = 1.0;
      } else {
        if (_refreshState == RefreshMode.inactive) {
          _indicatorValue = 0.0;
        } else {
          double indicatorValue = _pulledExtent / 70.0 * 0.8;
          _indicatorValue = indicatorValue < 0.8 ? indicatorValue : 0.8;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(
          right: 20.0,
        ),
        width: 24.0,
        height: 24.0,
        child: CircularProgressIndicator(
          value: _indicatorValue,
          valueColor: AlwaysStoppedAnimation(Colors.black),
          strokeWidth: 2.4,
        ),
      ),
    );
  }
}
