import 'package:cirilla/models/models.dart';
import 'package:cirilla/types/types.dart';
import 'package:cirilla/widgets/cirilla_divider.dart';
import 'package:flutter/material.dart';

class LayoutList extends StatelessWidget {
  final List<Product> products;
  final BuildItemProductType buildItem;
  final double pad;
  final Color dividerColor;
  final double dividerHeight;
  final EdgeInsetsDirectional padding;

  final double width;
  final double height;
  final double widthView;

  const LayoutList({
    Key key,
    this.products,
    this.buildItem,
    this.pad = 0,
    this.dividerColor,
    this.dividerHeight = 1,
    this.padding = EdgeInsetsDirectional.zero,
    this.width,
    this.height,
    this.widthView = 300,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double widthWidget = widthView - padding.end - padding.start;

    double newWidth = widthWidget;
    double newHeight = (newWidth * height) / width;

    return Padding(
      padding: padding,
      child: Column(
        children: List.generate(
          products.length,
          (int index) {
            return Column(
              children: [
                buildItem(
                  context,
                  product: products[index],
                  width: newWidth,
                  height: newHeight,
                ),
                if (index < products.length - 1)
                  CirillaDivider(color: dividerColor, height: pad, thickness: dividerHeight),
              ],
            );
          },
        ),
      ),
    );
  }
}
