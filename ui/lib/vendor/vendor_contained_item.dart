import 'package:flutter/material.dart';
import 'vendor_item.dart';

class VendorContainedItem extends VendorItem {
  /// Widget image
  final Widget image;

  /// Widget name
  final Widget name;

  /// Widget count items
  final Widget? feature;

  /// Widget rating
  final Widget? rating;

  /// Function click item
  final Function onClick;

  /// Padding Item
  final EdgeInsets padding;

  /// ShapeBorder of item post
  final ShapeBorder? shape;

  /// Elevation fro shadow card
  final double? elevation;

  /// Color shadow card
  final Color? shadowColor;

  /// Color Card of item category
  final Color? color;

  VendorContainedItem({
    Key? key,
    required this.image,
    required this.name,
    required this.onClick,
    this.feature,
    this.rating,
    this.padding = const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
    this.shape = const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      side: BorderSide(width: 1, color: Color(0xFFE0E0E0)),
    ),
    this.elevation,
    this.shadowColor,
    this.color = const Color(0xFFF4F4F4),
  }) : super(
          key: key,
          shape: shape,
          elevation: elevation,
          shadowColor: shadowColor,
          color: color,
        );
  @override
  Widget buildLayout(BuildContext context) {
    return InkWell(
      onTap: () => onClick(),
      child: Padding(
        padding: padding,
        child: Column(
          children: [
            image,
            SizedBox(height: 16),
            name,
            if (feature != null) feature ?? Container(),
            if (rating != null) rating ?? Container(),
          ],
        ),
      ),
    );
  }
}
