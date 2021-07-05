import 'package:flutter/material.dart';

class CirillaIconOpacity extends StatelessWidget {
  final IconData iconData;
  final double iconSize;
  final Color color;
  final double opacity;
  final double size;
  final double radius;

  CirillaIconOpacity({
    Key key,
    @required this.iconData,
    this.iconSize = 22,
    this.color,
    this.opacity = 0.1,
    this.size = 48,
    this.radius,
  })  : assert(iconSize < size),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    Color colorIcon = color ?? Theme.of(context).primaryColor;
    BorderRadius borderRadius = BorderRadius.circular(radius ?? size / 2);

    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: colorIcon.withOpacity(opacity),
        borderRadius: borderRadius,
      ),
      child: Icon(iconData, size: iconSize, color: colorIcon),
    );
  }
}
