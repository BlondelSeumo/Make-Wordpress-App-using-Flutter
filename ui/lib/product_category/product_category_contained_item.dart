import 'package:flutter/material.dart';
import 'product_category_item.dart';

class ProductCategoryContainedItem extends ProductCategoryItem {
  final Widget? image;
  final Widget? name;
  final Widget? count;
  final Function onClick;
  final double width;
  final double? elevation;
  final Color? shadowColor;
  final ShapeBorder? shape;
  final Color? color;

  const ProductCategoryContainedItem({
    Key? key,
    this.name,
    required this.onClick,
    this.image,
    this.count,
    this.width = 109,
    this.elevation,
    this.color = Colors.transparent,
    this.shadowColor,
    this.shape,
  }) : super(
          key: key,
          elevation: elevation,
          color: color,
          shadowColor: shadowColor,
          shape: shape,
        );

  @override
  Widget buildLayout(BuildContext context) {
    return SizedBox(
      width: width,
      child: InkWell(
        onTap: () => onClick(),
        child: Column(
          children: [
            image ?? Container(),
            if (image != null && (name != null || count != null)) SizedBox(height: 8),
            Container(
              width: double.infinity,
              child: name,
            ),
            Container(
              width: double.infinity,
              child: count ?? Container(),
            )
          ],
        ),
      ),
    );
  }
}
