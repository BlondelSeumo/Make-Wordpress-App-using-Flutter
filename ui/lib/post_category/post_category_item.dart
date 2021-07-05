import 'package:flutter/material.dart';

abstract class PostCategoryItem extends StatefulWidget {
  final double? elevation;
  final Color? shadowColor;
  final Color? color;
  final ShapeBorder? shape;

  const PostCategoryItem({
    Key? key,
    this.elevation,
    this.shadowColor,
    this.color,
    this.shape,
  }) : super(key: key);

  @override
  _PostCategoryItemState createState() => _PostCategoryItemState();

  @protected
  Widget buildLayout(BuildContext context);
}

class _PostCategoryItemState extends State<PostCategoryItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: widget.shadowColor,
      elevation: widget.elevation ?? 0,
      color: widget.color,
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: widget.shape ?? RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      child: widget.buildLayout(context),
    );
  }
}
