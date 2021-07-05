import 'package:flutter/material.dart';

import 'grid.dart';

class OneColumn extends Grid {
  final int itemCount;
  final double axisSpacing;
  final Widget Function(BuildContext context, int index, double width) buildItem;

  OneColumn({
    Key key,
    this.itemCount,
    this.axisSpacing,
    @required this.buildItem,
  }) : super(
          key: key,
          itemCount: itemCount,
          crossAxisCount: 1,
          axisSpacing: axisSpacing,
        );

  @override
  Widget buildLayout(BuildContext context, int index, double width) {
    return buildItem(context, index, width);
  }
}
