import 'package:flutter/material.dart';

abstract class IconBoxItem extends StatefulWidget {
  final Color? color;
  final BorderRadius? borderRadius;
  final Border? border;
  final List<BoxShadow>? boxShadow;

  const IconBoxItem({
    Key? key,
    this.borderRadius,
    this.border,
    this.boxShadow,
    this.color,
  }) : super(key: key);

  @override
  _IconBoxItemState createState() => _IconBoxItemState();

  @protected
  Widget buildLayout(BuildContext context);
}

class _IconBoxItemState extends State<IconBoxItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: widget.color ?? Theme.of(context).cardColor,
          border: widget.border,
          borderRadius: widget.borderRadius,
          boxShadow: widget.boxShadow),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: widget.buildLayout(context),
    );
  }
}
