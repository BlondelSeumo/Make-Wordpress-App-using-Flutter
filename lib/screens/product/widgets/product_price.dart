import 'package:cirilla/mixins/mixins.dart';
import 'package:cirilla/models/product/product.dart';
import 'package:flutter/material.dart';

class ProductPrice extends StatelessWidget with ProductMixin {
  final Product product;
  final String align;

  const ProductPrice({Key key, this.product, this.align = 'left'}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    Alignment alignment = align == 'right'
        ? Alignment.centerRight
        : align == 'center'
            ? Alignment.center
            : Alignment.centerLeft;
    return Container(
      alignment: alignment,
      child: buildPrice(
        context,
        product: product,
        regularStyle: theme.textTheme.subtitle1.copyWith(fontWeight: FontWeight.normal),
        saleStyle: theme.textTheme.subtitle1.copyWith(color: Color(0xFFF01F0E)),
        priceStyle: theme.textTheme.subtitle1,
        styleFrom: theme.textTheme.bodyText1.copyWith(fontWeight: FontWeight.normal),
        enablePercentSale: true,
        spacing: 17,
        shimmerWidth: 20,
        shimmerHeight: 90,
      ),
    );
  }
}
