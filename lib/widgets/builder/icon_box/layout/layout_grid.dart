import 'package:flutter/material.dart';
import 'layout_carousel.dart';

class LayoutGrid extends StatelessWidget {
  final List items;
  final BuildItemType buildItem;
  final int column;
  final double ratio;
  final double pad;
  final EdgeInsetsDirectional padding;

  const LayoutGrid({
    Key key,
    this.items,
    this.buildItem,
    this.column = 2,
    this.ratio = 1,
    this.pad = 0,
    this.padding = EdgeInsetsDirectional.zero,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: LayoutBuilder(
        builder: (_, BoxConstraints constraints) {
          double width = constraints.maxWidth;

          int col = column is int && column > 1 ? column : 2;
          double widthItem = (width - (col - 1) * pad) / col;
          double heightItem = widthItem / ratio;

          return Wrap(
            spacing: pad,
            runSpacing: pad,
            children: List.generate(
              items.length,
              (index) {
                return SizedBox(
                  width: widthItem,
                  height: heightItem,
                  child: buildItem(context, item: items[index], width: widthItem, height: heightItem),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
