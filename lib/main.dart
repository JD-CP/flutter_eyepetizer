import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'pages/home/home_page.dart';
import 'pages/discovery/discovery_page.dart';
import 'pages/hot/hot_page.dart';
import 'pages/mine/mine_page.dart';

// 主入口
void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyApp> {
  // 记录当前 tab 选择位置
  int tabIndex = 0;
  var tabImages;
  var tabPages;

  final tabTextStyleNormal = TextStyle(color: Colors.black38);
  final tabTextStyleSelected = TextStyle(color: Colors.black);
  final tabTitles = <String>['首页精选', '发现', '热门', '我的'];

  var body;

  @override
  void initState() {
    super.initState();
    tabImages ??= [
      [
        getTabImage('images/ic_home_normal.png'),
        getTabImage('images/ic_home_selected.png')
      ],
      [
        getTabImage('images/ic_discovery_normal.png'),
        getTabImage('images/ic_discovery_selected.png')
      ],
      [
        getTabImage('images/ic_hot_normal.png'),
        getTabImage('images/ic_hot_selected.png')
      ],
      [
        getTabImage('images/ic_mine_normal.png'),
        getTabImage('images/ic_mine_selected.png')
      ],
    ];
    tabPages ??= [HomePage(), DiscoveryPage(), HotPage(), MinePage()];
  }

  Image getTabImage(imagePath) => Image.asset(imagePath, width: 22, height: 22);

  Image getTabIcon(int index) {
    if (tabIndex == index) {
      return tabImages[index][1];
    }
    return tabImages[index][0];
  }

  TextStyle getTabTextStyle(int index) {
    if (tabIndex == index) {
      return tabTextStyleSelected;
    }
    return tabTextStyleNormal;
  }

  Text getTabTitle(index) => Text(
        tabTitles[index],
        style: getTabTextStyle(index),
      );

  @override
  Widget build(BuildContext context) {
    body = IndexedStack(
      children: tabPages,
      index: tabIndex,
    );
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color(0xFFFFFFFF),
      ),
      home: Scaffold(
        /*appBar: AppBar(
          title: Text('Eyepetizer', style: TextStyle(color: Colors.black)),
          centerTitle: true,
          elevation: 0,
        ),*/
        body: body,
        bottomNavigationBar: CupertinoTabBar(
          backgroundColor: Color(0xFFFFFFFF),
          items: [
            BottomNavigationBarItem(icon: getTabIcon(0), title: getTabTitle(0)),
            BottomNavigationBarItem(icon: getTabIcon(1), title: getTabTitle(1)),
            BottomNavigationBarItem(icon: getTabIcon(2), title: getTabTitle(2)),
            BottomNavigationBarItem(icon: getTabIcon(3), title: getTabTitle(3)),
          ],
          currentIndex: tabIndex,
          onTap: (index) => {
            setState(() {
              tabIndex = index;
            })
          },
        ),
      ),
    );
  }
}
