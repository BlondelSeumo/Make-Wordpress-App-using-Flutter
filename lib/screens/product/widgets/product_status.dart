import 'package:cirilla/models/product/product.dart';
import 'package:cirilla/types/types.dart';
import 'package:cirilla/utils/convert_data.dart';
import 'package:cirilla/utils/utils.dart';
import 'package:flutter/material.dart';

class ProductStatus extends StatelessWidget {
  final Product product;
  final String align;

  const ProductStatus({Key key, this.product, this.align = 'left'}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TranslateType translate = AppLocalizations.of(context).translate;

    String textStatus = translate('product_status_outstock');
    Color colorStatus = Color(0xFFF01F0E);

    if (product.stockStatus == 'instock') {
      colorStatus = Color(0xFF21BA45);
      if (product.stockQuantity > 0) {
        textStatus = translate('product_status_instock_count', {'count': '${product.stockQuantity}'});
      }
      textStatus = translate('product_status_instock');
    } else if (product.stockStatus == 'onbackorder') {
      colorStatus = Color(0xFFFFA200);
      textStatus = translate('product_status_backorder');
    }

    return Text(
      textStatus,
      style: theme.textTheme.caption.copyWith(color: colorStatus),
      textAlign: ConvertData.toTextAlign(align),
    );
  }
}
