import 'package:cirilla/mixins/loading_mixin.dart';
import 'package:cirilla/screens/order/widgets/order_billing.dart';
import 'package:cirilla/screens/order/widgets/order_item.dart';
import 'package:cirilla/service/helpers/request_helper.dart';
import 'package:cirilla/mixins/utility_mixin.dart';
import 'package:cirilla/models/order/order.dart';
import 'package:cirilla/store/auth/auth_store.dart';
import 'package:cirilla/store/order/order_store.dart';
import 'package:cirilla/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:ui/ui.dart';
import 'package:cirilla/types/types.dart';
import 'package:cirilla/utils/app_localization.dart';

class OrderDetailScreen extends StatefulWidget {
  final OrderData orderDetail;
  OrderDetailScreen({this.orderDetail});
  @override
  _OrderDetailScreenState createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> with Utility, LoadingMixin {
  OrderStore _orderStore;
  AuthStore _authStore;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _authStore = Provider.of<AuthStore>(context);
    RequestHelper requestHelper = Provider.of<RequestHelper>(context);
    _orderStore = OrderStore(
      requestHelper,
    )..getOrderNodes(orderId: widget.orderDetail.id, userId: _authStore.user.id);
  }

  @override
  Widget build(BuildContext context) {
    TranslateType translate = AppLocalizations.of(context).translate;

    Map billingData = widget.orderDetail.billing;

    TextTheme theme = Theme.of(context).textTheme;

    OrderData orderData = widget.orderDetail;

    String currencySymbol = get(widget.orderDetail.currencySymbol, [], '');

    String currency = get(widget.orderDetail.currency, [], '');

    final lineItems = orderData.lineItems;

    if (_orderStore == null) {
      return Container();
    }
    return Observer(
        builder: (_) => Scaffold(
            appBar: AppBar(
              title: Text(
                translate('order_title', {'id': '# ${get(orderData.id, [], '')}'}),
                style: theme.subtitle1,
              ),
              shadowColor: Colors.transparent,
              centerTitle: true,
            ),
            body: ListView(
              padding: EdgeInsetsDirectional.only(start: 20, end: 20, top: 20),
              children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Theme.of(context).dividerColor),
                      borderRadius: BorderRadius.circular(8)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 16, right: 16, top: 16),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(translate('order_number'), style: theme.caption),
                                  Text(
                                    orderData.id.toString(),
                                    style: Theme.of(context).textTheme.subtitle2,
                                  ),
                                ],
                              ),
                            ),
                            Badge(
                              text: Text(
                                widget.orderDetail.status,
                                style: Theme.of(context).textTheme.overline,
                              ),
                              color: widget.orderDetail.status == 'on-hold'
                                  ? Color(0xFFFFA200)
                                  : widget.orderDetail.status == 'processing'
                                      ? Color(0xFFFFA200)
                                      : widget.orderDetail.status == 'refund'
                                          ? Theme.of(context).errorColor
                                          : widget.orderDetail.status == 'successful'
                                              ? Color(0xFF21BA45)
                                              : Theme.of(context).errorColor,
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        height: 16,
                        thickness: 1,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 16, right: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(translate('order_date'), style: theme.caption),
                            Text(formatDate(date: widget.orderDetail.dateCreated), style: theme.subtitle2)
                          ],
                        ),
                      ),
                      Divider(
                        height: 16,
                        thickness: 1,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 16, right: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(translate('order_email'), style: theme.caption),
                            Text(_authStore.user.userEmail, style: theme.subtitle2)
                          ],
                        ),
                      ),
                      Divider(
                        height: 16,
                        thickness: 1,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 16, right: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(translate('order_total'), style: theme.caption),
                            Text(
                                formatCurrency(context,
                                    currency: orderData.currency,
                                    price: orderData.total,
                                    symbol: orderData.currencySymbol),
                                style: theme.subtitle2)
                          ],
                        ),
                      ),
                      Divider(
                        height: 16,
                        thickness: 1,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 16, right: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(translate('order_payment_method'), style: theme.caption),
                            Text(orderData.paymentMethod ?? '', style: theme.subtitle2)
                          ],
                        ),
                      ),
                      Divider(
                        height: 16,
                        thickness: 1,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(translate('order_shipping_method'), style: theme.caption),
                            Text(
                                formatCurrency(context,
                                    currency: orderData.currency,
                                    price: orderData.shippingTotal,
                                    symbol: orderData.currencySymbol),
                                style: theme.subtitle2)
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 32),
                Text(
                  translate('order_billing_address'),
                  style: theme.subtitle1,
                ),
                SizedBox(
                  height: 16,
                ),
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      border: Border.all(color: Theme.of(context).dividerColor),
                      borderRadius: BorderRadius.circular(8)),
                  child: OrderBilling(billingData: billingData, style: theme.bodyText2),
                ),
                SizedBox(
                  height: 40,
                ),
                Text(
                  translate('order_information'),
                  style: theme.subtitle1,
                ),
                SizedBox(height: 4),
                ...List.generate(lineItems.length, (index) {
                  LineItems productData = lineItems.elementAt(index);
                  return OrderItem(
                    productData: productData,
                    currency: currency,
                    currencySymbol: currencySymbol,
                    onClick: () {},
                  );
                }),
                Padding(
                  padding: EdgeInsets.only(top: 22, bottom: 28),
                  child: Divider(height: 2, thickness: 1),
                ),
                Text(
                  translate('order_nodes'),
                  style: theme.subtitle1,
                ),
                SizedBox(height: 8),
                ...List.generate(_orderStore.orderNode.length, (index) {
                  return Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: Container(
                      decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(8), color: Theme.of(context).dividerColor),
                      child: OrderReturnItem(
                        name: Text(
                          _orderStore.orderNode.elementAt(index).note,
                          style: theme.bodyText2,
                        ),
                        dateTime: Text(
                          formatDate(date: _orderStore.orderNode.elementAt(index).dateCreated),
                          style: theme.caption,
                        ),
                        onClick: () {},
                      ),
                    ),
                  );
                }),
                if (_orderStore.orderNode.length != 0) SizedBox(height: 48),
                Divider(
                  height: 8,
                  thickness: 1,
                ),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Text(translate('order_shipping'), style: theme.caption),
                  Text(
                      formatCurrency(context,
                          currency: orderData.currency,
                          price: orderData.shippingTotal,
                          symbol: orderData.currencySymbol),
                      style: theme.caption)
                ]),
                Divider(
                  height: 8,
                  thickness: 1,
                ),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Text(translate('order_shipping_tax'), style: theme.caption),
                  Text(
                      formatCurrency(context,
                          currency: orderData.currency, price: orderData.shippingTax, symbol: orderData.currencySymbol),
                      style: theme.caption)
                ]),
                Divider(
                  height: 8,
                  thickness: 1,
                ),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Text(translate('order_discount'), style: theme.caption),
                  Text(
                      formatCurrency(context,
                          currency: orderData.currency,
                          price: orderData.discountTotal,
                          symbol: orderData.currencySymbol),
                      style: theme.caption)
                ]),
                Divider(
                  height: 8,
                  thickness: 1,
                ),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Text(translate('order_discount_tax'), style: theme.caption),
                  Text(
                      formatCurrency(context,
                          currency: orderData.currency, price: orderData.discountTax, symbol: orderData.currencySymbol),
                      style: theme.caption)
                ]),
                Divider(
                  height: 8,
                  thickness: 1,
                ),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Text(translate('order_total'), style: theme.subtitle2),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                          formatCurrency(context,
                              currency: orderData.currency, price: orderData.total, symbol: orderData.currencySymbol),
                          style: theme.headline6),
                      Text(translate('order_include'), style: theme.overline)
                    ],
                  )
                ]),
                SizedBox(
                  height: 32,
                ),
                Container(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text(translate('order_refund')),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(160, 48),
                      ),
                    )),
                SizedBox(
                  height: 48,
                )
              ],
            )));
  }
}
