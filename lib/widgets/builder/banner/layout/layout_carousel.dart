import 'package:cirilla/types/types.dart';
import 'package:flutter/material.dart';

class LayoutCarousel extends StatelessWidget {
  final int length;
  final BuildItemBannerType buildItem;
  final double pad;
  final EdgeInsetsDirectional padding;
  final Size size;

  const LayoutCarousel({
    Key key,
    this.length = 1,
    this.buildItem,
    this.pad = 0,
    this.padding = EdgeInsetsDirectional.zero,
    this.size = const Size(375, 330),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: padding,
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemBuilder: (_, index) => buildItem(context, index: index, width: size.width, height: size.height),
      separatorBuilder: (_, index) => SizedBox(width: pad),
      itemCount: length,
    );
  }
}
