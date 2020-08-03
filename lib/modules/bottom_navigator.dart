import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eyepetizer/config/dimens.dart';
import 'package:flutter_eyepetizer/config/images.dart';
import 'package:flutter_eyepetizer/modules/discovery/page/discovery.dart';
import 'package:flutter_eyepetizer/modules/home/page/home.dart';
import 'package:flutter_eyepetizer/modules/hot/page/hot.dart';

class BottomNavigator extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {
  int _tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        children: [HomePage(), DiscoveryPage(), HotPage()],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon:
                _tabIndex == 0 ? Images.tabHomeSelected : Images.tabHomeNormal,
            title: Text('首页'),
          ),
          BottomNavigationBarItem(
            icon: _tabIndex == 1
                ? Images.tabDiscoverySelected
                : Images.tabDiscoveryNormal,
            title: Text('发现'),
          ),
          BottomNavigationBarItem(
            icon: _tabIndex == 2 ? Images.tabHotSelected : Images.tabHotNormal,
            title: Text('热门'),
          ),
          BottomNavigationBarItem(
            icon:
                _tabIndex == 3 ? Images.tabMineSelected : Images.tabMineNormal,
            title: Text('我的'),
          ),
        ],
        currentIndex: _tabIndex,
        onTap: (index) => _onItemTap(index),
        type: BottomNavigationBarType.fixed,
        iconSize: Dimens.gap_dp2 * 11,
        selectedFontSize: Dimens.font_sp11,
        unselectedFontSize: Dimens.font_sp10,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black38,
        backgroundColor: Theme.of(context).colorScheme.surface,
      ),
    );
  }

  void _onItemTap(int index) {
    setState(() {
      _tabIndex = index;
    });
  }
}
