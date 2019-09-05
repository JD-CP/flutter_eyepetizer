import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_eyepetizer/provider/author_issue_model.dart';
import 'package:flutter_eyepetizer/provider/provider_widget.dart';
import 'package:flutter_eyepetizer/widget/loading_widget.dart';
import 'package:provider/provider.dart';

import 'issue_item_widget.dart';

class AuthorIssuePage extends StatefulWidget {
  final String apiUrl;

  AuthorIssuePage({Key key, this.apiUrl});

  @override
  State<StatefulWidget> createState() => AuthorIssuePageState();
}

class AuthorIssuePageState extends State<AuthorIssuePage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ProviderWidget<AuthorIssueModel>(
      model: AuthorIssueModel(),
      onModelInitial: (model) {
        model.init(widget.apiUrl);
      },
      builder: (context, model, child) {
        if (model.isInit) {
          return LoadingWidget();
        }
        return EasyRefresh.custom(
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: Container(
                child: AuthorIssuePageWidget(),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class AuthorIssuePageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AuthorIssueModel model = Provider.of(context);
    return ListView.separated(
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return IssueItemWidget(
          item: model.itemList[index],
        );
      },
      separatorBuilder: (context, index) {
        return Divider(
          height: .5,
          color: Color(0xFFDDDDDD),

          /// indent: 前间距, endIndent: 后间距
          indent: 15,
          endIndent: 15,
        );
      },
      itemCount: model.itemList.length,
    );
  }
}
