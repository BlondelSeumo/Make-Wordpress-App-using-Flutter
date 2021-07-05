import 'package:cirilla/models/product/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class ProductSortDescription extends StatelessWidget {
  final Product product;

  const ProductSortDescription({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Html(
        data: product.shortDescription ?? '',
      ),
    );
  }
}
