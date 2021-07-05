import 'package:cirilla/types/types.dart';
import 'package:cirilla/models/models.dart';
import 'package:flutter/material.dart';

class LayoutMasonry extends StatelessWidget {
  final List<ProductCategory> categories;
  final BuildItemProductCategoryType buildItem;
  final double pad;
  final EdgeInsetsDirectional padding;
  final double widthView;

  LayoutMasonry({
    Key key,
    this.categories,
    this.buildItem,
    this.pad,
    this.padding = EdgeInsetsDirectional.zero,
    this.widthView = 300,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<int> listLeft = [];
    List<int> listRight = [];

    for (var i = 0; i < categories.length; i++) {
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
    double widthWidget = widthView - padding.end - padding.start;
    double width = (widthWidget - pad) / 2;
    double height = width;
    return Column(
      children: List.generate(
        items.length,
        (int index) {
          double newHeight = height;

          if (index % 2 == mod) {
            newHeight = height * 0.8;
          }

          return Column(
            children: [
              buildItem(
                context,
                category: categories[items[index]],
                height: newHeight,
                width: width,
              ),
              SizedBox(height: pad),
            ],
          );
        },
      ),
    );
  }
}
