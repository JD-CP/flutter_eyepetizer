import 'package:flutter/material.dart';
import 'package:flutter_eyepetizer/entity/issue_entity.dart';
import 'package:flutter_eyepetizer/provider/author_details_model.dart';
import 'package:flutter_eyepetizer/provider/provider_widget.dart';
import 'package:flutter_eyepetizer/widget/loading_widget.dart';
import 'package:provider/provider.dart';

/// 作者详情页
class AuthorDetailsPage extends StatefulWidget {
  final Item item;

  AuthorDetailsPage({Key key, this.item});

  @override
  State<StatefulWidget> createState() => AuthorDetailsPageState();
}

class AuthorDetailsPageState extends State<AuthorDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return ProviderWidget<AuthorDetailsModel>(
      model: AuthorDetailsModel(),
      onModelInitial: (model) {
        var data = widget.item.data;
        model.init(data.author == null ? data.header.id : data.author.id);
      },
      builder: (context, model, child) {
        var data = widget.item.data;
        return DefaultTabController(
          length: model.tabItems.length,
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                data.author == null ? data.header.title : data.author.name,
              ),
              elevation: 0,
            ),
            body: AuthorDetailsPageWidget(),
          ),
        );
      },
    );
  }
}

class AuthorDetailsPageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AuthorDetailsModel model = Provider.of(context);
    if (model.isInit) {
      return LoadingWidget();
    }
    return Column(
      children: <Widget>[
        Material(
          color: Colors.white,
          child: SizedBox(
            width: double.infinity,
            height: 48,
            child: TabBar(
              tabs: model.tabItems
                  .map((tabItem) => Tab(text: tabItem.name))
                  .toList(),
              indicatorColor: Colors.black87,
              indicatorSize: TabBarIndicatorSize.label,
            ),
          ),
        ),
        Expanded(
          child: TabBarView(
            children: model.pages,
          ),
        )
      ],
    );
  }
}
