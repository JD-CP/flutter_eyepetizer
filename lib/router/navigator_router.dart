import 'package:flutter_eyepetizer/modules/bottom_navigator.dart';
import 'package:flutter_eyepetizer/router/router_provider.dart';
import 'package:fluro/fluro.dart';

class NavigatorRouter extends RouterProvider {
  static String navigatorPath = '/navigator';

  @override
  void initRouter(Router router) {
    router.define(
      navigatorPath,
      handler: Handler(
        handlerFunc: (context, params) {
          return BottomNavigator();
        },
      ),
    );
  }
}
