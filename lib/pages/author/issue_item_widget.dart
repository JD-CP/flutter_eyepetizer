import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eyepetizer/entity/issue_entity.dart';
import 'package:flutter_eyepetizer/pages/discovery/follow/follow_item_list_widget.dart';

import 'author_details_page.dart';

class IssueItemWidget extends StatelessWidget {
  final Item item;

  IssueItemWidget({Key key, this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(left: 15, top: 10, right: 15, bottom: 10),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AuthorDetailsPage(
                        item: this.item,
                      ),
                    ),
                  );
                },
                child: ClipOval(
                  child: CachedNetworkImage(
                    width: 40,
                    height: 40,
                    imageUrl: item.data.header.icon,
                    placeholder: (context, url) => CircularProgressIndicator(
                      strokeWidth: 2.5,
                      backgroundColor: Colors.deepPurple[600],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        item.data.header.title,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 3),
                        child: Text(
                          item.data.header.description,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 13, color: Colors.black26),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          Container(
            height: 245,
            child: ListView.builder(
              itemBuilder: (context, index) {
                return FollowItemListWidget(
                  item: item.data.itemList[index],
                  index: index,
                );
              },
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: item.data.itemList.length,
            ),
          ),
        ],
      ),
    );
  }
}
