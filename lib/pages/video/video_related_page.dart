import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_eyepetizer/entity/issue_entity.dart';

class VideoRelatedPage extends StatelessWidget {
  final Item item;

  VideoRelatedPage({Key key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 15, right: 10),
      child: Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 15, top: 5, bottom: 5),
            child: Stack(
              alignment: FractionalOffset(0.95, 0.90),
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: item.data.cover.detail,
                    width: 135,
                    height: 80,
                  ),
                ),
                Positioned(
                  child: Container(
                    child: Padding(
                      padding:
                          EdgeInsets.only(left: 6, right: 6, top: 3, bottom: 3),
                      child: Text(
                        item.data.category,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white30,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                )
              ],
            ),

            /*ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: CachedNetworkImage(
                width: 135,
                height: 80,
                imageUrl: item.data.cover.detail,
              ),
            )*/
          ),
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  item.data.title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: Text(
                    '${DateUtil.formatDateMs(item.data.releaseTime, format: 'yyyy/MM/dd HH:mm')}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
