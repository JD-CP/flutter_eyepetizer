import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// model 基类
abstract class BaseModel extends ChangeNotifier {

  bool isInit;

  /// 初始化当前页
  /// true：初始化
  /// false：已初始化
  initPage({isInit = false}) {
    this.isInit = isInit;
    notifyListeners();
  }

}
