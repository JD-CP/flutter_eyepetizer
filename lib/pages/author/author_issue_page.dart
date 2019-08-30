import 'package:flutter/material.dart';

class AuthorIssuePage extends StatefulWidget {
  final String apiUrl;

  AuthorIssuePage({Key key, this.apiUrl});

  @override
  State<StatefulWidget> createState() => AuthorIssuePageState();
}

class AuthorIssuePageState extends State<AuthorIssuePage> with AutomaticKeepAliveClientMixin  {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('专辑'),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
