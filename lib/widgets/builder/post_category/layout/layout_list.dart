import 'package:cirilla/models/models.dart';
import 'package:cirilla/types/types.dart';
import 'package:flutter/material.dart';

class LayoutList extends StatelessWidget {
  final List<PostCategory> categories;
  final BuildItemPostCategoryType buildItem;
  final double pad;
  final EdgeInsetsDirectional padding;
  final double widthView;

  const LayoutList({
    Key key,
    this.categories,
    this.buildItem,
    this.pad = 0,
    this.padding = EdgeInsetsDirectional.zero,
    this.widthView = 300,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double widthWidget = widthView - padding.end - padding.start;
    return Padding(
      padding: padding,
      child: Column(
        children: List.generate(
          categories.length,
          (int index) {
            return Column(
              children: [
                buildItem(context, category: categories[index], width: widthWidget, height: null),
                if (index < categories.length - 1) SizedBox(height: pad),
              ],
            );
          },
        ),
      ),
    );
  }
}
