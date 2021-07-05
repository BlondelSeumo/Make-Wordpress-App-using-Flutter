import 'package:flutter/material.dart';

abstract class CommentItem extends StatefulWidget {
  final double? elevation;
  final Color? shadowColor;
  final ShapeBorder? shape;
  final Color? color;

  const CommentItem({
    Key? key,
    this.elevation,
    this.shadowColor,
    this.shape,
    this.color = Colors.transparent,
  }) : super(key: key);

  @override
  _CommentItemState createState() => _CommentItemState();

  @protected
  Widget buildLayout(BuildContext context);
}

class _CommentItemState extends State<CommentItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: widget.shadowColor,
      elevation: widget.elevation ?? 0,
      margin: EdgeInsets.zero,
      shape: widget.shape ??
          RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      color: widget.color,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: widget.buildLayout(context),
    );
  }
}
