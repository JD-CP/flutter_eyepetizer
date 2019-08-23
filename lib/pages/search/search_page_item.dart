import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eyepetizer/entity/issue_entity.dart';
import 'package:flutter_eyepetizer/pages/video/video_details_page.dart';

class SearchPageItem extends StatelessWidget {
  final Item item;

  SearchPageItem({Key key, this.item});

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
    return Container(
      child: Stack(
        alignment: FractionalOffset(0.5, 0.5),
        children: <Widget>[
          GestureDetector(
            child: CachedNetworkImage(
              height: 220,
              width: double.infinity,
              fit: BoxFit.cover,
              imageUrl: item.data.cover.feed,
              errorWidget: (context, url, error) =>
                  Image.asset('images/img_load_fail.png'),
            ),
            onTap: () {
              /// 点击图片跳转至视频详情页
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => VideoDetailsPage(
                            item: this.item,
                          )));
            },
          ),
          Positioned(
            child: Column(
              children: <Widget>[
                Text(
                  item.data.title,
                  maxLines: 1,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: Text(
                      formatDuration(item.data.duration),
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black45,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
