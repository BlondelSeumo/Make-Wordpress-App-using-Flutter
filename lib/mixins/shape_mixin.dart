import 'package:flutter/material.dart';

abstract class ShapeMixin {
  ShapeBorder borderRadiusTop({double radius = 20}) {
    return RoundedRectangleBorder(
      borderRadius: BorderRadius.only(topLeft: Radius.circular(radius), topRight: Radius.circular(radius)),
    );
  }
}
