import 'package:flutter/material.dart';

abstract class ILocalRepository {
  Future<ThemeMode> getThemeMode();
}
