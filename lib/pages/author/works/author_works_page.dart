import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_eyepetizer/provider/author_works_page_model.dart';
import 'package:flutter_eyepetizer/provider/provider_widget.dart';
import 'package:flutter_eyepetizer/widget/loading_widget.dart';
import 'package:provider/provider.dart';
import 'works_item_widget.dart';

/// 作者作品
class AuthorWorksPage extends StatefulWidget {
  final String apiUrl;

  AuthorWorksPage({Key key, this.apiUrl});

  @override
  State<StatefulWidget> createState() => AuthorWorksPageState();
}

class AuthorWorksPageState extends State<AuthorWorksPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ProviderWidget<AuthorWorksModel>(
      model: AuthorWorksModel(),
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
                child: AuthorWorksPageWidget(),
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

class AuthorWorksPageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AuthorWorksModel model = Provider.of(context);
    return ListView.separated(
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return WorksItemWidget(
          item: model.itemList[index],
          dataSource: model.list[index],
        );
      },
      separatorBuilder: (context, index) {
        return Divider(
          height: .5,
          color: Color(0xFFDDDDDD),

          /// indent: 前间距, endIndent: 后间距
          indent: 15,
        );
      },
      itemCount: model.itemList.length,
    );
  }
}
