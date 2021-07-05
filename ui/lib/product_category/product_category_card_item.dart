import 'package:flutter/material.dart';
import 'product_category_item.dart';

class ProductCategoryCardItem extends ProductCategoryItem {
  /// Widget image
  final Widget? image;

  /// Widget name. It must required
  final Widget name;

  /// Widget count items
  final Widget? count;

  /// Widget padding
  final EdgeInsets padding;

  /// Function click item
  final Function onClick;

  /// ShapeBorder of item post
  final ShapeBorder? shape;

  /// Elevation fro shadow card
  final double? elevation;

  /// Color shadow card
  final Color? shadowColor;

  /// Color Card of item category
  final Color? color;

  /// Type
  final String type;

  ProductCategoryCardItem({
    Key? key,
    this.image,
    required this.name,
    this.count,
    this.padding = const EdgeInsets.all(16),
    required this.onClick,
    this.shape = const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
    this.elevation,
    this.shadowColor,
    this.color,
    this.type = 'default',
  }) : super(
          key: key,
          shape: shape,
          elevation: elevation,
          shadowColor: shadowColor,
          color: color,
        );
  @override
  Widget buildLayout(BuildContext context) {
    if (type == 'block') {
      return InkWell(
        onTap: () => onClick(),
        child: Padding(
          padding: padding,
          child: Row(
            children: [
              if (image is Widget) ...[image ?? Container(), SizedBox(width: 16)],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [name, count ?? Container()],
                ),
              ),
            ],
          ),
        ),
      );
    }
    return InkWell(
      onTap: () => onClick(),
      child: Padding(
        padding: padding,
        child: Row(
          children: [
            image ?? Container(),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: image is Widget ? 16 : 0),
                child: name,
              ),
            ),
            if (count != null)
              Padding(
                padding: EdgeInsets.only(left: 16),
                child: count ?? Container(),
              ),
          ],
        ),
      ),
    );
  }
}
