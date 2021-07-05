import 'package:flutter/material.dart';

abstract class VendorItem extends StatefulWidget {
  final double? elevation;
  final Color? shadowColor;
  final ShapeBorder? shape;
  final Color? color;

  const VendorItem({
    Key? key,
    this.elevation,
    this.shadowColor,
    this.shape,
    this.color,
  }) : super(key: key);

  @override
  _VendorItemState createState() => _VendorItemState();

  @protected
  Widget buildLayout(BuildContext context);
}

class _VendorItemState extends State<VendorItem> {
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
