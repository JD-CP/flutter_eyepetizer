import 'package:flutter_eyepetizer/provider/base_model.dart';
import 'package:flutter_eyepetizer/util/logger_util.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/// 带下拉刷新、上拉加载页的 model 基本封装
abstract class RefreshLoadMoreModel<T> extends BaseModel {
  RefreshController refreshController = RefreshController(
    initialRefresh: false,
    initialLoadStatus: LoadStatus.noMore,
  );

  /// 下一页的请求地址
  String nextPageUrl;

  /// 是否刷新
  /// 当用户首次进入页面/手动下拉刷新时 ---> true
  /// 手动上拉加载 ---> false
  bool isRefresh = true;

  List<T> dataList = [];

  init() async {
    initPage(isInit: true);
    await loadRemoteData();
  }

  Future<List<T>> loadRemoteData() async {
    try {
      var response = await loadData();

      if (isInit) {
        initPage(isInit: false);
      }

      if (isRefresh) {
        if (dataList.isNotEmpty) {
          dataList.clear();
        }
        refreshController.refreshCompleted();
        if (null != nextPageUrl && nextPageUrl.isNotEmpty) {
          refreshController.loadComplete();
        }
      } else {
        if (null != nextPageUrl && nextPageUrl.isNotEmpty) {
          refreshController.loadComplete();
        } else {
          refreshController.loadNoData();
        }
      }

      dataList.addAll(response);
      notifyListeners();

      return dataList;
    } catch (e, s) {
      LoggerUtil.instance().e("http error - $nextPageUrl ---> $s");
      refreshController.loadFailed();
      return null;
    }
  }

  Future<List<T>> loadData();

  /// 下拉刷新
  Future<List<T>> onRefresh();

  /// 上拉加载
  Future<List<T>> onLoadMore();
}
