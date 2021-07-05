import 'package:flutter/material.dart';

class TimeCount extends StatelessWidget {
  final List<String> times;
  final String symbol;
  final Color? color;
  final TextStyle? textStyle;
  final EdgeInsets padding;
  final BorderRadius borderRadius;

  TimeCount({
    Key? key,
    required this.times,
    this.symbol = ":",
    this.color,
    this.textStyle,
    this.padding = EdgeInsets.zero,
    this.borderRadius = BorderRadius.zero,
  }) : super(key: key);

  factory TimeCount.itemTime({
    Key? key,
    required List<String> times,
    String symbol,
    Color? color,
    TextStyle? textStyle,
    EdgeInsets padding,
    BorderRadius borderRadius,
    double widthSeparator,
    TextStyle? symbolStyle,
    Border? border,
  }) = _TimeCountItemTime;

  @override
  Widget build(BuildContext context) {
    if (times.isEmpty) {
      return Container();
    }
    String textTime = times.toSet().join(' $symbol ');
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: color,
        borderRadius: borderRadius,
      ),
      child: Text(
        textTime,
        style: Theme.of(context).textTheme.subtitle2?.merge(textStyle),
      ),
    );
  }
}

class _TimeCountItemTime extends TimeCount {
  final double widthSeparator;
  final TextStyle? symbolStyle;
  final Border? border;

  _TimeCountItemTime({
    Key? key,
    required List<String> times,
    String symbol = ':',
    Color? color,
    TextStyle? textStyle,
    EdgeInsets padding = const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
    BorderRadius borderRadius = const BorderRadius.all(Radius.circular(4)),
    this.widthSeparator = 12,
    this.symbolStyle,
    this.border,
  }) : super(
          key: key,
          times: times,
          symbol: symbol,
          color: color,
          textStyle: textStyle,
          padding: padding,
          borderRadius: borderRadius,
        );

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    if (times.isEmpty) {
      return Container();
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var time in times) ...renderTime(value: time, theme: theme),
      ],
    );
  }

  List<Widget> renderTime({required String value, required ThemeData theme}) {
    int index = times.indexOf(value);
    TextStyle styleDefault = theme.textTheme.subtitle2 ?? TextStyle();
    Border defaultBorder =
        color != null ? Border.all(width: 2, color: color ?? theme.dividerColor) : Border.all(width: 2);
    Border borderItem = border ?? defaultBorder;

    return [
      if (index > 0)
        Container(
          constraints: BoxConstraints(minWidth: widthSeparator),
          alignment: Alignment.center,
          child: Text(
            symbol,
            style: styleDefault.merge(symbolStyle),
          ),
        ),
      Container(
        padding: padding,
        constraints: BoxConstraints(minWidth: 48),
        alignment: Alignment.center,
        decoration: BoxDecoration(color: color, borderRadius: borderRadius, border: borderItem),
        child: Text(
          value,
          style: styleDefault.merge(textStyle),
        ),
      )
    ];
  }
}
