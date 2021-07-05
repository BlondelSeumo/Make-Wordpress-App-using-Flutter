import 'package:cirilla/types/types.dart';
import 'package:flutter/material.dart';

class LayoutMasonry extends StatelessWidget {
  final int length;
  final BuildItemBannerType buildItem;
  final double pad;
  final EdgeInsetsDirectional padding;
  final Size size;

  LayoutMasonry({
    Key key,
    this.length = 1,
    this.buildItem,
    this.size = const Size(375, 330),
    this.pad = 0,
    this.padding = EdgeInsetsDirectional.zero,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<int> listLeft = [];
    List<int> listRight = [];

    for (var i = 0; i < length; i++) {
      if (i % 2 == 0) {
        listLeft.add(i);
      } else {
        listRight.add(i);
      }
    }

    return Padding(
      padding: padding,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: _buildList(context, items: listLeft, mod: 0)),
          SizedBox(width: pad),
          Expanded(child: _buildList(context, items: listRight)),
        ],
      ),
    );
  }

  Widget _buildList(context, {List<int> items, int mod = 1}) {
    return LayoutBuilder(
      builder: (_, BoxConstraints constraints) {
        double widthItem = constraints?.maxWidth ?? 150;
        double heightItemDefault = (widthItem * size.height) / size.width;
        return ListView.separated(
          itemBuilder: (_, int index) {
            double newHeight = heightItemDefault;

            if (index % 2 == mod) {
              newHeight = heightItemDefault * 0.8;
            }
            return buildItem(context, index: items[index], width: widthItem, height: newHeight);
          },
          separatorBuilder: (_, int index) => SizedBox(height: pad),
          itemCount: items.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
        );
      },
    );
  }
}
