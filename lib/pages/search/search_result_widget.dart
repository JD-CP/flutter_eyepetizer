import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_eyepetizer/entity/issue_entity.dart';
import 'package:flutter_eyepetizer/http/http.dart';
import 'package:flutter_eyepetizer/pages/home/home_page_item.dart';
import 'package:flutter_eyepetizer/pages/search/search_page_item.dart';
import 'package:flutter_eyepetizer/widget/load_more_widget.dart';

class SearchResultWidget extends StatefulWidget {
  final Issue issue;
  final String query;

  SearchResultWidget({Key key, this.issue, this.query});

  @override
  State<StatefulWidget> createState() => SearchResultState();
}

class SearchResultState extends State<SearchResultWidget> {
  List<Item> _dataList;
  String nextPageUrl;

  /// 表示是否正在上拉加载
  bool isLoadingMore = false;

  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    setState(() {
      _dataList = widget.issue.itemList;
    });
    nextPageUrl = widget.issue.nextPageUrl;
    this.scrollController.addListener(() => {
          if (!this.isLoadingMore &&
              this.scrollController.position.pixels >=
                  this.scrollController.position.maxScrollExtent)
            {this.loadMoreData()}
        });
  }

  void loadMoreData() {
    if (_dataList.length == widget.issue.total - 10) {
      return;
    }
    this.setState(() {
      this.isLoadingMore = true;
      this.getPageData();
    });
  }

  @override
  Widget build(BuildContext context) {
//    return renderScrollWidget();
    return Column(
      children: <Widget>[
        Container(
          color: Colors.white,
          padding: EdgeInsets.only(top: 20, bottom: 20),
          alignment: Alignment.center,
          child: Text(
            '— 「${widget.query}」搜索结果共${widget.issue.total}个 —',
            style: TextStyle(
              color: Colors.black54,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
        Flexible(
          flex: 1,
          child: CustomScrollView(
            shrinkWrap: true,
            controller: scrollController,
            physics: BouncingScrollPhysics(),
            slivers: <Widget>[
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    if (index < _dataList.length) {
                      return SearchPageItem(
                        item: _dataList[index],
                      );
                    }
                    print(index);
                    if (index == widget.issue.total - 10) {
                      // 滑动到最底部了，没有更多数据了
                      return Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(20),
                        child: Text(
                          '— 到底了哇 —',
                          style: TextStyle(
                            color: Colors.black45,
                            fontSize: 14,
                          ),
                        ),
                      );
                    }
                    return LoadMoreWidget(
                      isLoadMore: this.isLoadingMore,
                    );
                  },
                  childCount: _dataList.length + 1,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget renderScrollWidget() {
    return ListView.separated(
      controller: this.scrollController,
      itemBuilder: (context, index) {
        /*if (index == 0) {
          return Container(
            color: Colors.white,
            padding: EdgeInsets.only(top: 35, bottom: 15),
            alignment: Alignment.center,
            child: Text(
              '— 「${widget.query}」搜索结果共${widget.issue.total}个 —',
              style: TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          );
        }*/
        if (index < this._dataList.length) {
          return HomePageItem(
            item: _dataList[index],
          );
        }
        return LoadMoreWidget(
          isLoadMore: this.isLoadingMore,
        );
      },
      separatorBuilder: (context, index) {
        return Divider(
          height: .5,
          color: Color(0xFFDDDDDD),

          /// indent: 前间距, endIndent: 后间距
          indent: 15,
        );
      },
      itemCount: _dataList.length + 1,
    );
  }

  void getPageData() async {
    HttpUtil.doGet(
      this.nextPageUrl,
      success: (response) {
        Map map = json.decode(response.toString());
        var issueEntity = Issue.fromJson(map);
        this.nextPageUrl = issueEntity.nextPageUrl;
        setState(() {
          if (this.isLoadingMore) {
            isLoadingMore = false;
            this._dataList.addAll(issueEntity.itemList);
          } else {
            this._dataList = issueEntity.itemList;
          }
        });
      },
      fail: (exception) {},
    );
  }
}
