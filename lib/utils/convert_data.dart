import 'package:cirilla/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// This is utility convert data for app
///
class ConvertData {
  /// Convert String to double
  static double stringToDouble(dynamic value, [double defaultValue = 0]) {
    if (value == null || value == "") {
      return defaultValue;
    }
    if (value is int) {
      return value.toDouble();
    }
    if (value is double) {
      return value;
    }
    return double.tryParse(value) ?? defaultValue;
  }

  /// Convert String to int
  static int stringToInt([dynamic value = '0', int initValue = 0]) {
    if (value is int) {
      return value;
    }
    if (value is double) {
      return value.toInt();
    }
    if (value is String) {
      return int.tryParse(value) ?? initValue;
    }
    return initValue;
  }

  static Color fromRgba(String rgbaString) {
    if (rgbaString == null || rgbaString == "" || rgbaString.substring(0, 5) != 'rgba(') {
      return Color(0xff000000);
    }

    List textNumber = rgbaString.substring(5, rgbaString.length - 1).split(',');
    int r = stringToInt(textNumber[0], 255);
    int g = stringToInt(textNumber[1], 255);
    int b = stringToInt(textNumber[2], 255);
    double o = stringToDouble(textNumber[3], 1);

    return Color.fromRGBO(r, g, b, o);
  }

  /// Create a color from red, green, blue, and opacity
  static Color fromRGBA(Map color, [defaultColor]) {
    if (!(color is Map<String, dynamic>) || color['r'] == null || color['g'] == null || color['b'] == null)
      return defaultColor ?? Colors.white;

    int r = color['r'].toInt();
    int g = color['g'].toInt();
    int b = color['b'].toInt();
    double a = color['a'] == null ? 1 : color['a'].toDouble();

    if (r < 0 || r > 255) return defaultColor ?? Colors.white;
    if (g < 0 || g > 255) return defaultColor ?? Colors.white;
    if (b < 0 || b > 255) return defaultColor ?? Colors.white;
    return Color.fromRGBO(r, g, b, a);
  }

  ///
  /// Convert color from hex
  static Color fromHex(String hex, [defaultColor = Colors.white]) {
    String color = hex.replaceAll('#', '0xff');
    if (color == hex) {
      return defaultColor;
    }

    return Color(int.parse(color));
  }

  static String fromColor(Color color) {
    String hex = color.value.toRadixString(16);

    return '#${hex.substring(2)}';
  }

  // Get FontWeight to string
  static FontWeight fontWeight(dynamic value) {
    if (!(value is String)) {
      return FontWeight.normal;
    }
    switch (value) {
      case '100':
        return FontWeight.w100;
        break;
      case '200':
        return FontWeight.w200;
        break;
      case '300':
        return FontWeight.w300;
        break;
      case '400':
        return FontWeight.w400;
        break;
      case '500':
        return FontWeight.w500;
        break;
      case '600':
        return FontWeight.w600;
        break;
      case '700':
        return FontWeight.w700;
        break;
      case '800':
        return FontWeight.w800;
        break;
      case '900':
        return FontWeight.w900;
        break;
      default:
        return FontWeight.normal;
    }
  }

  static TextDecoration toTextDecoration(dynamic value) {
    switch (value) {
      case 'underline':
        return TextDecoration.underline;
        break;
      case 'overline':
        return TextDecoration.overline;
        break;
      case 'line-through':
        return TextDecoration.lineThrough;
        break;
      default:
        return TextDecoration.none;
    }
  }

  // Get TextStyle to text component
  static TextStyle toTextStyle([dynamic value, String themeModeKey = 'value']) {
    TextStyle style = TextStyle();
    if (value is Map && value['style'] is Map<String, dynamic>) {
      Map<String, dynamic> styleComponent = value['style'];
      if (styleComponent['fontSize'] is String ||
          styleComponent['fontSize'] is double ||
          styleComponent['fontSize'] is int) {
        double fontSize = stringToDouble(styleComponent['fontSize']);
        style = style.copyWith(fontSize: fontSize);
      }
      if (styleComponent['color'] is Map && styleComponent['color'][themeModeKey] is Map) {
        Color color = fromRGBA(styleComponent['color'][themeModeKey]);
        style = style.copyWith(color: color);
      }
      if (styleComponent['backgroundColor'] is Map && styleComponent['backgroundColor'][themeModeKey] is Map) {
        Color background = fromRGBA(styleComponent['backgroundColor'][themeModeKey]);
        style = style.copyWith(backgroundColor: background);
      }
      if (styleComponent['fontWeight'] is String && styleComponent['fontWeight'] != '') {
        style = style.copyWith(fontWeight: fontWeight(styleComponent['fontWeight']));
      }
      if (styleComponent['textDecoration'] is String && styleComponent['fontFamily'] != '') {
        TextDecoration decoration = toTextDecoration(styleComponent['textDecoration']);
        style = style.copyWith(decoration: decoration);
      }
      if (styleComponent['letterSpacing'] is double ||
          styleComponent['letterSpacing'] is int ||
          (styleComponent['letterSpacing'] is String && styleComponent['letterSpacing'] != '')) {
        double letterSpacing = stringToDouble(styleComponent['letterSpacing']);
        if (letterSpacing >= 0) {
          style = style.copyWith(letterSpacing: letterSpacing);
        }
      }
      if (styleComponent['height'] is double ||
          styleComponent['height'] is int ||
          (styleComponent['height'] is String && styleComponent['letterSpacing'] != '')) {
        double height = stringToDouble(styleComponent['height']);
        if (height > 0) {
          style = style.copyWith(height: height);
        }
      }
      if (styleComponent['fontFamily'] is String && styleComponent['fontFamily'] != '') {
        style = GoogleFonts.getFont(styleComponent['fontFamily'], textStyle: style);
      }
    }
    return style;
  }

  static TextAlign toTextAlign(String value) {
    switch (value) {
      case 'center':
        return TextAlign.center;
        break;
      case 'right':
        return TextAlign.right;
      default:
        return TextAlign.left;
    }
  }

  static Alignment toAlignment(dynamic value) {
    switch (value) {
      case 'bottom-center':
        return Alignment.bottomCenter;
        break;
      case 'top-center':
        return Alignment.topCenter;
        break;
      case 'center-left':
        return Alignment.centerLeft;
        break;
      case 'bottom-left':
        return Alignment.bottomLeft;
        break;
      case 'center-right':
        return Alignment.centerRight;
        break;
      case 'bottom-right':
        return Alignment.bottomRight;
        break;
      case 'top-left':
        return Alignment.topLeft;
        break;
      case 'top-right':
        return Alignment.topRight;
        break;
      default:
        return Alignment.center;
    }
  }

  static String stringFromConfigs([dynamic value, String language = 'en']) {
    if (value is String) {
      return value;
    }
    if (value is Map<String, dynamic>) {
      if (value[language] is String) {
        return value[language];
      }
      if (value['text'] is String) {
        return value['text'];
      }
    }
    return '';
  }

  static String textFromConfigs([dynamic value, String languageKey = 'text']) {
    if (value is String) {
      return value;
    }
    if (value is Map<String, dynamic> && value[languageKey] is String) {
      return value[languageKey];
    }
    return '';
  }

  static String imageFromConfigs([dynamic value, String language = 'en']) {
    if (value is String) {
      return value;
    }
    if (value is Map<String, dynamic>) {
      if (value[language] is String) {
        return value[language];
      }
      if (value['src'] is String) {
        return value['src'];
      }
    }
    return '';
  }

  static EdgeInsetsDirectional space(
    Map<String, dynamic> data, [
    String key = 'padding',
    EdgeInsetsDirectional defaultValue = defaultScreenPadding,
  ]) {
    if (data == null) return defaultValue;

    return EdgeInsetsDirectional.only(
      start: ConvertData.stringToDouble(data['${key}Left']),
      end: ConvertData.stringToDouble(data['${key}Right']),
      top: ConvertData.stringToDouble(data['${key}Top']),
      bottom: ConvertData.stringToDouble(data['${key}Bottom']),
    );
  }

  static List<List> chunk([List data, int size = 2]) {
    List<List> chunks = [];
    int len = data.length;
    for (var i = 0; i < len; i += size) {
      int sizeStart = i + size;
      chunks.add(data.sublist(i, sizeStart > len ? len : sizeStart));
    }
    return chunks;
  }

  static Size toSize([Map data]) {
    double width = stringToDouble(data is Map ? data['width'] : '0');
    double height = stringToDouble(data is Map ? data['height'] : '0');
    return Size(width, height);
  }

  static BoxFit toBoxFit(String value) {
    switch (value) {
      case 'fill':
        return BoxFit.fill;
      case 'fit-width':
        return BoxFit.fitWidth;
      case 'fit-height':
        return BoxFit.fitHeight;
      case 'scale-down':
        return BoxFit.scaleDown;
      case 'contain':
        return BoxFit.contain;
      case 'none':
        return BoxFit.none;
      default:
        return BoxFit.cover;
    }
  }

  static MainAxisAlignment mainAxisAlignment(String value) {
    switch (value) {
      case 'start':
        return MainAxisAlignment.start;
      case 'end':
        return MainAxisAlignment.end;
      case 'center':
        return MainAxisAlignment.center;
      case 'spaceBetween':
        return MainAxisAlignment.spaceBetween;
      case 'spaceAround':
        return MainAxisAlignment.spaceAround;
      case 'spaceEvenly':
        return MainAxisAlignment.spaceEvenly;
      default:
        return MainAxisAlignment.values[0];
    }
  }

  static CrossAxisAlignment crossAxisAlignment(String value) {
    switch (value) {
      case 'start':
        return CrossAxisAlignment.start;
      case 'end':
        return CrossAxisAlignment.end;
      case 'center':
        return CrossAxisAlignment.center;
      case 'stretch':
        return CrossAxisAlignment.stretch;
      case 'baseline':
        return CrossAxisAlignment.baseline;
      default:
        return CrossAxisAlignment.values[0];
    }
  }

  static FloatingActionButtonLocation floatingActionButtonLocation(String value) {
    switch (value) {
      case 'startFloat':
        return FloatingActionButtonLocation.startFloat;
      case 'startTop':
        return FloatingActionButtonLocation.startTop;
      case 'startDocked':
        return FloatingActionButtonLocation.startDocked;
      case 'centerDocked':
        return FloatingActionButtonLocation.centerDocked;
      case 'centerFloat':
        return FloatingActionButtonLocation.centerFloat;
      case 'centerTop':
        return FloatingActionButtonLocation.centerTop;
      case 'endFloat':
        return FloatingActionButtonLocation.endFloat;
      case 'endDocked':
        return FloatingActionButtonLocation.endDocked;
      case 'endTop':
        return FloatingActionButtonLocation.endTop;
      case 'miniStartDocked':
        return FloatingActionButtonLocation.miniStartDocked;
      case 'miniCenterDocked':
        return FloatingActionButtonLocation.miniCenterDocked;
      case 'miniCenterFloat':
        return FloatingActionButtonLocation.miniCenterFloat;
      case 'miniCenterTop':
        return FloatingActionButtonLocation.miniCenterTop;
      case 'miniEndDocked':
        return FloatingActionButtonLocation.miniEndDocked;
      case 'miniEndFloat':
        return FloatingActionButtonLocation.miniEndFloat;
      case 'miniEndTop':
        return FloatingActionButtonLocation.miniEndTop;
      case 'miniStartFloat':
        return FloatingActionButtonLocation.miniStartFloat;
      case 'miniStartTop':
        return FloatingActionButtonLocation.miniStartTop;
      default:
        return FloatingActionButtonLocation.centerDocked;
    }
  }
}
