import 'package:flutter/material.dart';

class CommentHorizontalPost extends StatelessWidget {
  /// Widget image
  final Widget? image;

  /// widget name
  final Widget name;

  /// widget date
  final Widget? date;

  /// widget post
  final Widget post;

  /// widget Comment
  final Widget? comment;

  /// Function onClick
  final Function onClick;

  /// padding item
  final EdgeInsetsGeometry padding;

  CommentHorizontalPost({
    Key? key,
    this.image,
    required this.name,
    required this.post,
    required this.onClick,
    this.comment,
    this.date,
    this.padding = EdgeInsets.zero,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onClick(),
      child: Padding(
        padding: padding,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (image is Widget) ...[
              image ?? Container(),
              SizedBox(width: 16),
            ],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(child: name),
                      date ?? Container(),
                    ],
                  ),
                  post,
                  if (comment is Widget) ...[
                    SizedBox(height: 14),
                    comment ?? Container(),
                  ],
                ],
              ),
            )
          ],
          // ),
        ),
      ),
    );
  }
}
