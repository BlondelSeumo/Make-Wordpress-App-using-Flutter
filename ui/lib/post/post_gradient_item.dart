import 'package:flutter/material.dart';
import 'post_item.dart';

/// A post widget display full width on the screen
///
class PostGradientItem extends PostItem {
  /// Widget image
  final Widget image;

  /// Widget name. It must required
  final Widget name;

  /// Widget category
  final Widget? category;

  /// Widget date
  final Widget? date;

  /// Widget author
  final Widget? author;

  /// Widget description
  final Widget? description;

  /// Widget comment
  final Widget? comment;

  /// padding item
  final EdgeInsetsGeometry padding;

  /// opacity background on image
  final double opacity;

  /// gradient on image
  final Gradient gradient;

  /// Function click item
  final Function onClick;

  /// shadow card
  final List<BoxShadow>? boxShadow;

  /// Border of item post
  final Border? border;

  /// Color Card of item post
  final Color? color;

  /// Border of item post
  final BorderRadius? borderRadius;

  /// Create Post Contained Item
  const PostGradientItem({
    Key? key,
    required this.image,
    required this.name,
    required this.onClick,
    this.category,
    this.description,
    this.date,
    this.author,
    this.comment,
    this.padding = const EdgeInsets.only(left: 20, right: 20, bottom: 54, top: 24),
    this.opacity = 0.9,
    this.gradient = const LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter, // 10% of the width, so there are ten blinds.
      colors: <Color>[Colors.transparent, Colors.black], // red to yellowepeats the gradient over the canvas
    ),
    this.color,
    this.border,
    this.boxShadow,
    this.borderRadius,
  }) : super(
          key: key,
          color: color,
          boxShadow: boxShadow,
          borderRadius: borderRadius,
        );

  @override
  Widget buildLayout(BuildContext context) {
    return GestureDetector(
      onTap: () => onClick(),
      child: Stack(
        children: [
          image,
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: Opacity(
              opacity: opacity,
              child: Container(
                decoration: BoxDecoration(
                  gradient: gradient,
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: padding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (category is Widget) ...[
                    category ?? Container(),
                    SizedBox(height: 16),
                  ],
                  name,
                  if (description != null) ...[
                    SizedBox(height: 16),
                    description ?? Container(),
                  ],
                  if (date != null || author != null || comment != null) ...[
                    SizedBox(height: 16),
                    Wrap(
                      spacing: 16,
                      children: [
                        if (date != null) date ?? Container(),
                        if (author != null) author ?? Container(),
                        if (comment != null) comment ?? Container(),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
