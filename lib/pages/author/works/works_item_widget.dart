import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eyepetizer/data/entity/issue_entity.dart';
import 'package:flutter_ijkplayer/flutter_ijkplayer.dart';
import '../author_details_page.dart';

class WorksItemWidget extends StatefulWidget {
  final Item item;
  final DataSource dataSource;

  WorksItemWidget({Key key, this.item, this.dataSource});

  @override
  State<StatefulWidget> createState() => WorksItemWidgetState();
}

class WorksItemWidgetState extends State<WorksItemWidget> {
  List<Widget> renderTags() {
    return List.generate(widget.item.data.tags.length, (index) {
      return Container(
        margin: EdgeInsets.only(top: 10),
        padding: EdgeInsets.only(left: 10, right: 10, top: 6, bottom: 6),
        child: Text(
          widget.item.data.tags[index].name,
          style: TextStyle(fontSize: 10),
        ),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(15),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(left: 15, top: 10, right: 15, bottom: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
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
                        item: widget.item,
                      ),
                    ),
                  );
                },
                child: ClipOval(
                  child: CachedNetworkImage(
                    width: 40,
                    height: 40,
                    imageUrl: widget.item.data.author.icon,
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
                        widget.item.data.author.name,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 3),
                        child: Text(
                          widget.item.data.author.description,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(0),
            child: Wrap(
              spacing: 5.0,
              alignment: WrapAlignment.spaceAround,
              children: renderTags(),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10, bottom: 10),
            child: VideoItem(
              dataSource: widget.dataSource,
            ),
          ),
          Row(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Image.asset(
                    'images/icon_like_grey.png',
                    width: 22,
                    height: 22,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 3),
                    child: Text(
                      '${widget.item.data.consumption.collectionCount}',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 30, right: 30),
                child: Row(
                  children: <Widget>[
                    Image.asset(
                      'images/icon_share_grey.png',
                      width: 22,
                      height: 22,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 3),
                      child: Text(
                        '${widget.item.data.consumption.shareCount}',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: <Widget>[
                  Image.asset(
                    'images/icon_comment_grey.png',
                    width: 22,
                    height: 22,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 3),
                    child: Text(
                      '${widget.item.data.consumption.replyCount}',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class VideoItem extends StatefulWidget {
  final DataSource dataSource;

  VideoItem({Key key, this.dataSource});

  @override
  State<StatefulWidget> createState() => VideoItemState();
}

class VideoItemState extends State<VideoItem> {
  IjkMediaController controller;

  @override
  void initState() {
    super.initState();
    controller = IjkMediaController();
    controller.setDataSource(widget.dataSource, autoPlay: false);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 220,
      child: Stack(
        children: <Widget>[
          IjkPlayer(mediaController: controller),
        ],
      ),
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
