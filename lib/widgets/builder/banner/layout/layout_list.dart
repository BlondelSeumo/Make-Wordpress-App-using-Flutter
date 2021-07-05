import 'package:cirilla/types/types.dart';
import 'package:flutter/material.dart';

class LayoutList extends StatelessWidget {
  final int length;
  final BuildItemBannerType buildItem;
  final double pad;
  final EdgeInsetsDirectional padding;
  final Size size;

  const LayoutList({
    Key key,
    this.length = 1,
    this.buildItem,
    this.pad = 0,
    this.padding = EdgeInsetsDirectional.zero,
    this.size = const Size(375, 330),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, BoxConstraints constraints) {
        double width = constraints?.maxWidth ?? 300;
        double height = (width * size.height) / size.width;
        return ListView.separated(
          itemBuilder: (_, int index) {
            return buildItem(context, index: index, width: width, height: height);
          },
          separatorBuilder: (_, int index) => SizedBox(height: pad),
          itemCount: length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          padding: padding,
        );
      },
    );
  }
}
