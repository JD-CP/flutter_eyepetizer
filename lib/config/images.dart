import 'package:flutter/cupertino.dart';
import 'package:flutter_eyepetizer/config/dimens.dart';

class Images {
  static const splashBackGround = AssetImage('images/bg_splash.png');

  static final tabHomeNormal = Image.asset(
    'images/ic_home_normal.png',
    width: Dimens.gap_dp2 * 11,
    height: Dimens.gap_dp2 * 11,
  );
  static final tabHomeSelected = Image.asset(
    'images/ic_home_selected.png',
    width: Dimens.gap_dp2 * 11,
    height: Dimens.gap_dp2 * 11,
  );

  static final tabDiscoveryNormal = Image.asset(
    'images/ic_discovery_normal.png',
    width: Dimens.gap_dp2 * 11,
    height: Dimens.gap_dp2 * 11,
  );
  static final tabDiscoverySelected = Image.asset(
    'images/ic_discovery_selected.png',
    width: Dimens.gap_dp2 * 11,
    height: Dimens.gap_dp2 * 11,
  );

  static final tabHotNormal = Image.asset(
    'images/ic_hot_normal.png',
    width: Dimens.gap_dp2 * 11,
    height: Dimens.gap_dp2 * 11,
  );
  static final tabHotSelected = Image.asset(
    'images/ic_hot_normal.png',
    width: Dimens.gap_dp2 * 11,
    height: Dimens.gap_dp2 * 11,
  );

  static final tabMineNormal = Image.asset(
    'images/ic_mine_normal.png',
    width: Dimens.gap_dp2 * 11,
    height: Dimens.gap_dp2 * 11,
  );
  static final tabMineSelected = Image.asset(
    'images/ic_mine_selected.png',
    width: Dimens.gap_dp2 * 11,
    height: Dimens.gap_dp2 * 11,
  );
}
