import 'package:cirilla/models/models.dart';
import 'package:cirilla/types/types.dart';
import 'package:flutter/material.dart';

class LayoutCarousel extends StatelessWidget {
  final List<PostCategory> categories;
  final BuildItemPostCategoryType buildItem;
  final double pad;
  final EdgeInsetsDirectional padding;

  const LayoutCarousel({
    Key key,
    this.categories,
    this.buildItem,
    this.pad = 0,
    this.padding = EdgeInsetsDirectional.zero,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: padding,
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) => buildItem(context, category: categories[index], width: null, height: null),
      separatorBuilder: (context, index) => SizedBox(width: pad),
      itemCount: categories.length,
    );
  }
}
