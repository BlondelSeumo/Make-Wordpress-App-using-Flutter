import 'package:flutter/material.dart';
import 'layout_carousel.dart';

class LayoutList extends StatelessWidget {
  final List items;
  final BuildItemType buildItem;
  final double pad;
  final EdgeInsetsDirectional padding;

  const LayoutList({
    Key key,
    this.items,
    this.buildItem,
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
          return Column(
            children: List.generate(
              items.length,
              (int index) {
                return Column(
                  children: [
                    buildItem(
                      context,
                      item: items[index],
                      width: width,
                      height: null,
                    ),
                    if (index < items.length - 1) SizedBox(height: pad)
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
