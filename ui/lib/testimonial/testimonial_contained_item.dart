import 'package:flutter/material.dart';
import 'testimonial_item.dart';

class TestimonialContainedItem extends TestimonialItem {
  /// Widget image
  final Widget? image;

  /// Widget user
  final Widget user;

  /// Widget job
  final Widget? job;

  /// Widget description
  final Widget description;

  /// Widget rating
  final Widget? rating;

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

  TestimonialContainedItem({
    Key? key,
    required this.user,
    required this.description,
    this.image,
    this.job,
    this.rating,
    this.width = double.infinity,
    this.paddingContent = const EdgeInsets.all(24),
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
        child: Column(
          children: [
            description,
            SizedBox(height: 24),
            rating ?? Container(),
            if (rating != null) SizedBox(height: 24),
            image ?? Container(),
            if (image != null) SizedBox(height: 16),
            user,
            job ?? Container(),
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
