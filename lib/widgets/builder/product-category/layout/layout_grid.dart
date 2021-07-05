import 'package:cirilla/models/models.dart';
import 'package:cirilla/types/types.dart';
import 'package:flutter/material.dart';

class LayoutGrid extends StatelessWidget {
  final List<ProductCategory> categories;
  final BuildItemProductCategoryType buildItem;
  final int column;
  final double ratio;
  final double pad;
  final EdgeInsetsDirectional padding;
  final double widthView;

  const LayoutGrid({
    Key key,
    this.categories,
    this.buildItem,
    this.column = 2,
    this.ratio = 1,
    this.pad = 0,
    this.padding = EdgeInsetsDirectional.zero,
    this.widthView = 300,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int col = column is int && column > 1 ? column : 2;
    double widthWidget = widthView - padding.end - padding.start;
    double widthItem = (widthWidget - (col - 1) * pad) / col;
    double heightItem = widthItem / ratio;

    return Padding(
      padding: padding,
      child: Wrap(
        spacing: pad,
        runSpacing: pad,
        children: List.generate(
          categories.length,
          (index) {
            return SizedBox(
              width: widthItem,
              height: heightItem,
              child: buildItem(context, category: categories[index], width: widthItem, height: null),
            );
          },
        ),
      ),
    );
  }
}
