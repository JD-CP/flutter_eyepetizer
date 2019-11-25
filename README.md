## flutter_eyepetizer

- 这是一款基于 Google Flutter 实现的一款仿开眼视频 App。

### 背景

从 Google 在 2018.02 的世界移动大会上正式推出首个 Flutter Beta 版，到 2018.12 的 Flutter Live 2018 上，发布 1.0 稳定版，再到现在，也差不多有 18 个月的时间了。Flutter 在 Github 上的 star、fork 量也是一路飙升，可以说，出自 Google 的 Flutter，除了自带光环，再加上它本身的众多优势，受到了众多开发者的追捧，热度只增不减。

作为一名不干寂寞的小开发，我也在去年 7 月份，果断入坑，开始 Flutter 的学习。也是略有斩获，并输出了一篇关于原生与 flutter 混合开发的文章：[Kotlin + MVP + Flutter ，让你可以在自己的项目中集成 Flutter 并使用](https://juejin.im/post/5b7cf52e51882542c963f0f1)。反响也还不错，当然也有很多考虑不足的地方。

之后的很长一段时间，我也因为工作上的变动以及一些个人原因，搁置了 flutter 的学习计划。这段时间，工作生活状态逐渐稳定之后，也继续开始了我的 flutter 学习之路。所以有了今天的主角 [仿开眼视频-flutter实现版](https://github.com/JD-CP/flutter_eyepetizer)。其实整个 App，现阶段并没有多么复杂的东西，基本用的都是 flutter 自带的 Widget，设计风格遵循 MD 规范，所以非常适合初学者学习。

### 扫码下载

- 手机扫描下方二维码，即可下载。

![](https://user-gold-cdn.xitu.io/2019/11/25/16ea0aab1e3daecd?imageView2/2/w/480/h/480/q/85/interlace/1)

### 目前实现的功能

- 首页每日精选
- 发现页 - 推荐关注、热门分类
- 热门 - 周排行、月排行、总排行
- 我的（目前是静态页，后期完善）
- 搜索页
- 热门关注列表
- 热门分类列表
- 视频详情

### 说明

项目纯属个人爱好而写，API 均来自[开眼视频](https://www.kaiyanapp.com/)，源代码仅供学习交流。

### 项目截图

- gif

![image](https://github.com/JD-CP/flutter_eyepetizer/blob/master/gif/gif_eyepetizer.gif)

### 运行方式

- 查看分支

```
flutter channel
/// 如果当前分支不是 beta，请切换至 beta 分支
flutter channel beta
```
- 切换分支过程中，会自动帮你更新至最新版。如果分支是在 beta 分支，请运行以下命令，检查是否需要安装其他依赖

```
flutter doctor
```
- 运行启动

```
flutter packages get
/// 确保设备已连接
flutter run
```

### 你能学到的东西？

- 大部分基础控件的使用，诸如：Text、Image、Icon、Scaffold、ListView、GridView、CustomScrollView、Container、Padding、Expanded、Column、Row等等...
- 下拉刷新、上拉加载。
- 布局排版，以上控件会使用之后，进行布局排版就很简单了，原则：先上后下，先左后右。
- 三方库的引入、图片的引入。
- 用户交互事件的响应。
- 页面的跳转，普通跳转、携参跳转。
- json 解析。推荐一个插件：FlutterJsonBeanFactory，使用方式自行百度吧，非常简单~
- http 请求的使用。针对 dio，做了一点简单封装，代码如下：

```
  /// 执行 get 请求
  static doGet(
    String url, {
    queryParameters,
    options,
    Function success,
    Function fail,
  }) async {
    print('http request url: $url');
    try {
      Response response = await buildDio().get(
        url,
        queryParameters: queryParameters,
        options: _options,
      );
      success(response);
      print('http response: $response');
    } catch (exception) {
      fail(exception);
      print('http request fail: $url --- $exception');
    }
  }
```

### 用到的三方库

- [dio](https://github.com/flutterchina/dio)  强大的 Http 请求库。
- [cached_network_image](https://github.com/renefloor/flutter_cached_network_image)  更加灵活方便的图片加载框架。
- [fluttertoast](https://github.com/PonnamKarthik/FlutterToast) 吐司。
- [flustars](https://github.com/Sky24n/flustars)  常用工具类。
- [device_info](https://github.com/flutter/plugins) Flutter 插件。
- [flutter_ijkplayer](https://github.com/CaiJingLong/flutter_ijkplayer) 视频播放。
- [flutter_easyrefresh](https://github.com/xuelongqy/flutter_easyrefresh) 下拉刷新、上拉加载。
- [shimmer](https://github.com/hnvn/flutter_shimmer) 闪亮亮哈哈哈。
- [provider](https://github.com/rrousselGit/provider) 非常好用的状态管理框架，会让你的代码清爽很多。

### 版本更新

- 1.0.4 - 2019.09.27
```
1. 部分页面视频播放无效问题解决。
2. 作者详情页UI展示优化，增加作者信息展示。
```

- 1.0.3 - 2019.09.14
```
1. 系统搜索栏样式更改。
2. 部分页面 UI 呈现效果优化。
3. 部分 bug 修复。
```

- 1.0.2 - 2019.09.06
```
1. 代码优化，Provider 应用及简单封装。
2. 下拉刷新、上拉加载风格改变。
3. 加载中视图状态优化。
```

- 1.0.1 - 2019.08.30

```
作者信息详情页完善
```

- 1.0.0 - 2019.08.23

```
基础功能完成
```

### 后续计划

会有新功能的添加，更多的是针对现在项目的缺点，所进行的优化。

- 优化UI体验效果，增加错误页面展示。
- Provider 封装优化。
- 屏幕适配，非常有必要！。
- 和 native 混合开发提上日程。

### 最后

如果您和我一样，喜欢技术，喜欢 Flutter，可以关注此项目，赏个star。我闲暇时间，也尽可能快的更新。
