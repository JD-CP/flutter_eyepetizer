import 'package:flutter/material.dart';

class ItemWidget extends StatefulWidget implements PreferredSizeWidget {
  final List<String> tabNames;
  final ItemSelectedStatusChanged selectedStatusChanged;
  final double height;

  ItemWidget(
      {Key key, this.tabNames, this.selectedStatusChanged, this.height = 70});

  @override
  State<StatefulWidget> createState() {
    return null;
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}

class ItemWidgetState extends State<ItemWidget> {
  int selectIndex = 0;

  _renderItem(String name, int index) {
    var style = index == selectIndex
        ? Colors.red
        : Colors.grey;
    return new Expanded(
      child: AnimatedSwitcher(
        transitionBuilder: (child, anim) {
          return ScaleTransition(child: child, scale: anim);
        },
        duration: Duration(milliseconds: 300),
        child: RawMaterialButton(
            key: ValueKey(index == selectIndex),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            constraints: const BoxConstraints(minWidth: 0.0, minHeight: 0.0),
            padding: EdgeInsets.all(10.0),
            child: new Text(
              name,
              textAlign: TextAlign.center,
            ),
            onPressed: () {
              if (selectIndex != index) {
                widget.selectedStatusChanged?.call(index);
              }
              setState(() {
                selectIndex = index;
              });
            }),
      ),
    );
  }

  List<Widget> renderList() {
    List<Widget> list = new List();
    for (int i = 0; i < widget.tabNames.length; i++) {
      if (i == widget.tabNames.length - 1) {
        list.add(_renderItem(widget.tabNames[i], i));
      } else {
        list.add(_renderItem(widget.tabNames[i], i));
        list.add(
          new Container(width: 1.0, height: 25.0, color: Colors.grey),
        );
      }
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[],
      ),
    );
  }
}

typedef void ItemSelectedStatusChanged<int>(int value);
