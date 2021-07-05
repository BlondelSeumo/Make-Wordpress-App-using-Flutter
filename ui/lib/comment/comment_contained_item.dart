import 'package:flutter/material.dart';
import 'comment_item.dart';

class CommentContainedItem extends CommentItem {
  /// Widget image
  final Widget image;

  /// widget name
  final Widget name;

  /// widget date
  final Widget date;

  /// widget Comment
  final Widget comment;

  /// widget rating detail/about Comment
  final Widget? rating;

  /// Function onClick
  final Function onClick;

  /// Elevation fro shadow card
  final double? elevation;

  /// Color shadow card
  final Color? shadowColor;

  final Widget? reply;

  CommentContainedItem({
    Key? key,
    required this.image,
    required this.name,
    required this.onClick,
    required this.comment,
    required this.date,
    this.rating,
    this.elevation,
    this.shadowColor,
    this.reply,
  }) : super(
          key: key,
          elevation: elevation,
          shadowColor: shadowColor,
        );

  @override
  Widget buildLayout(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        image,
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 5),
              Row(
                children: [
                  Expanded(child: name),
                  date,
                ],
              ),
              rating ?? Container(),
              SizedBox(height: 16),
              comment,
              reply ?? Container(),
            ],
          ),
        )
      ],
      // ),
    );
  }
}
