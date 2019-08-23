import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_eyepetizer/entity/issue_entity.dart';
import 'package:flutter_eyepetizer/pages/author/author_details_page.dart';
import 'package:flutter_eyepetizer/pages/video/video_details_page.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flustars/flustars.dart';

class HomePageItem extends StatelessWidget {
  final Item item;

  HomePageItem({Key key, this.item}) : super(key: key);

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
          // alignment: FractionalOffset(0.95, 0.5),
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
              child: Container(
                padding:
                    EdgeInsets.only(left: 15, top: 10, bottom: 10, right: 15),
                height: 220,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: 40,
                          height: 40,
                          alignment: Alignment.center,
                          child: Padding(
                            padding: EdgeInsets.all(5),
                            child: Text(
                              item.data.category,
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          decoration: BoxDecoration(
                            // color: Color(0x4DFAEBD7),
                            gradient: LinearGradient(
                              colors: [Color(0x4DCD8C95), Color(0x4DF0FFFF)],
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          child: Padding(
                            padding: EdgeInsets.all(3),
                            child: Text(
                              formatDuration(item.data.duration),
                              style: TextStyle(
                                fontSize: 11,
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
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
        Padding(
          padding: EdgeInsets.only(left: 15, right: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ClipOval(
                child: GestureDetector(
                  onTap: () {
                    /*Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AuthorDetailsPage(
                                  item: this.item,
                                )));*/
                  },
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
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 13,
                            ),
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
