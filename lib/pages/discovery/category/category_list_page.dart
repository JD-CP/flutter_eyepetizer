import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_eyepetizer/router/router_manager.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_eyepetizer/data/entity/category_entity.dart';
import 'package:flutter_eyepetizer/pages/discovery/category/category_list_model.dart';
import 'package:flutter_eyepetizer/provider/provider_widget.dart';
import 'package:flutter_eyepetizer/util/fluro_convert_util.dart';

import 'category_list_item.dart';

/// 分类列表
class CategoryListPage extends StatefulWidget {
  final String itemJson;

  CategoryListPage({Key key, this.itemJson}) : super(key: key);

  @override
  State<StatefulWidget> createState() => CategoryListPageState();
}

class CategoryListPageState extends State<CategoryListPage> {

  @override
  Widget build(BuildContext context) {
    CategoryEntity item =
        CategoryEntity.fromJson(FluroConvertUtils.string2map(widget.itemJson));

    return ProviderWidget<CategoryListModel>(
      model: CategoryListModel(item.id),
      onModelInitial: (model) {
        model.init();
      },
      builder: (context, model, child) {
        return MaterialApp(
          theme: ThemeData(
            brightness: Brightness.light,
            primaryColor:
            Colors.white, //Changing this will change the color of the TabBar
          ),
          home: Scaffold(
            body: SmartRefresher(
              onRefresh: model.onRefresh,
              onLoading: model.onLoadMore,
              enablePullUp: true,
              controller: model.refreshController,
              header: MaterialClassicHeader(
                distance: 80.0,
                backgroundColor: Colors.redAccent,
              ),
              child: CustomScrollView(
                physics: ClampingScrollPhysics(),
                slivers: <Widget>[
                  SliverAppBar(
                    leading: GestureDetector(
                      child: Icon(Icons.arrow_back),
                      onTap: () {
                        RouterManager.router.pop(context);
                      },
                    ),
                    title: Text(item.name),
                    expandedHeight: 180.0,
                    pinned: true,
                    backgroundColor: Colors.white,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Image.network(
                        item.bgPicture,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        var i = index;
                        i -= 1;
                        if (i.isOdd) {
                          i = (i + 1) ~/ 2;
                          return CategoryListItem(
                            item: model.dataList[i],
                          );
                        }
                        i = i ~/ 2;
                        return Divider(
                          height: 10,
                          color: Color(0xFFF4F4F4),
                        );

                        // return CategoryListItem(item: model.itemList[index]);
                      },
                      childCount: model.dataList.length * 2,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
