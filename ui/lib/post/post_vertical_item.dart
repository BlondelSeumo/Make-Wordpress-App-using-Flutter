import 'package:flutter/material.dart';
import 'post_item.dart';

/// A post widget display full width on the screen
///
class PostVerticalItem extends PostItem {
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

  /// Width item
  final double width;

  /// Function click item
  final Function? onClick;

  /// Border of item post
  final Border? border;

  /// Color Card of item post
  final Color? color;

  /// Border of item post
  final BorderRadius? borderRadius;

  /// shadow card
  final List<BoxShadow>? boxShadow;

  /// Padding content image of safe
  final EdgeInsetsGeometry paddingContent;

  /// Create Post Vertical Item
  const PostVerticalItem({
    Key? key,
    required this.image,
    required this.name,
    this.onClick,
    this.category,
    this.excerpt,
    this.date,
    this.author,
    this.comment,
    this.color,
    this.borderRadius,
    this.border,
    this.boxShadow,
    this.width = 300,
    this.paddingContent = const EdgeInsets.all(16),
  }) : super(
          key: key,
          color: color,
          border: border,
          borderRadius: borderRadius,
          boxShadow: boxShadow,
        );

  @override
  Widget buildLayout(BuildContext context) {
    return SizedBox(
      width: width,
      child: InkWell(
        onTap: () => onClick?.call() ?? null,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            image,
            Padding(
              padding: paddingContent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (category is Widget) ...[category ?? Container(), SizedBox(height: 8)],
                  name,
                  if (excerpt is Widget) ...[
                    SizedBox(height: 8),
                    excerpt ?? Container(),
                  ],
                  if (date is Widget || author is Widget || comment is Widget) ...[
                    SizedBox(height: 8),
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        if (date is Widget)
                          Padding(
                            padding: EdgeInsets.only(right: 16),
                            child: date,
                          ),
                        if (author is Widget)
                          Padding(
                            padding: EdgeInsets.only(right: 16),
                            child: author,
                          ),
                        comment ?? Container(),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
