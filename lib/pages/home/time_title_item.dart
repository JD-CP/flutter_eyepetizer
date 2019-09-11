import 'package:flutter/material.dart';

/// 时间标题 item
class TimeTitleItem extends StatelessWidget {
  final String timeTitle;

  TimeTitleItem({Key key, this.timeTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(13),
      child: Text(
        timeTitle,
        style: TextStyle(
          fontSize: 15,
          color: Colors.black,
        ),
      ),
    );
  }
}
