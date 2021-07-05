import 'package:flutter/material.dart';

abstract class PostItem extends StatefulWidget {
  final Color? color;
  final List<BoxShadow>? boxShadow;
  final Border? border;
  final BorderRadius? borderRadius;

  const PostItem({
    Key? key,
    this.color,
    this.boxShadow,
    this.border,
    this.borderRadius,
  }) : super(key: key);

  @override
  _PostItemState createState() => _PostItemState();

  @protected
  Widget buildLayout(BuildContext context);
}

class _PostItemState extends State<PostItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.color ?? Theme.of(context).cardColor,
        borderRadius: widget.borderRadius,
        border: widget.border,
        boxShadow: widget.boxShadow,
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: widget.buildLayout(context),
    );
  }
}
