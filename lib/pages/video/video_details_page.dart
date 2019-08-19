import 'package:flutter/material.dart';
import 'package:flutter_ijkplayer/flutter_ijkplayer.dart';

class VideoDetailsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => VideoDetailsState();
}

class VideoDetailsState extends State<VideoDetailsPage> {
  IjkMediaController _controller = IjkMediaController();

  @override
  void initState() {
    super.initState();
    _controller.setNetworkDataSource(
        'http://baobab.kaiyanapp.com/api/v1/playUrl?vid=170038&resourceType=video&editionType=high&source=aliyun&playUrlType=url_oss',
        autoPlay: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('视频详情'),
        centerTitle: true,
      ),
      body: Container(
        height: 260,
        child: IjkPlayer(mediaController: _controller),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
