import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eyepetizer/config/dimens.dart';
import 'package:flutter_eyepetizer/config/gaps.dart';
import 'package:flutter_eyepetizer/config/images.dart';
import 'package:flutter_eyepetizer/router/app_router.dart';
import 'package:flutter_eyepetizer/router/navigator_router.dart';

class SplashPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      AppRouter.of(context).navigateTo(
        context,
        NavigatorRouter.navigatorPath,
        replace: true,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: Images.splashBackGround,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              '精选视频推介，每日大开眼界',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                fontSize: Dimens.font_sp16,
                color: Colors.white,
              ),
            ),
            Gaps.vGap4,
            Text(
              'v1.0.4',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: Dimens.font_sp12,
                color: Colors.white,
              ),
            ),
            Gaps.vGap40,
          ],
        ),
      ),
    );
  }
}
