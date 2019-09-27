import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_eyepetizer/provider/author_main_page_model.dart';
import 'package:flutter_eyepetizer/pages/discovery/follow/follow_item_details_widget.dart';
import 'package:flutter_eyepetizer/provider/provider_widget.dart';
import 'package:flutter_eyepetizer/widget/loading_widget.dart';
import 'package:provider/provider.dart';

import 'collection_card.dart';
import 'video_welcom_page.dart';

/// 作者首页
class AuthorMainPage extends StatefulWidget {
  final String apiUrl;

  AuthorMainPage({Key key, this.apiUrl});

  @override
  State<StatefulWidget> createState() => AuthorMainPageState();
}

class AuthorMainPageState extends State<AuthorMainPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ProviderWidget<AuthorMainPageModel>(
      model: AuthorMainPageModel(),
      onModelInitial: (model) {
        model.init(widget.apiUrl);
      },
      builder: (context, model, child) {
        if (model.isInit) {
          return LoadingWidget();
        }
        return AuthorMainPageWidget();
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class AuthorMainPageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AuthorMainPageModel model = Provider.of(context);
    return ListView.builder(
      physics: ClampingScrollPhysics(),
      itemBuilder: (context, index) {
        var item = model.itemList[index];
        if (item.type == 'videoCollectionOfHorizontalScrollCard') {
          return CollectionCard(
            item: item,
            childIndex: index,
          );
        } else if (item.type == 'textHeader') {
          return Padding(
            padding: EdgeInsets.only(
              top: 10,
              left: 10,
              bottom: 10,
            ),
            child: Text(
              item.data.text,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        } else if (item.type == 'textFooter') {
          return Container(
            color: Colors.white,
            alignment: Alignment.centerRight,
            padding: EdgeInsets.all(10),
            child: Text(
              '${item.data.text} >',
              style: TextStyle(
                fontSize: 12,
                color: Colors.black,
              ),
            ),
          );
        } else if (item.type == 'video') {
          return VideoWelcomePage(
            item: item,
          );
        } else if (item.type == 'videoCollectionWithBrief') {
          return FollowItemDetailsWidget(
            item: item,
          );
        }
        return Text(item.type);
      },
      itemCount: model.itemList.length,
    );
  }
}
