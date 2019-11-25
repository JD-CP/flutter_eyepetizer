import 'package:cached_network_image/cached_network_image.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter_eyepetizer/data/entity/issue_entity.dart';
import 'package:flutter_eyepetizer/router/router_manager.dart';
import 'package:flutter_eyepetizer/util/fluro_convert_util.dart';

class FollowItemListWidget extends StatelessWidget {
  final Item item;
  final int index;

  FollowItemListWidget({Key key, this.item, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if ((this.index + 1) % 2 == 0) {
      return Padding(
        padding: EdgeInsets.only(left: 6, right: 6),
        child: renderItemWidget(context),
      );
    } else {
      return renderItemWidget(context);
    }
  }

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

  Widget renderItemWidget(context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 10),
          child: Stack(
            children: <Widget>[
              GestureDetector(
                child: CachedNetworkImage(
                  width: 300,
                  height: 180,
                  fit: BoxFit.cover,
                  imageUrl: item.data.cover.feed,
                  errorWidget: (context, url, error) =>
                      Image.asset('images/img_load_fail'),
                ),
                onTap: () {
                  String itemJson = FluroConvertUtils.object2string(this.item);
                  RouterManager.router.navigateTo(
                    context,
                    RouterManager.video + "?itemJson=$itemJson",
                    transition: TransitionType.inFromRight,
                  );
                },
              ),
              Positioned(
                child: Container(
                  width: 300,
                  padding: EdgeInsets.only(top: 10, bottom: 10, right: 10),
                  height: 180,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            width: 40,
                            height: 24,
                            alignment: Alignment.center,
                            child: Padding(
                              padding: EdgeInsets.all(5),
                              child: Text(
                                item.data.category,
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            decoration: BoxDecoration(
                                color: Colors.black26,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(12),
                                    bottomRight: Radius.circular(12))),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Container(
                            child: Padding(
                              padding: EdgeInsets.all(5),
                              child: Text(
                                formatDuration(item.data.duration),
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            decoration: BoxDecoration(
                              color: Colors.black26,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 10, top: 5, bottom: 5),
          child: Text(
            item.data.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
            ),
          ),
        ),
        Text(
          DateUtil.formatDateMs(
            item.data.author.latestReleaseTime,
            format: 'yyyy/MM/dd HH:mm',
          ),
          style: TextStyle(
            color: Colors.grey,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
