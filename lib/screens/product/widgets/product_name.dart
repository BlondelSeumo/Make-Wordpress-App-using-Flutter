import 'package:cirilla/models/product/product.dart';
import 'package:cirilla/utils/convert_data.dart';
import 'package:flutter/material.dart';

class ProductName extends StatelessWidget {
  final Product product;
  final String align;

  const ProductName({
    Key key,
    this.product,
    this.align = 'left',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _productName(context, product: product);
  }

  Widget _productName(BuildContext context, {Product product}) {
    return Text(
      product.name,
      style: Theme.of(context).textTheme.headline6,
      textAlign: ConvertData.toTextAlign(align),
    );
  }
}
