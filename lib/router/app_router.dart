import 'package:flutter/cupertino.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter_eyepetizer/router/navigator_router.dart';
import 'package:flutter_eyepetizer/router/router_provider.dart';

class AppRouter extends InheritedWidget {
  AppRouter({Key key, Widget child}) : super(key: key, child: child) {
    // ignore: always_put_control_body_on_new_line
    if (_routerList.isNotEmpty) _routerList.clear();

    _routerList.add(NavigatorRouter());

    for (final router in _routerList) {
      router.initRouter(_router);
    }
  }

  final Router _router = Router();

  final List<RouterProvider> _routerList = [];

  static Router of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppRouter>()._router;
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;
}
