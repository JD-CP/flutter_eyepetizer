import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_eyepetizer/entity/category_entity.dart';
import 'package:flutter_eyepetizer/entity/follow_entity.dart';
import 'package:flutter_eyepetizer/http/http.dart';
import 'package:flutter_eyepetizer/util/constant.dart';
import 'category_item_widget.dart';
import 'follow_item_widget.dart';
import 'follow_list_page.dart';

class DiscoveryPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => DiscoveryPageState();
}

class DiscoveryPageState extends State<DiscoveryPage> {
  List<CategoryEntity> _dataList = [];
  List<FollowItem> _followItemList = [];

  void getPageData() async {
    var dio = Dio();
    dio.interceptors.add(LogInterceptor());
    var response = await dio.get(Constant.categoryUrl,
        options:
            Options(headers: httpHeaders, responseType: ResponseType.plain));
    var resJson = json.decode(response.toString());
    var dataList = List<CategoryEntity>.from(
        resJson.map((i) => CategoryEntity.fromJson(i)));

    var responseFollow = await dio.get(Constant.followUrl,
        options: Options(headers: httpHeaders));
    Map map = json.decode(responseFollow.toString());
    var followEntity = FollowEntity.fromJson(map);
    var followItemList = followEntity.itemList;

    this.setState(() {
      this._dataList = dataList;
      this._followItemList = followItemList;
    });
  }

  @override
  void initState() {
    super.initState();
    getPageData();
  }

  /// 热门分类标题 Widget
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

  /// 推荐关注标题 Widget renderFollowTitleWidget
  Widget renderFollowTitleWidget() {
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FollowListPage()));
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('发现', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        color: Colors.white,
        child: CustomScrollView(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: renderFollowTitleWidget(),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  var i = index;
                  i -= 1;
                  if (i.isOdd) {
                    i = (i + 1) ~/ 2;
                    return FollowItemWidget(
                      item: _followItemList[i],
                    );
                  }
                  i = i ~/ 2;
                  return Divider(
                    height: .5,
                    indent: 65,
                    color: Color(0xFFDDDDDD),
                  );
                },
                childCount: _followItemList.length * 2,
              ),
            ),
            SliverToBoxAdapter(
              child: renderCategoryTitleWidget(),
            ),
            SliverPadding(
              padding: EdgeInsets.all(10),
              sliver: SliverGrid(
                delegate: SliverChildBuilderDelegate((context, index) {
                  return CategoryItemWidget(item: this._dataList[index]);
                }, childCount: this._dataList.length),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
