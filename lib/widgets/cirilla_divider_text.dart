import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class CirillaDividerText extends StatelessWidget {
  final List<double> dashPattern;
  final double height;
  final double width;
  final String text;
  final Color color;
  final Color background;
  final TextStyle textStyle;

  CirillaDividerText({
    Key key,
    @required this.text,
    this.dashPattern = const [2, 4],
    this.height = 1,
    this.width,
    this.color,
    this.background,
    this.textStyle = const TextStyle(),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    double widthSize = MediaQuery.of(context).size.width;
    double widthDot = width is double && width > 0 ? width : widthSize;
    Color colorLine = color ?? theme.dividerColor;
    Color backgroundText = background ?? theme.scaffoldBackgroundColor;

    Path customPathDashed = Path()
      ..moveTo(0, 0)
      ..lineTo(widthDot, 0);

    return Stack(
      children: [
        Positioned(
          top: 0,
          bottom: 0,
          left: 0,
          right: 0,
          child: Center(
            child: DottedBorder(
              customPath: (size) => customPathDashed,
              // PathBuilder
              color: colorLine,
              dashPattern: dashPattern,
              strokeWidth: height,
              child: Container(
                height: height,
              ),
              padding: EdgeInsets.zero,
            ),
          ),
        ),
        Container(
          alignment: Alignment.center,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8),
            color: backgroundText,
            child: Text(
              text,
              style: theme.textTheme.bodyText1.merge(textStyle),
            ),
          ),
        ),
      ],
    );
  }
}
