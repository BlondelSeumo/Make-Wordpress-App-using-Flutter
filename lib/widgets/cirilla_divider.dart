import 'package:flutter/material.dart';

class CirillaDivider extends StatelessWidget {
  final Color color;
  final double height;
  final double thickness;

  final Axis axis;

  const CirillaDivider({
    Key key,
    this.color,
    this.height,
    this.thickness,
    this.axis = Axis.horizontal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (axis == Axis.vertical) {
      return Container(
        width: thickness,
        color: color,
        margin: EdgeInsets.symmetric(horizontal: height),
      );
    }

    return Container(
      height: thickness,
      color: color,
      margin: EdgeInsets.symmetric(vertical: height),
    );
  }
}
