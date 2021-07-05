import 'package:flutter/material.dart';
import 'contact_item.dart';

class ContactContainedItem extends ContactItem {
  ContactContainedItem({
    Key? key,
    required this.headOffice,
    required this.description,
    this.directionMap,
    this.padding = EdgeInsets.zero,
    this.width,
    this.elevation,
    this.shadowColor,
    this.shape,
    this.color,
  }) : super(
          key: key,
          color: color,
          shape: shape,
          shadowColor: shadowColor,
          elevation: elevation,
        );

  final Widget headOffice;
  final Widget? directionMap;
  final Widget description;
  final EdgeInsetsGeometry padding;
  final double? width;
  final double? elevation;
  final Color? shadowColor;
  final ShapeBorder? shape;
  final Color? color;

  @override
  Widget buildLayout(BuildContext context) {
    return Container(
      width: width ?? 300,
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(child: headOffice),
              if (directionMap is Widget) ...[
                SizedBox(width: 16),
                directionMap ?? Container(),
              ],
            ],
          ),
          SizedBox(height: 16),
          description
        ],
      ),
    );
  }
}
