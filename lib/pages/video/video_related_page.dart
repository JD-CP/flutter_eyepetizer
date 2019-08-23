import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_eyepetizer/entity/issue_entity.dart';

import 'video_details_page.dart';

class VideoRelatedPage extends StatelessWidget {
  final Item item;
  final callback;

  VideoRelatedPage({Key key, this.item, this.callback}) : super(key: key);

  String formatDuration(duration) {
    var minute = duration ~/ 60;
    var second = duration % 60;
    var str;
    if (minute <= 9) {
      if (second <= 9) {
        str = "0$minute:0$second";
      } else {
        str = "0$minute:$second";
      }
    } else {
      if (second <= 9) {
        str = "$minute:0$second";
      } else {
        str = "$minute:$second";
      }
    }
    return str;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        this.callback();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VideoDetailsPage(
              item: this.item,
            ),
          ),
        );
      },
      child: Container(
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
                        padding: EdgeInsets.all(3),
                        child: Text(
                          formatDuration(item.data.duration),
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black45,
                        borderRadius: BorderRadius.circular(3),
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
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: Text(
                      '#${item.data.category} / ${item.data.author.name}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
