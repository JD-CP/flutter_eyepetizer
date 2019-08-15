import 'package:flutter/material.dart';
import '../entity/issue_entity.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flustars/flustars.dart';

// StatelessWidget 不需要可变状态，故变量应为不可变
class HomePageItem extends StatelessWidget {
  final Item item;

  HomePageItem({Key key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CachedNetworkImage(
          imageUrl: item.data.cover.feed,
          placeholder: (context, url) => CircularProgressIndicator(),
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
                  placeholder: (context, url) => CircularProgressIndicator(),
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(item.data.author.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 13)),
                          Expanded(
                            child: Text(''),
                            flex: 1,
                          ),
                          Text(
                            DateUtil.formatDateMs(
                                item.data.author.latestReleaseTime,
                                format: 'yyyy/MM/dd'),
                            style:
                                TextStyle(color: Colors.black54, fontSize: 12),
                          ),
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
