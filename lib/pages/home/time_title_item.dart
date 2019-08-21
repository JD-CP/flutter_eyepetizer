import 'package:flutter/material.dart';
import 'package:flutter_eyepetizer/entity/issue_entity.dart';

/// 时间标题 item
class TimeTitleItem extends StatelessWidget {
  final String timeTitle;

  TimeTitleItem({Key key, this.timeTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(15),
      child: Text(
        timeTitle,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }
}
