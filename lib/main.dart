import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_eyepetizer/global/bloc/bloc.dart';
import 'package:flutter_eyepetizer/modules/splash.dart';
import 'package:flutter_eyepetizer/router/app_router.dart';
import 'package:flutter_screenutil/screenutil.dart';

// 主入口
void main() {
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
              data: ThemeData.light(),
              child: child,
            );
          },
        );
      },
    );
  }
}
