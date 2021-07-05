import 'package:flutter/material.dart';

import 'layout_carousel.dart';

class LayoutMasonry extends StatelessWidget {
  final List items;
  final BuildItemType buildItem;
  final double pad;
  final EdgeInsetsDirectional padding;

  LayoutMasonry({
    Key key,
    this.items,
    this.buildItem,
    this.pad,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<int> listLeft = [];
    List<int> listRight = [];

    for (var i = 0; i < items.length; i++) {
      if (i % 2 == 0) {
        listLeft.add(i);
      } else {
        listRight.add(i);
      }
    }

    return Padding(
      padding: padding,
      child: LayoutBuilder(
        builder: (_, BoxConstraints constraints) {
          double width = constraints.maxWidth;
          double widthItem = (width - pad) / 2;

          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _buildList(context, list: listLeft, width: widthItem, mod: 0)),
              SizedBox(width: pad),
              Expanded(child: _buildList(context, list: listRight, width: widthItem)),
            ],
          );
        },
      ),
    );
  }

  Widget _buildList(context, {List<int> list, double width, int mod = 1}) {
    double widthItem = width;
    double heightItem = width;

    return Column(
      children: List.generate(
        list.length,
        (int index) {
          double newHeight = heightItem;

          if (index % 2 == mod) {
            newHeight = heightItem * 0.8;
          }

          return Column(
            children: [
              buildItem(
                context,
                item: items[list[index]],
                height: newHeight,
                width: widthItem,
              ),
              if (index < list.length - 1) SizedBox(height: pad)
            ],
          );
        },
      ),
    );
  }
}
