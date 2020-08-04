import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_eyepetizer/global/bloc/bloc.dart';
import 'package:flutter_eyepetizer/modules/splash.dart';
import 'package:flutter_eyepetizer/router/app_router.dart';
import 'package:flutter_screenutil/screenutil.dart';

/// 主入口
void main() {
  if (Platform.isAndroid) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light,
      ),
    );
  }

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GlobalBloc(ThemeMode.light),
        ),
      ],
      child: AppRouter(
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GlobalBloc, GlobalState>(
      builder: (context, state) {
        return MaterialApp(
          themeMode: state.themeMode,
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          onGenerateRoute: AppRouter.of(context).generator,
          home: SplashPage(),
          builder: (context, child) {
            ScreenUtil.init(context, width: 375, height: 667);
            return Theme(
              data: ThemeData.light().copyWith(
                  textTheme: Theme.of(context)
                      .textTheme
                      .merge(ThemeData.light().textTheme)),
              child: child,
            );
          },
        );
      },
    );
  }
}
