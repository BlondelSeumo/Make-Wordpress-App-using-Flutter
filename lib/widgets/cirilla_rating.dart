import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CirillaRating extends StatelessWidget {
  final double initialValue;
  final int count;
  final double size;
  final Color color;
  final Color selectColor;
  final double pad;

  CirillaRating({
    Key key,
    this.initialValue = 0,
    this.count = 5,
    this.size = 12,
    this.color,
    this.selectColor = const Color(0xFFFFA200),
    this.pad = 4,
  })  : assert(count >= 0),
        assert(size > 0),
        assert(pad >= 0),
        assert(initialValue >= 0 && initialValue <= count),
        super(key: key);

  factory CirillaRating.line({
    Key key,
    int defaultRating,
    int count,
    double size,
    double width,
    Color color,
    Color selectColor,
  }) = _CirillaRatingLine;

  factory CirillaRating.select({
    Key key,
    int defaultRating,
    int count,
    double size,
    Color color,
    Color selectColor,
    double pad,
    Function(int value) onFinishRating,
  }) = _CirillaRatingSelect;

  @override
  Widget build(BuildContext context) {
    int visit = initialValue.round();

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(count, (index) {
        IconData icon = index < visit ? FontAwesomeIcons.solidStar : FontAwesomeIcons.star;
        Color colorIcon = index < visit ? selectColor : color;
        double padRight = index <= count - 1 ? pad : 0;
        return Padding(
          padding: EdgeInsets.only(right: padRight),
          child: Icon(
            icon,
            size: size,
            color: colorIcon,
          ),
        );
      }).toList(),
    );
  }
}

class _CirillaRatingLine extends CirillaRating {
  final int defaultRating;
  final double width;

  _CirillaRatingLine({
    Key key,
    this.defaultRating = 0,
    int count,
    double size,
    Color color,
    Color selectColor,
    this.width = 255,
  }) : super(
          key: key,
          count: count ?? 5,
          size: size ?? 6,
          color: color,
          selectColor: selectColor,
        );

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return SizedBox(
      width: width,
      child: LayoutBuilder(
        builder: (_, BoxConstraints constraints) {
          double widthLine = constraints.maxWidth;
          double widthSelect = count > 0 && initialValue >= count
              ? widthLine
              : count > 0
                  ? (widthLine * initialValue) / count
                  : 0;
          return Stack(
            children: [
              Container(
                width: double.infinity,
                height: size,
                decoration:
                    BoxDecoration(color: color ?? theme.dividerColor, borderRadius: BorderRadius.circular(size / 2)),
              ),
              Container(
                width: widthSelect,
                height: size,
                decoration:
                    BoxDecoration(color: color ?? theme.primaryColor, borderRadius: BorderRadius.circular(size / 2)),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _CirillaRatingSelect extends CirillaRating {
  final int defaultRating;
  final Function(int value) onFinishRating;

  _CirillaRatingSelect({
    Key key,
    @required this.onFinishRating,
    this.defaultRating = 3,
    int count = 5,
    double size = 20,
    Color color,
    Color selectColor = const Color(0xFFFFA200),
    double pad = 4,
  })  : assert(count > 0),
        assert(size > 0),
        assert(pad >= 0),
        assert(defaultRating >= 0 && defaultRating <= count),
        super(
          key: key,
          count: count,
          size: size,
          color: color,
          selectColor: selectColor,
          pad: pad,
        );

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(count, (index) {
        IconData icon = index < defaultRating ? FontAwesomeIcons.solidStar : FontAwesomeIcons.star;
        Color colorIcon = index < defaultRating ? selectColor : color;
        double padRight = index <= count - 1 ? pad : 0;
        return Padding(
          padding: EdgeInsets.only(right: padRight),
          child: InkWell(
            onTap: () => onFinishRating(index + 1),
            child: Icon(
              icon,
              size: size,
              color: colorIcon,
            ),
          ),
        );
      }).toList(),
    );
  }
}
