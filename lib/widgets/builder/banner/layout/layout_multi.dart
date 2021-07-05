import 'package:cirilla/types/types.dart';
import 'package:flutter/material.dart';

class LayoutMulti extends StatelessWidget {
  final int length;
  final BuildItemBannerType buildItem;
  final double pad;
  final EdgeInsetsDirectional padding;
  final Size size;

  const LayoutMulti({
    Key key,
    this.length = 1,
    this.buildItem,
    this.size = const Size(375, 330),
    this.pad = 0,
    this.padding = EdgeInsetsDirectional.zero,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: LayoutBuilder(
        builder: (_, BoxConstraints constraints) {
          double width = constraints?.maxWidth ?? 300;

          double widthItem = (width - (length - 1) * pad) / length;
          double heightBuilder = (widthItem * size.height) / size.width;

          return Wrap(
            spacing: pad,
            runSpacing: pad,
            children: List.generate(
              length,
              (index) {
                return SizedBox(
                  width: widthItem,
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
