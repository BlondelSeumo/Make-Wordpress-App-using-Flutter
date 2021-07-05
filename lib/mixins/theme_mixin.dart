import 'package:cirilla/constants/strings.dart';
import 'package:cirilla/models/setting/setting.dart';
import 'package:cirilla/store/setting/setting_store.dart';
import 'package:cirilla/utils/convert_data.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'utility_mixin.dart' show get;

class ThemeMixin {
  Color _cv(Map<String, dynamic> color, [defaultColor]) => ConvertData.fromRGBA(color, defaultColor);

  ThemeData buildTheme(SettingStore store) {
    final ThemeData base = store.darkMode ? ThemeData.dark() : ThemeData.light();

    if (store.data == null) return base;

    final WidgetConfig widgetConfig = store.data.settings['theme'].widgets['theme'];
    final Map<String, dynamic> fields = widgetConfig.fields;

    // Typography
    String fontFamily = get(fields, ['fontFamily'], Strings.fontFamily);
    String fontFamilyBody = get(fields, ['fontFamilyBody'], Strings.fontFamily);
    Color displayColor = _cv(get(fields, ['displayColor', store.themeModeKey]), Colors.black);
    Color bodyColor = _cv(get(fields, ['bodyColor', store.themeModeKey]), Colors.black);

    // Text theme body
    TextTheme textTheme = GoogleFonts.getTextTheme(fontFamilyBody);

    // Colors Schema
    ColorScheme baseSchema = base.colorScheme;

    Color primary = _cv(get(fields, ['primary', store.themeModeKey]), baseSchema.primary);

    ColorScheme _cirillaColorScheme = ColorScheme(
      primary: primary,
      primaryVariant: _cv(get(fields, ['primaryVariant', store.themeModeKey]), baseSchema.primaryVariant),
      secondary: _cv(get(fields, ['secondary', store.themeModeKey]), baseSchema.secondary),
      secondaryVariant: _cv(get(fields, ['secondaryVariant', store.themeModeKey]), baseSchema.secondaryVariant),
      surface: _cv(get(fields, ['surface', store.themeModeKey]), baseSchema.surface),
      background: _cv(get(fields, ['background', store.themeModeKey]), baseSchema.background),
      error: _cv(get(fields, ['error', store.themeModeKey]), baseSchema.error),
      onPrimary: _cv(get(fields, ['onPrimary', store.themeModeKey]), baseSchema.onPrimary),
      onSecondary: _cv(get(fields, ['onSecondary', store.themeModeKey]), baseSchema.onSecondary),
      onSurface: _cv(get(fields, ['onSurface', store.themeModeKey]), baseSchema.onSurface),
      onBackground: _cv(get(fields, ['onBackground', store.themeModeKey]), baseSchema.onBackground),
      onError: _cv(get(fields, ['onError', store.themeModeKey]), baseSchema.onError),
      brightness: store.darkMode ? Brightness.dark : Brightness.light,
    );

    // Appbar
    Color appbarBackgroundColor = _cv(get(fields, ['appBarBackgroundColor', store.themeModeKey]), Colors.black);
    Color appBarIconColor = _cv(get(fields, ['appBarIconColor', store.themeModeKey]), Colors.white);

    Color appBarTextColor = _cv(get(fields, ['appBarTextColor', store.themeModeKey]), Colors.black);

    Color appBarShadowColor = _cv(get(fields, ['appBarShadowColor', store.themeModeKey]), Colors.black);

    double appBarElevation = ConvertData.stringToDouble(get(fields, ['appBarElevation'], 4));

    // Scaffold
    Color scaffoldBackgroundColor = _cv(get(fields, ['scaffoldBackgroundColor', store.themeModeKey]), Colors.black);

    // Text Fields
    String textFieldsType = get(fields, ['textFieldsType'], 'filled');
    double textFieldsBorderRadius = ConvertData.stringToDouble(get(fields, ['textFieldsBorderRadius'], 8));
    double textFieldsBorderWidth = ConvertData.stringToDouble(get(fields, ['textFieldsBorderWidth'], 1));
    Color textFieldsBorderColor = _cv(get(fields, ['textFieldsBorderColor', store.themeModeKey]), Colors.black);

    double textFieldsLabelFontSize = ConvertData.stringToDouble(get(fields, ['textFieldsLabelFontSize'], 14));
    int textFieldsLabelFontWeight = ConvertData.stringToInt(get(fields, ['textFieldsLabelFontWeight'], 3));

    double textFieldsPaddingLeft =
        ConvertData.stringToDouble(get(fields, ['textFieldsPadding', 'textFieldsPaddingLeft'], 0), 0);
    double textFieldsPaddingRight =
        ConvertData.stringToDouble(get(fields, ['textFieldsPadding', 'textFieldsPaddingRight'], 0), 0);
    double textFieldsPaddingBottom =
        ConvertData.stringToDouble(get(fields, ['textFieldsPadding', 'textFieldsPaddingBottom'], 0), 0);
    double textFieldsPaddingTop =
        ConvertData.stringToDouble(get(fields, ['textFieldsPadding', 'textFieldsPaddingTop'], 0), 0);

    // Divider
    Color dividerColor = _cv(get(fields, ['dividerColor', store.themeModeKey]), Colors.black);

    // Full theme all app
    TextTheme _textTheme = _buildTextTheme(textTheme, fontFamily, fontFamilyBody, displayColor, bodyColor);

    return base.copyWith(
      colorScheme: _cirillaColorScheme,
      scaffoldBackgroundColor: scaffoldBackgroundColor,
      textTheme: _textTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: appbarBackgroundColor,
        iconTheme: _customIconTheme(base.iconTheme, appBarIconColor),
        textTheme: TextTheme(
          headline6: _textTheme.headline6.copyWith(fontWeight: FontWeight.w500, fontSize: 16, color: appBarTextColor),
        ),
        shadowColor: appBarShadowColor,
        elevation: appBarElevation,
      ),
      inputDecorationTheme: base.inputDecorationTheme.copyWith(
        border: textFieldsType == 'filled'
            ? UnderlineInputBorder(
                borderRadius: BorderRadius.circular(textFieldsBorderRadius),
                borderSide: BorderSide(color: textFieldsBorderColor, width: textFieldsBorderWidth),
              )
            : OutlineInputBorder(
                borderRadius: BorderRadius.circular(textFieldsBorderRadius),
                borderSide: BorderSide(color: textFieldsBorderColor, width: textFieldsBorderWidth),
              ),
        labelStyle:
            TextStyle(fontWeight: FontWeight.values[textFieldsLabelFontWeight], fontSize: textFieldsLabelFontSize),
        contentPadding: EdgeInsetsDirectional.only(
          start: textFieldsPaddingLeft,
          end: textFieldsPaddingRight,
          top: textFieldsPaddingTop,
          bottom: textFieldsPaddingBottom,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
        ),
      ),
      dividerColor: dividerColor,
      primaryColor: primary,
    );
  }

  TextTheme _buildTextTheme(TextTheme base, String fontFamily, fontFamilyBody, displayColor, bodyColor) {
    return base.copyWith(
      headline1: GoogleFonts.getFont(
        fontFamily,
        textStyle: base.headline1.copyWith(
          color: displayColor,
        ),
      ),
      headline2: GoogleFonts.getFont(
        fontFamily,
        textStyle: base.headline2.copyWith(
          color: displayColor,
        ),
      ),
      headline3: GoogleFonts.getFont(
        fontFamily,
        textStyle: base.headline3.copyWith(
          color: displayColor,
        ),
      ),
      headline4: GoogleFonts.getFont(
        fontFamily,
        textStyle: base.headline4.copyWith(
          color: displayColor,
        ),
      ),
      headline5: GoogleFonts.getFont(
        fontFamily,
        textStyle: base.headline5.copyWith(
          color: displayColor,
        ),
      ),
      headline6: GoogleFonts.getFont(
        fontFamily,
        textStyle: base.headline6.copyWith(
          color: displayColor,
        ),
        fontWeight: FontWeight.w500,
      ),
      subtitle1: GoogleFonts.getFont(
        fontFamilyBody,
        textStyle: base.subtitle2.copyWith(
          color: displayColor,
        ),
        fontWeight: FontWeight.w500,
      ),
      subtitle2: GoogleFonts.getFont(
        fontFamilyBody,
        textStyle: base.subtitle2.copyWith(
          color: displayColor,
        ),
        fontWeight: FontWeight.w500,
      ),
      button: GoogleFonts.getFont(
        fontFamilyBody,
        textStyle: base.button.copyWith(
          color: displayColor,
        ),
        fontWeight: FontWeight.w500,
        fontSize: 14,
      ),
      bodyText1: base.bodyText1.copyWith(color: bodyColor, fontSize: 16),
      bodyText2: base.bodyText1.copyWith(color: bodyColor, fontSize: 14),
      caption: GoogleFonts.getFont(
        fontFamilyBody,
        textStyle: base.caption.copyWith(
          color: bodyColor,
        ),
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
        fontSize: 12,
      ),
      overline: GoogleFonts.getFont(
        fontFamilyBody,
        textStyle: base.overline.copyWith(
          color: bodyColor,
        ),
        fontWeight: FontWeight.w500,
        letterSpacing: 0,
        fontSize: 10,
      ),
    );
  }

  IconThemeData _customIconTheme(IconThemeData original, Color appBarIconColor) {
    return original.copyWith(color: appBarIconColor);
  }
}
