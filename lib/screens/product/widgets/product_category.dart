import 'package:cirilla/models/product/product.dart';
import 'package:cirilla/utils/utils.dart';
import 'package:flutter/material.dart';

class ProductCategory extends StatelessWidget {
  final Product product;
  final String align;

  const ProductCategory({Key key, this.product, this.align = 'left'}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextAlign textAlign = ConvertData.toTextAlign(align);
    return _buildCategories(context, product: product, textAlign: textAlign);
  }

  Widget _buildCategories(BuildContext context, {Product product, TextAlign textAlign}) {
    return Text(
      product.categories.map((p) => p.name.toUpperCase()).toList().join('  |  '),
      style: Theme.of(context).textTheme.caption.copyWith(fontSize: 12, color: Theme.of(context).primaryColor),
      textAlign: textAlign,
    );
  }
}
