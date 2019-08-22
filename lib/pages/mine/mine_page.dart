import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MinePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /// 修改状态栏字体颜色
    /*SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
        .copyWith(statusBarBrightness: Brightness.light));*/
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 70),
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            ClipOval(
              child: Image.asset(
                'images/icon_default_avatar.png',
                width: 50,
                height: 50,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 5),
              child: Text(
                'JD-CP',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              '查看个人主页 >',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 35, bottom: 25),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          'images/icon_like_grey.png',
                          width: 20,
                          height: 20,
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 3),
                          child: Text(
                            '收藏',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ],
                    ),
                    flex: 1,
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          'images/icon_comment_grey.png',
                          width: 20,
                          height: 20,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 3),
                          child: Text(
                            '评论',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ],
                    ),
                    flex: 1,
                  ),
                ],
              ),
            ),
            Divider(
              height: .5,
              color: Color(0xFFDDDDDD),
            ),
            ListView(
              shrinkWrap: true,
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(top: 15, bottom: 15),
                  child: Text(
                    '我的关注',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black87,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(top: 15, bottom: 15),
                  child: Text(
                    '观看记录',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black87,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(top: 15, bottom: 15),
                  child: Text(
                    '我的徽章',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black87,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(top: 15, bottom: 15),
                  child: Text(
                    '功能设置',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black87,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(top: 15, bottom: 15),
                  child: Text(
                    '成为作者',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
