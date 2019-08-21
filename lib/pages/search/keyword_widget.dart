import 'package:flutter/material.dart';

class KeywordItemWidget extends StatelessWidget {
  final List<String> keywords;
  final callback;

  KeywordItemWidget({Key key, this.keywords, this.callback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CustomScrollView(
        shrinkWrap: true,
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(left: 15, top: 15, right: 15, bottom: 5),
              child: Text(
                '热搜关键词',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
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
      ),
    );

    /*return Container(
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 15, top: 15, right: 15, bottom: 20),
            child: Text(
              '热搜关键词',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          */ /*ListView.separated(
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(left: 15, top: 5, bottom: 5),
                child: Text(
                  keywords[index],
                  style: TextStyle(
                    color: Colors.deepPurpleAccent[600],
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return Divider(
                indent: 15,
                height: .5,
                color: Color(0xFFDDDDDD),
              );
            },
            itemCount: keywords.length,
          ),*/ /*
        ],
      ),

      */ /*Column(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            child: Text(
              '大家都在搜',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: 10.0,
            ),
            alignment: Alignment.centerLeft,
            child: Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: keywords.map((keyword) {
                return GestureDetector(
                  child: new ClipRRect(
                    child: Container(
                      padding: EdgeInsets.all(3.0),
                      child: Text(
                        keyword,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      color: Colors.blue,
                    ),
                    borderRadius: new BorderRadius.circular(3.0),
                  ),
                  onTap: () {
                    debugPrint('onTap key-> $keyword');
                    callback(keyword);
                  },
                );
              }).toList(),
            ),
          ),
        ],
      ),*/ /*
    );*/
  }
}
