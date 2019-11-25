import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eyepetizer/pages/author/author_details_page.dart';
import 'package:flutter_eyepetizer/pages/bottom_navigator.dart';
import 'package:flutter_eyepetizer/pages/discovery/category/category_list_page.dart';
import 'package:flutter_eyepetizer/pages/discovery/follow/follow_list_page.dart';
import 'package:flutter_eyepetizer/pages/splash/splash_page.dart';
import 'package:flutter_eyepetizer/pages/video/video_details_page.dart';

class RouterManager {
  static Router router;

  /// 启动/欢迎页
  static const String splash = "/";

  /// 底部导航
  static const String navigator = "/navigator";

  /// 视频详情
  static const String video = "/video";

  /// 热门分类
  static const String category = "/category";

  /// 推荐关注
  static const String follow = "/follow";

  /// 作者详情
  static const String author = "/author";

  static void configureRouter(Router router) {
    router.notFoundHandler = new Handler(
        // ignore: missing_return
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      print("ROUTE WAS NOT FOUND !!!");
    });

    router.define(splash, handler: new Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return SplashPage();
    }));
    router.define(navigator, handler: new Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return BottomNavigator();
    }));
    router.define(video, handler: new Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      String itemJson = params['itemJson']?.first;
      return VideoDetailsPage(
        itemJson: itemJson,
      );
    }));
    router.define(category, handler: new Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      String itemJson = params['itemJson']?.first;
      return CategoryListPage(
        itemJson: itemJson,
      );
    }));
    router.define(follow, handler: new Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return FollowListPage();
    }));
    router.define(author, handler: new Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      String itemJson = params['itemJson']?.first;
      return AuthorDetailsPage(
        itemJson: itemJson,
      );
    }));
  }
}
