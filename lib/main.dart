import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter_eyepetizer/pages/splash/splash_page.dart';
import 'package:flutter_eyepetizer/router/router_manager.dart';

// 主入口
void main() {
  Router router = new Router();
  RouterManager.configureRouter(router);
  RouterManager.router = router;

  runApp(
    MyApp(),
  );
  SystemUiOverlayStyle systemUiOverlayStyle =
      SystemUiOverlayStyle(statusBarColor: Colors.transparent);
  SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color(0xFFFFFFFF),
      ),
      onGenerateRoute: RouterManager.router.generator,
    );
  }
}
