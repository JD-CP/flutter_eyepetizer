import 'package:flutter/cupertino.dart' show CupertinoThemeData;
import 'package:flutter/material.dart';
import 'package:flutter_eyepetizer/config/dimens.dart';

class DefaultThemeData {
  static const Color _primary = Colors.white;
  static const Color _dark_primary = Colors.white;

  static const Color _surface = Color(0xFFFFFFFF);
  static const Color _dark_surface = Color(0xFF282828);

  static const Color _on_surface = Color(0xFF8C8C8C);
  static const Color _on_dark_surface = Color(0xFF696969);

  static const Color _background = Color(0xFFF8F8F8);
  static const Color _dark_background = Color(0xFF1B1B1B);

  static const Color _on_background = Color(0xFF8C8C8C);
  static const Color _on_dark_background = Color(0xFF8C8C8C);

  static const Color _divider_line = Color(0xFFF0F0F0);
  static const Color _divider_dark_line = Color(0xFF3B3B3B);

  static ThemeData dark() {
    final darkThemeData = ThemeData.dark();
    final colorSchema = darkThemeData.colorScheme.copyWith(
      primary: _dark_primary,
      surface: _dark_surface,
      background: _dark_background,
      onSurface: _on_dark_surface,
      onBackground: _on_dark_background,
    );
    return darkThemeData.copyWith(
      colorScheme: colorSchema,
      accentColor: colorSchema.onPrimary,
      scaffoldBackgroundColor: colorSchema.background,
      primaryColorBrightness: Brightness.dark,
      cupertinoOverrideTheme: CupertinoThemeData(
        brightness: Brightness.dark,
      ),
      primaryIconTheme: darkThemeData.iconTheme.copyWith(
        color: colorSchema.onSurface,
      ),
      iconTheme: darkThemeData.iconTheme.copyWith(
        color: colorSchema.onSurface,
      ),
      appBarTheme: darkThemeData.appBarTheme.copyWith(
        centerTitle: true,
        brightness: Brightness.dark,
        color: colorSchema.surface,
        elevation: 0,
        iconTheme: darkThemeData.iconTheme.copyWith(
          color: Color(0xFFA8A8A8),
        ),
        actionsIconTheme: darkThemeData.iconTheme.copyWith(
          color: Color(0xFF8C8C8C),
        ),
        textTheme: TextTheme(
          headline6: darkThemeData.textTheme.headline6.copyWith(
            fontSize: Dimens.font_sp10 * 2,
            fontWeight: FontWeight.w500,
            color: Color(0xFFA8A8A8),
          ),
          button: darkThemeData.textTheme.button.copyWith(
            fontSize: 16,
            color: colorSchema.primary,
            fontWeight: FontWeight.w400,
          ),
          caption: darkThemeData.textTheme.caption.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Color(0xFF8C8C8C),
          ),
        ),
      ),
      tabBarTheme: darkThemeData.tabBarTheme.copyWith(
        indicator: UnderlineTabIndicator(
          borderSide:
              BorderSide(width: Dimens.gap_dp2, color: colorSchema.onPrimary),
        ),
        indicatorSize: TabBarIndicatorSize.label,
        labelColor: colorSchema.onPrimary,
        labelStyle: TextStyle(
          fontSize: Dimens.font_sp16,
        ),
        labelPadding:
            EdgeInsets.only(top: Dimens.gap_dp8, bottom: Dimens.gap_dp10),
        unselectedLabelColor: colorSchema.onSurface,
        unselectedLabelStyle: TextStyle(
          fontSize: Dimens.font_sp16,
        ),
      ),
      accentTextTheme: darkThemeData.textTheme.copyWith(
        headline6: darkThemeData.textTheme.headline6.copyWith(
          color: colorSchema.onPrimary,
        ),
      ),
      unselectedWidgetColor: Color(0xFF696969),
      toggleableActiveColor: _primary,
      dividerColor: _divider_dark_line,
      dividerTheme: DividerThemeData(
        color: _divider_dark_line,
        space: Dimens.gap_dp1,
      ),
      textTheme: darkThemeData.textTheme.copyWith(
        subtitle1: darkThemeData.textTheme.subtitle1.copyWith(
          fontSize: Dimens.font_sp16,
          fontWeight: FontWeight.w500,
          color: Color(0xFFE7E7E7),
        ),
        subtitle2: darkThemeData.textTheme.subtitle2.copyWith(
          fontSize: Dimens.font_sp16,
          fontWeight: FontWeight.w400,
          color: Color(0xFFE7E7E7),
        ),
        bodyText1: darkThemeData.textTheme.bodyText1.copyWith(
          fontSize: Dimens.font_sp16,
          fontWeight: FontWeight.w400,
          color: Color(0xFFE7E7E7),
        ),
        bodyText2: darkThemeData.textTheme.bodyText1.copyWith(
          fontSize: Dimens.font_sp14,
          fontWeight: FontWeight.w400,
          color: Color(0xFFE7E7E7),
        ),
        button: darkThemeData.textTheme.button.copyWith(
          fontSize: Dimens.font_sp16,
          fontWeight: FontWeight.w400,
          color: Color(0xFFFFFFFF),
        ),
        caption: darkThemeData.textTheme.caption.copyWith(
          fontSize: Dimens.font_sp12,
          fontWeight: FontWeight.w400,
          color: Color(0xFF8C8C8C),
        ),
      ),
    );
  }

  static ThemeData light() {
    final lightThemeData = ThemeData.light();
    final colorSchema = lightThemeData.colorScheme.copyWith(
      primary: _primary,
      surface: _surface,
      background: _background,
      onSurface: _on_surface,
      onBackground: _on_background,
    );
    return lightThemeData.copyWith(
      colorScheme: colorSchema,
      accentColor: colorSchema.primary,
      scaffoldBackgroundColor: colorSchema.background,
      primaryColorBrightness: Brightness.light,
      cupertinoOverrideTheme: CupertinoThemeData(
        brightness: Brightness.light,
      ),
      primaryIconTheme: lightThemeData.primaryIconTheme.copyWith(
        color: colorSchema.onSurface,
      ),
      iconTheme: lightThemeData.iconTheme.copyWith(
        color: colorSchema.onSurface,
      ),
      appBarTheme: lightThemeData.appBarTheme.copyWith(
        centerTitle: true,
        brightness: Brightness.light,
        color: colorSchema.surface,
        elevation: 0,
        iconTheme: lightThemeData.iconTheme.copyWith(
          color: Color(0xFF595959),
        ),
        actionsIconTheme: lightThemeData.iconTheme.copyWith(
          color: colorSchema.primary,
        ),
        textTheme: TextTheme(
          headline6: lightThemeData.textTheme.headline6.copyWith(
            fontSize: Dimens.font_sp10 * 2,
            fontWeight: FontWeight.w500,
            color: Color(0xFF595959),
          ),
          button: lightThemeData.textTheme.button.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: colorSchema.primary,
          ),
          caption: lightThemeData.textTheme.caption.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Color(0xFF8C8C8C),
          ),
        ),
      ),
      tabBarTheme: lightThemeData.tabBarTheme.copyWith(
        indicator: UnderlineTabIndicator(
          borderSide:
              BorderSide(width: Dimens.gap_dp2, color: colorSchema.primary),
        ),
        indicatorSize: TabBarIndicatorSize.label,
        labelColor: colorSchema.primary,
        labelStyle: TextStyle(
          fontSize: Dimens.font_sp16,
        ),
        labelPadding:
            EdgeInsets.only(top: Dimens.gap_dp8, bottom: Dimens.gap_dp10),
        unselectedLabelColor: colorSchema.onSurface,
        unselectedLabelStyle: TextStyle(
          fontSize: Dimens.font_sp16,
        ),
      ),
      accentTextTheme: lightThemeData.textTheme.copyWith(
        headline6: lightThemeData.textTheme.headline6.copyWith(
          fontSize: Dimens.font_sp18,
          fontWeight: FontWeight.w500,
          color: colorSchema.onPrimary,
        ),
      ),
      unselectedWidgetColor: Color(0xFFBFBFBF),
      toggleableActiveColor: _primary,
      dividerColor: _divider_line,
      dividerTheme: DividerThemeData(
        color: _divider_line,
        space: Dimens.gap_dp1,
      ),
      textTheme: lightThemeData.textTheme.copyWith(
        subtitle1: lightThemeData.textTheme.subtitle1.copyWith(
          fontSize: Dimens.font_sp16,
          fontWeight: FontWeight.w500,
          color: Color(0xFF262626),
        ),
        subtitle2: lightThemeData.textTheme.subtitle2.copyWith(
          fontSize: Dimens.font_sp16,
          fontWeight: FontWeight.w400,
          color: Color(0xFF262626),
        ),
        bodyText1: lightThemeData.textTheme.bodyText1.copyWith(
          fontSize: Dimens.font_sp16,
          fontWeight: FontWeight.w400,
          color: Color(0xFF262626),
        ),
        bodyText2: lightThemeData.textTheme.bodyText2.copyWith(
          fontSize: Dimens.font_sp14,
          fontWeight: FontWeight.w400,
          color: Color(0xFF595959),
        ),
        button: lightThemeData.textTheme.button.copyWith(
          fontSize: Dimens.font_sp16,
          fontWeight: FontWeight.w400,
          color: Color(0xFF8C8C8C),
        ),
        caption: lightThemeData.textTheme.caption.copyWith(
          fontSize: Dimens.font_sp12,
          fontWeight: FontWeight.w400,
          color: Color(0xFF8C8C8C),
        ),
      ),
    );
  }
}
