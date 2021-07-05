import 'package:cirilla/mixins/mixins.dart';
import 'package:cirilla/models/product/product.dart';
import 'package:flutter/material.dart';

class ProductRating extends StatelessWidget with ProductMixin {
  final Product product;
  final String align;

  const ProductRating({Key key, this.product, this.align = 'left'}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WrapAlignment wrapAlignment = align == 'right'
        ? WrapAlignment.end
        : align == 'center'
            ? WrapAlignment.center
            : WrapAlignment.start;
    return buildRating(context, product: product, wrapAlignment: wrapAlignment);
  }
}
