import 'package:flutter/material.dart';

class KeywordItemWidget extends StatelessWidget {
  final List<String> keywords;
  final callback;

  KeywordItemWidget({Key key, this.keywords, this.callback});

  List<Widget> renderTags() {
    return List.generate(keywords.length, (index) {
      return Container(
        margin: EdgeInsets.only(top: 10),
        padding: EdgeInsets.only(left: 15, right: 15, top: 7, bottom: 7),
        child: InkWell(
          child: Text(
            keywords[index],
            style: TextStyle(fontSize: 11, color: Colors.black54),
          ),
          onTap: () {
            debugPrint('onTap value-> ${keywords[index]}');
            callback(keywords[index]);
          },
        ),
        decoration: BoxDecoration(
          color: Color.fromRGBO(0, 0, 0, 0.87).withOpacity(
            Color.fromRGBO(0, 0, 0, 0.87).opacity * 0.15,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsets.only(left: 15, right: 15),
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 15, top: 15, right: 15),
            child: Text(
              '热搜关键词',
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 15, top: 5, right: 15, bottom: 5),
            child: Wrap(
              spacing: 5.0,
              alignment: WrapAlignment.center,
              children: renderTags(),
            ),
          )
        ],
      ), /*CustomScrollView(
        shrinkWrap: true,
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(left: 15, top: 15, right: 15, bottom: 5),
              child: Text(
                '热搜关键词',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                /// 实现了每个 item 下面加一条分割线
                var i = index;
                i -= 1;
                if (i.isOdd) {
                  i = (i + 1) ~/ 2;
                  return GestureDetector(
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: 15,
                        top: 10,
                        bottom: 10,
                      ),
                      child: Text(
                        keywords[i],
                        style: TextStyle(
                          color: Colors.lightBlueAccent[400],
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ),
                    onTap: () {
                      debugPrint('onTap value-> ${keywords[i]}');
                      callback(keywords[i]);
                    },
                  );
                }
                i = i ~/ 2;
                return Divider(
                  height: .5,
                  indent: 15,
                  color: Color(0xFFDDDDDD),
                );
              },
              childCount: keywords.length * 2,
            ),
          ),
        ],
      ),*/
    );
  }
}
