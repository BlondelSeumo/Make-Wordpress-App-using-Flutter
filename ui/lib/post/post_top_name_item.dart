import 'package:flutter/material.dart';
import 'post_item.dart';

/// A post widget display full width on the screen
///
class PostTopNameItem extends PostItem {
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

  /// Widget excerpt
  final Widget? excerpt;

  /// Widget comment
  final Widget? comment;

  /// width Item
  final double width;

  /// padding Item
  final EdgeInsetsGeometry padding;

  /// Border of item post
  final Border? border;

  /// Color Card of item post
  final Color? color;

  /// Border of item post
  final BorderRadius? borderRadius;

  /// shadow card
  final List<BoxShadow>? boxShadow;

  /// Function click item
  final Function onClick;

  /// Create Post Contained Item
  const PostTopNameItem({
    Key? key,
    required this.image,
    required this.name,
    required this.onClick,
    this.category,
    this.excerpt,
    this.date,
    this.author,
    this.comment,
    this.width = 300,
    this.padding = EdgeInsets.zero,
    this.color,
    this.boxShadow,
    this.borderRadius,
    this.border,
  }) : super(
          key: key,
          border: border,
          boxShadow: boxShadow,
          borderRadius: borderRadius,
          color: color,
        );

  @override
  Widget buildLayout(BuildContext context) {
    return InkWell(
      onTap: () => onClick(),
      child: Container(
        width: width,
        padding: padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (category != null) ...[
              category ?? Container(),
              SizedBox(height: 16),
            ],
            name,
            SizedBox(height: 16),
            image,
            if (date != null || author != null || comment != null) ...[
              SizedBox(height: 16),
              Wrap(
                children: [
                  if (date != null)
                    Padding(
                      padding: EdgeInsets.only(right: author != null || comment != null ? 16 : 0),
                      child: date ?? Container(),
                    ),
                  if (author != null)
                    Padding(
                      padding: EdgeInsets.only(right: comment != null ? 16 : 0),
                      child: author ?? Container(),
                    ),
                  comment ?? Container(),
                ],
              ),
            ],
            if (excerpt != null) ...[
              SizedBox(height: 16),
              excerpt ?? Container(),
            ],
          ],
        ),
      ),
    );
  }
}
