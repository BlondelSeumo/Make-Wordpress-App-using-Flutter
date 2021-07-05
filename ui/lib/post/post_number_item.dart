import 'package:flutter/material.dart';
import 'post_item.dart';

class PostNumberItem extends PostItem {
  /// Widget number
  final Widget number;

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

  /// Padding item
  final EdgeInsetsGeometry padding;

  /// shadow card
  final List<BoxShadow>? boxShadow;

  /// Border of item post
  final Border? border;

  /// Color Card of item post
  final Color? color;

  /// Border of item post
  final BorderRadius? borderRadius;

  /// Function click item
  final Function onClick;

  const PostNumberItem({
    Key? key,
    required this.number,
    required this.name,
    required this.onClick,
    this.date,
    this.excerpt,
    this.category,
    this.author,
    this.comment,
    this.padding = EdgeInsets.zero,
    this.boxShadow,
    this.border,
    this.borderRadius,
    this.color,
  }) : super(
          key: key,
          color: color,
          boxShadow: boxShadow,
          border: border,
          borderRadius: borderRadius,
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
            SizedBox(
              width: 72,
              child: number,
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (category != null || date != null) ...[
                    Row(
                      children: [
                        Expanded(child: category ?? Container()),
                        if (category != null && date != null) SizedBox(width: 16),
                        date ?? Container(),
                      ],
                    ),
                    SizedBox(height: 16),
                  ],
                  name,
                  if (excerpt is Widget) ...[
                    SizedBox(height: 8),
                    excerpt ?? Container(),
                  ],
                  if (author != null && comment != null) ...[
                    SizedBox(height: 16),
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        if (author != null)
                          Padding(
                            padding: EdgeInsets.only(right: 16),
                            child: author ?? null,
                          ),
                        comment ?? Container(),
                      ],
                    ),
                  ],
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
