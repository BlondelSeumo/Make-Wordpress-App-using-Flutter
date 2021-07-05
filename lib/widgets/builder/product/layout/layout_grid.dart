import 'package:cirilla/models/models.dart';
import 'package:cirilla/types/types.dart';
import 'package:cirilla/widgets/cirilla_divider.dart';
import 'package:flutter/material.dart';

class LayoutGrid extends StatelessWidget {
  final List<Product> products;
  final BuildItemProductType buildItem;
  final int column;
  final double ratio;
  final double pad;
  final Color dividerColor;
  final double dividerHeight;
  final EdgeInsetsDirectional padding;
  final double width;
  final double height;
  final double widthView;

  const LayoutGrid({
    Key key,
    this.products,
    this.buildItem,
    this.column = 2,
    this.ratio = 1,
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
    double widthWidget = widthView - padding.start - padding.end;

    int col = column is int && column > 1 ? column : 2;
    double widthItem = (widthWidget - (col - 1) * pad) / col;
    double heightItem = widthItem / ratio;

    double widthImage = widthItem;
    double heightImage = (widthImage * height) / width;

    return Padding(
      padding: padding,
      child: Wrap(
        spacing: pad,
        runSpacing: pad,
        children: List.generate(
          products.length,
          (index) {
            return SizedBox(
              width: widthItem,
              height: heightItem,
              child: Column(
                children: [
                  Expanded(
                    child: buildItem(context, product: products[index], width: widthImage, height: heightImage),
                  ),
                  if (index < products.length - 1)
                    CirillaDivider(color: dividerColor, height: pad, thickness: dividerHeight),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
