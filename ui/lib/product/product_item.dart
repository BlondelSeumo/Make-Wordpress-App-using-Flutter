import 'package:flutter/material.dart';

abstract class ProductItem extends StatefulWidget {
  final Color? color;
  final Border? border;
  final BorderRadius? borderRadius;
  final List<BoxShadow>? boxShadow;

  const ProductItem({
    Key? key,
    this.color,
    this.border,
    this.boxShadow,
    this.borderRadius,
  }) : super(key: key);

  @override
  _ProductItemState createState() => _ProductItemState();

  @protected
  Widget buildLayout(BuildContext context);
}

class _ProductItemState extends State<ProductItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.zero,
      // shape: widget.shape ?? RoundedRectangleBorder(borderRadius: BorderRadius.zero),

      decoration: BoxDecoration(
        color: widget.color ?? Theme.of(context).cardColor,
        border: widget.border,
        borderRadius: widget.borderRadius,
        boxShadow: widget.boxShadow,
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: widget.buildLayout(context),
    );
    // return Card(
    //   shadowColor: widget.shadowColor,
    //   elevation: widget.elevation ?? 0,
    //   margin: EdgeInsets.zero,
    //   shape: widget.shape ?? RoundedRectangleBorder(borderRadius: BorderRadius.zero),
    //   color: widget.color,
    //   clipBehavior: Clip.antiAliasWithSaveLayer,
    //   child: widget.buildLayout(context),
    // );
  }
}
