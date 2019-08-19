import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_eyepetizer/entity/category_entity.dart';
import 'package:flutter_eyepetizer/entity/follow_entity.dart';
import 'package:flutter_eyepetizer/http/http.dart';
import 'package:flutter_eyepetizer/util/constant.dart';
import 'category_item_widget.dart';
import 'follow_item_details_widget.dart';
import 'follow_item_widget.dart';

class FollowItemListWidget extends StatelessWidget {
  final FollowItemlistDataItemlist item;
  final int index;

  FollowItemListWidget({Key key, this.item, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if ((this.index + 1) % 2 == 0) {
      return Padding(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Image.network(
          item.data.cover.feed,
          width: 300,
        ),
      );
    } else {
      return Image.network(
        item.data.cover.feed,
        width: 300,
      );
    }
  }
}
