import 'package:flutter/material.dart';

/// 上拉加载
class LoadMoreWidget extends StatelessWidget {
  /// 表示是否处于上拉加载状态
  final bool isLoadMore;

  LoadMoreWidget({Key key, this.isLoadMore}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (this.isLoadMore) {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '努力加载中...  ',
              style: TextStyle(
                fontSize: 14,
                color: Colors.black54,
              ),
            ),
            SizedBox(
              width: 18,
              height: 18,
              child: CircularProgressIndicator(
                strokeWidth: 2.5,
                backgroundColor: Colors.deepPurple[600],
              ),
            )
          ],
        ),
      );
    } else {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        child: Text(
          '上拉加载更多',
          style: TextStyle(
            fontSize: 14,
            color: Colors.black54,
          ),
        ),
      );
    }
  }
}
