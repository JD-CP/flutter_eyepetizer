import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_eyepetizer/data/entity/issue_entity.dart';
import 'package:flutter_eyepetizer/router/router_manager.dart';
import 'package:flutter_eyepetizer/util/fluro_convert_util.dart';
import 'package:flutter_eyepetizer/util/time_util.dart';

class VideoRelatedPage extends StatelessWidget {
  final Item item;
  final callback;

  VideoRelatedPage({Key key, this.item, this.callback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        this.callback();
        String itemJson = FluroConvertUtils.object2string(this.item);
        RouterManager.router.navigateTo(
          context,
          RouterManager.video + "?itemJson=$itemJson",
          transition: TransitionType.inFromRight,
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
                          TimeUtil.formatDuration(item.data.duration),
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black45,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  )
                ],
              ),
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
