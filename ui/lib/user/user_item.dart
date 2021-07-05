import 'package:flutter/material.dart';

abstract class UserItem extends StatefulWidget {
  final double? elevation;
  final Color? shadowColor;
  final ShapeBorder? shape;
  final Color? color;

  const UserItem({
    Key? key,
    this.elevation,
    this.shadowColor,
    this.shape,
    this.color,
  }) : super(key: key);

  @override
  _UserItemState createState() => _UserItemState();

  @protected
  Widget buildLayout(BuildContext context);
}

class _UserItemState extends State<UserItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: widget.shadowColor,
      elevation: widget.elevation ?? 0,
      margin: EdgeInsets.zero,
      shape: widget.shape ?? RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      color: widget.color,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: widget.buildLayout(context),
    );
  }
}
