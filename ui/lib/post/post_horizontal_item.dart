import 'package:flutter/material.dart';
import 'post_item.dart';

/// A post widget display full width on the screen
///
class PostHorizontalItem extends PostItem {
  /// Widget image
  final Widget image;

  /// Widget name. It must required
  final Widget name;

  /// Widget category
  final Widget? category;

  /// Widget excerpt
  final Widget? excerpt;

  /// Widget date
  final Widget? date;

  /// Widget author
  final Widget? author;

  /// Widget comment
  final Widget? comment;

  ///  padding Item
  final EdgeInsetsGeometry padding;

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

  /// if [isRightImage] = true, widget image will show in the right item
  final bool isRightImage;

  /// Create Post Horizontal Item
  const PostHorizontalItem({
    Key? key,
    required this.image,
    required this.name,
    required this.onClick,
    this.category,
    this.excerpt,
    this.date,
    this.author,
    this.comment,
    this.padding = EdgeInsets.zero,
    this.color,
    this.borderRadius,
    this.boxShadow,
    this.border,
    this.isRightImage = false,
  }) : super(
          key: key,
          borderRadius: borderRadius,
          boxShadow: boxShadow,
          color: color,
          border: border,
        );

  @override
  Widget buildLayout(BuildContext context) {
    return InkWell(
      onTap: () => onClick(),
      child: Padding(
        padding: padding,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!isRightImage) ...[
              image,
              SizedBox(width: 16),
            ],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  if (category is Widget) ...[
                    category ?? Container(),
                    SizedBox(height: 16),
                  ],
                  name,
                  SizedBox(height: 8),
                  if (excerpt is Widget) ...[
                    excerpt ?? Container(),
                    SizedBox(height: 8),
                  ],
                  if (date is Widget) ...[
                    date ?? Container(),
                    SizedBox(height: 16),
                  ],
                  if (author is Widget || comment is Widget)
                    Wrap(
                      children: [
                        if (author is Widget)
                          Padding(
                            padding: EdgeInsets.only(right: 16),
                            child: author ?? Container(),
                          ),
                        comment ?? Container(),
                      ],
                    ),
                ],
              ),
            ),
            if (isRightImage) ...[
              SizedBox(width: 16),
              image,
            ],
          ],
        ),
      ),
    );
  }
}
