import 'package:cirilla/models/cart/cart.dart';
import 'package:cirilla/store/cart/cart_store.dart';
import 'package:cirilla/utils/utils.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:cirilla/mixins/cart_mixin.dart';
import 'package:cirilla/mixins/mixins.dart';
import 'package:cirilla/types/types.dart';
import 'package:cirilla/utils/app_localization.dart';

class CartCoupon extends StatefulWidget {
  final Function applyCoupon;
  final TextEditingController myController;
  final Function(BuildContext context, int index) onRemoveCoupon;
  final CartStore cartStore;

  CartCoupon({
    this.applyCoupon,
    this.onRemoveCoupon,
    this.myController,
    this.cartStore,
  });

  @override
  _CartCouponState createState() => _CartCouponState();
}

class _CartCouponState extends State<CartCoupon> with Utility, CartMixin, SnackMixin {
  Future<void> _removeCoupon(BuildContext context, int index) async {
    try {
      widget.onRemoveCoupon(context, index);
      showSuccess(context, 'remove coupon successfully.');
    } catch (e) {
      showError(context, e);
    }
  }

  Future<void> _checkout() async {
    Navigator.pushNamed(context, '/checkout');
  }

  @override
  Widget build(BuildContext context) {
    CartData cartData = widget.cartStore.cartData;

    String subTotal = get(cartData.totals, ['total_items'], '0');
    String totalShip = get(cartData.totals, ['total_shipping'], '0');
    String totalPrice = get(cartData.totals, ['total_price'], '0');
    int unit = get(cartData.totals, ['currency_minor_unit'], 0);
    String currencyCode = get(cartData.totals, ['currency_code'], null);

    TranslateType translate = AppLocalizations.of(context).translate;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Coupon', style: Theme.of(context).textTheme.subtitle2),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: Padding(
                    padding: EdgeInsetsDirectional.only(end: 8, top: 8, bottom: 8),
                    child: SizedBox(
                        height: 48,
                        child: TextField(
                          decoration: InputDecoration(
                            contentPadding: EdgeInsetsDirectional.only(start: 16, top: 11),
                            hintText: translate('cart_coupon_discount'),
                            labelStyle: Theme.of(context).textTheme.bodyText1,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          controller: widget.myController,
                        )))),
            SizedBox(
                height: 48,
                width: 89,
                child: ElevatedButton(
                  onPressed: () => {widget.applyCoupon()},
                  child: Text(translate('cart_apply')),
                ))
          ],
        ),
        ...List.generate(cartData.coupons.length, (index) {
          String coupon = get(cartData.coupons.elementAt(index), ['totals', 'total_discount'], '0');

          String couponTitle = get(cartData.coupons.elementAt(index), ['code'], '');
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child: Padding(
                      padding: EdgeInsetsDirectional.only(bottom: 8),
                      child: Text(couponTitle, style: Theme.of(context).textTheme.bodyText2))),
              Text(convertCurrency(context, unit: unit, currency: currencyCode, price: coupon), style: Theme.of(context).textTheme.bodyText1),
              InkResponse(
                onTap: () => _removeCoupon(context, index),
                child: Icon(FeatherIcons.x, size: 14),
              )
            ],
          );
        }),
        SizedBox(height: 16),
        buildItemCoupon(
            title: translate('cart_sub_total'),
            price: convertCurrency(context, unit: unit, currency: currencyCode, price: subTotal),
            style: Theme.of(context).textTheme.subtitle2),
        SizedBox(height: 5),
        buildItemCoupon(
          title: translate('cart_free_shipping'),
          price: convertCurrency(context, unit: unit, currency: currencyCode, price: totalShip),
          style: Theme.of(context).textTheme.bodyText1,
        ),
        SizedBox(height: 31),
        buildItemCoupon(
          title: translate('cart_total'),
          price: convertCurrency(context, unit: unit, currency: currencyCode, price: totalPrice),
          style: Theme.of(context).textTheme.subtitle1,
        ),
        SizedBox(height: 8),
        SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton(
            child: Text(translate('cart_proceed_to_checkout')),
            onPressed: () => _checkout(),
          ),
        )
      ],
    );
  }

  Widget buildItemCoupon({String title, String price, TextStyle style}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [Text(title, style: style), Text(price, style: style)],
    );
  }
}
