import 'package:flutter/material.dart';
import 'package:flutter_eyepetizer/global/repository/local_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GlobalRepository extends ILocalRepository {
  final String _keyThemeMode = 'key_themeMode';

  @override
  Future<ThemeMode> getThemeMode() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final int index = prefs.getInt(_keyThemeMode);

    if (null == index) {
      return ThemeMode.system;
    }

    return ThemeMode.values[index];
  }
}
