import 'package:flutter/material.dart';
import 'post_item.dart';

/// A post widget display full width on the screen
///
class PostContainedItem extends PostItem {
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

  /// shadow card
  final List<BoxShadow>? boxShadow;

  /// Border of item post
  final Border? border;

  /// Color Card of item post
  final Color? color;

  /// Border of item post
  final BorderRadius? borderRadius;

  /// Padding content image of safe
  final EdgeInsetsGeometry paddingContent;

  /// Padding contained item
  final EdgeInsetsGeometry padding;

  /// Create Post Contained Item
  const PostContainedItem({
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
    this.border,
    this.borderRadius,
    this.boxShadow,
    this.width = 300,
    this.paddingContent = const EdgeInsets.only(top: 8),
    this.padding = EdgeInsets.zero,
  }) : super(
          key: key,
          color: color,
          border: border,
          borderRadius: borderRadius,
          boxShadow: boxShadow,
        );

  @override
  Widget buildLayout(BuildContext context) {
    Widget renderImage = category is Widget
        ? Stack(
            children: [
              image,
              Positioned(
                top: 16,
                left: 16,
                right: 16,
                bottom: 16,
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: category ?? Container(),
                ),
              ),
            ],
          )
        : image;
    return SizedBox(
      width: width,
      child: InkWell(
        onTap: () => onClick?.call() ?? null,
        child: Padding(
          padding: padding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              renderImage,
              Padding(
                padding: paddingContent,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
      ),
    );
  }
}
