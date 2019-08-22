import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_eyepetizer/entity/issue_entity.dart';
import 'package:flutter_eyepetizer/pages/video/video_details_page.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flustars/flustars.dart';

class CategoryItem extends StatelessWidget {
  final Item item;

  CategoryItem({Key key, this.item}) : super(key: key);

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
    return Column(
      children: <Widget>[
        Stack(
          alignment: FractionalOffset(0.95, 0.95),
          children: <Widget>[
            GestureDetector(
              child: CachedNetworkImage(
                height: 220,
                fit: BoxFit.cover,
                imageUrl: item.data.cover.feed,
                errorWidget: (context, url, error) =>
                    Image.asset('images/img_load_fail'),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => VideoDetailsPage(
                              item: this.item,
                            )));
              },
            ),
            Positioned(
              child: Container(
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
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(left: 15, right: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ClipOval(
                child: CachedNetworkImage(
                  imageUrl: item.data.author.icon,
                  width: 40,
                  height: 40,
                  placeholder: (context, url) => CircularProgressIndicator(
                    strokeWidth: 2.5,
                    backgroundColor: Colors.deepPurple[600],
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding:
                      EdgeInsets.only(left: 10, right: 15, top: 10, bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(item.data.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style:
                              TextStyle(color: Colors.black87, fontSize: 15)),
                      Padding(padding: EdgeInsets.only(top: 2, bottom: 2)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            item.data.author.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style:
                                TextStyle(color: Colors.black54, fontSize: 13),
                          ),
                          /*Expanded(
                            child: Text(''),
                            flex: 1,
                          ),
                          Text(
                            DateUtil.formatDateMs(
                                item.data.author.latestReleaseTime,
                                format: 'yyyy/MM/dd'),
                            style:
                                TextStyle(color: Colors.black54, fontSize: 12),
                          ),*/
                        ],
                      )
                    ],
                  ),
                ),
                flex: 1,
              ),
              GestureDetector(
                child:
                    Image.asset('images/icon_share.png', width: 25, height: 25),

                /// TODO 从底部弹出分享框
                onTap: () => Fluttertoast.showToast(
                  msg: '分享',
                  fontSize: 15,
                  textColor: Colors.black38,
                  backgroundColor: Colors.white,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
