import 'package:flutter/material.dart';
import 'user_item.dart';

class UserContainedItem extends UserItem {
  /// Widget Image
  final Widget? image;

  /// Widget title
  final Widget title;

  /// Widget title
  final Widget? leading;

  /// Widget sub title
  final Widget? trailing;

  /// width item
  final double width;

  /// padding item
  final EdgeInsetsGeometry padding;

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

  UserContainedItem({
    Key? key,
    this.image,
    required this.title,
    this.leading,
    this.trailing,
    required this.onClick,
    this.shape = const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
    this.elevation,
    this.shadowColor,
    this.color,
    this.width = double.infinity,
    this.padding = const EdgeInsets.all(16),
  }) : super(
          key: key,
          shape: shape,
          elevation: elevation,
          shadowColor: shadowColor,
          color: color,
        );

  @override
  Widget buildLayout(BuildContext context) {
    return SizedBox(
      width: width,
      child: InkWell(
        onTap: () => onClick(),
        child: Padding(
          padding: padding,
          child: Row(
            children: [
              if (image is Widget) ...[
                image ?? Container(),
                SizedBox(width: 16),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    leading ?? Container(),
                    title,
                    if (trailing is Widget) ...[SizedBox(height: 4), trailing ?? Container()],
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
