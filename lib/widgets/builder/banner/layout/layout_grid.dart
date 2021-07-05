import 'package:cirilla/types/types.dart';
import 'package:flutter/material.dart';

class LayoutGrid extends StatelessWidget {
  final int length;
  final BuildItemBannerType buildItem;
  final double pad;
  final int col;
  final double ratio;
  final EdgeInsetsDirectional padding;
  final Size size;

  const LayoutGrid({
    Key key,
    this.length = 1,
    this.buildItem,
    this.size = const Size(375, 330),
    this.pad = 0,
    this.col = 2,
    this.ratio = 1,
    this.padding = EdgeInsetsDirectional.zero,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: LayoutBuilder(
        builder: (_, BoxConstraints constraints) {
          double width = constraints?.maxWidth ?? 300;

          double widthItem = (width - (col - 1) * pad) / col;
          double heightItem = widthItem / ratio;
          double heightBuilder = (widthItem * size.height) / size.width;

          return Wrap(
            spacing: pad,
            runSpacing: pad,
            children: List.generate(
              length,
              (index) {
                return SizedBox(
                  width: widthItem,
                  height: heightItem,
                  child: buildItem(context, index: index, width: widthItem, height: heightBuilder),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
