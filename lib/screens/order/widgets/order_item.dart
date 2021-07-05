import 'package:cirilla/constants/assets.dart';
import 'package:cirilla/mixins/utility_mixin.dart';
import 'package:cirilla/models/order/order.dart';
import 'package:cirilla/utils/currency_format.dart';
import 'package:flutter/material.dart';
import 'package:ui/image/image_loading.dart';
import 'package:ui/product/product_card_item.dart';

class OrderItem extends StatefulWidget {
  final int quantity;
  final String name;
  final int price;
  final Function onClick;
  final String currencySymbol;
  final String currency;
  final String sku;
  final LineItems productData;
  OrderItem({
    this.name,
    this.price,
    this.onClick,
    this.currencySymbol,
    this.currency,
    this.sku,
    this.productData,
    this.quantity,
  });
  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> with Utility {
  @override
  Widget build(BuildContext context) {
    String name = get(widget.productData.name, [], '');

    int quantity = get(widget.productData.quantity, [], 0);

    String price = get(widget.productData.subtotal, [], '');

    String sku = get(widget.productData.sku, [], '');

    TextTheme theme = Theme.of(context).textTheme;
    return Padding(
        padding: EdgeInsets.only(top: 20),
        child: ProductCardItem(
          name: Text(
            '$name x ${quantity.toString()}',
            style: theme.bodyText2,
          ),
          price: Text(
            '${formatCurrency(context, price: price, symbol: widget.currencySymbol, currency: widget.currency)}',
            style: theme.subtitle2,
          ),
          attribute: Table(
            columnWidths: const <int, TableColumnWidth>{
              0: IntrinsicColumnWidth(),
              1: FlexColumnWidth(),
            },
            children: [
              ...List.generate(widget.productData.metaData.length, (index) {
                Map metaData = widget.productData.metaData.elementAt(index);
                String displayKey = get(metaData, ['display_key'], '');
                String value = get(metaData, ['display_value'], '');
                return TableRow(children: [
                  Text("$displayKey : ", style: Theme.of(context).textTheme.caption),
                  Padding(
                    padding: EdgeInsetsDirectional.only(start: 9, end: 9),
                    child: Text(value, style: Theme.of(context).textTheme.caption),
                  )
                ]);
              }),
              TableRow(children: [
                if (sku != '') Text('sku: ', style: Theme.of(context).textTheme.caption),
                Padding(
                  padding: EdgeInsetsDirectional.only(start: 9, end: 9),
                  child: Text(sku, style: Theme.of(context).textTheme.caption),
                )
              ])
            ],
          ),
          image: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: ImageLoading(
              Assets.noImageUrl,
              width: 80,
              height: 102,
              fit: BoxFit.cover,
            ),
          ),
          onClick: () => widget.onClick(),
        ));
  }
}
