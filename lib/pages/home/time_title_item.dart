import 'package:flutter/material.dart';
import 'package:flutter_eyepetizer/entity/issue_entity.dart';

class TimeTitleItem extends StatelessWidget {
  final Item item;

  TimeTitleItem({Key key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(15),
      child: Text(
        item.data.text,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }
}
