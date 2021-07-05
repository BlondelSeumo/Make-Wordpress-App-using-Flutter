import 'package:flutter/material.dart';
import 'testimonial_item.dart';

class TestimonialBasicItem extends TestimonialItem {
  /// Widget image
  final Widget? image;

  /// Widget title
  final Widget title;

  /// Widget description
  final Widget description;

  /// Width item
  final double width;

  /// Padding item
  final EdgeInsets paddingContent;

  /// Elevation fro shadow card
  final double? elevation;

  /// Color shadow card
  final Color? shadowColor;

  /// ShapeBorder of item post
  final ShapeBorder? shape;

  /// Color Card of item post
  final Color? color;

  /// Function click item
  final Function? onClick;

  TestimonialBasicItem({
    Key? key,
    required this.title,
    required this.description,
    this.image,
    this.width = double.infinity,
    this.paddingContent = const EdgeInsets.only(left: 16, right: 20, top: 16, bottom: 16),
    this.onClick,
    this.shape = const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
    this.color,
    this.shadowColor,
    this.elevation,
  }) : super(
          key: key,
          color: color,
          shadowColor: shadowColor,
          shape: shape,
          elevation: elevation,
        );
  @override
  Widget buildLayout(BuildContext context) {
    Widget itemWidget = SizedBox(
      width: width,
      child: Padding(
        padding: paddingContent,
        child: Row(
          children: [
            image ?? Container(),
            if (image != null) SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [title, SizedBox(height: 8), description],
              ),
            ),
          ],
        ),
      ),
    );
    return onClick != null
        ? InkWell(
            onTap: () => onClick?.call() ?? print('click'),
            child: itemWidget,
          )
        : itemWidget;
  }
}
