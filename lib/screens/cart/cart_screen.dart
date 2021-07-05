import 'package:cirilla/mixins/cart_mixin.dart';
import 'package:cirilla/mixins/loading_mixin.dart';
import 'package:cirilla/mixins/navigation_mixin.dart';
import 'package:cirilla/mixins/snack_mixin.dart';
import 'package:cirilla/mixins/utility_mixin.dart';
import 'package:cirilla/models/cart/cart.dart';
import 'package:cirilla/screens/cart/widgets/cart_coupon.dart';
import 'package:cirilla/screens/cart/widgets/cart_items.dart';
import 'package:cirilla/store/cart/cart_store.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:ui/notification/notification_screen.dart';
import 'package:cirilla/types/types.dart';
import 'package:cirilla/utils/app_localization.dart';

class CartScreen extends StatefulWidget {
  @override
  CartScreenState createState() => CartScreenState();
}

class CartScreenState extends State<CartScreen> with LoadingMixin, Utility, CartMixin, SnackMixin, NavigationMixin {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();
  TextEditingController myController = TextEditingController();
  CartStore _cartStore;

  List<CartItem> _items = List<CartItem>.of([]);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _cartStore = Provider.of<CartStore>(context);
    if (_cartStore.cartData != null) {
      setState(() {
        _items = _cartStore.cartData.items;
      });
    }
    getData();
  }

  Future<void> getData() async {
    await _cartStore.getCart();
    if (_cartStore.cartData != null) {
      setState(() {
        _items = _cartStore.cartData.items;
      });
    }
  }

  onRemoveCoupon(BuildContext context, int index) async {
    await _cartStore.getCart();
    _cartStore.removeCoupon(code: _cartStore.cartData.coupons.elementAt(index)['code']);
  }

  updateQuantity(BuildContext context, CartItem cartItem, int value) {
    _cartStore.updateQuantity(key: cartItem.key, quantity: value);
  }

  applyCoupon() async {
    try {
      await _cartStore.applyCoupon(code: myController.text);
      showSuccess(context, 'apply coupon successfully.');
      myController.clear();
    } catch (e) {
      showError(context, e);
    }
  }

  void onRemove(BuildContext context, CartItem cartItem, int index) async {
    _listKey.currentState.removeItem(index, (_, animation) {
      return SizeTransition(
        sizeFactor: animation,
        child: Column(
          children: [
            Item(
              cartItem: cartItem,
            ),
          ],
        ),
      );
    }, duration: Duration(milliseconds: 250));
    _items.removeAt(index);
    try {
      await _cartStore.removeCart(key: cartItem.key);
    } catch (e) {
      showError(context, e);
    }
  }

  @override
  Widget build(BuildContext context) {
    TranslateType translate = AppLocalizations.of(context).translate;
    return Observer(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: _cartStore.cartData != null
              ? Text(
                  translate('cart_count', {'count': '(${_items.length.toString()})'}),
                  style: Theme.of(context).textTheme.subtitle1,
                )
              : Text(translate('cart_no_count')),
          shadowColor: Colors.transparent,
          centerTitle: true,
        ),
        body: Stack(
          children: [
            if (_cartStore.cartData != null) ...[
              if (_items.length < 1 && !_cartStore.loading) buildCartEmpty(context),
              if (_items.length != 0)
                AnimatedList(
                  key: _listKey,
                  initialItemCount: _items.length + 1,
                  itemBuilder: (context, index, animation) {
                    if (index == _items.length) {
                      return buildCoupon(context, _cartStore);
                    }
                    return buildItem(_items[index], animation, index);
                  },
                ),
            ],
            if (_cartStore.loading && _items.length == 0) buildLoading(context, isLoading: _cartStore.loading),
          ],
        ),
      );
    });
  }

  Widget buildItem(CartItem cartItem, Animation animation, int index) {
    return SizeTransition(
      sizeFactor: animation,
      child: Column(
        children: [
          Item(
            cartItem: cartItem,
            onRemove: () => onRemove(context, cartItem, index),
            updateQuantity: updateQuantity,
          ),
          Divider(height: 2, thickness: 1),
        ],
      ),
    );
  }

  Widget buildCoupon(BuildContext context, CartStore cartStore) {
    return Padding(
      padding: EdgeInsetsDirectional.only(start: 20, end: 20, top: 24, bottom: 150),
      child: CartCoupon(
        applyCoupon: applyCoupon,
        onRemoveCoupon: onRemoveCoupon,
        myController: myController,
        cartStore: cartStore,
      ),
    );
  }

  Widget buildCartEmpty(BuildContext context) {
    TranslateType translate = AppLocalizations.of(context).translate;
    return Container(
      child: NotificationScreen(
        title: Text(translate('cart_your_bag_is_empty'), style: Theme.of(context).textTheme.headline6),
        content: Text(
          translate('cart_items_added_to_your_bag_will_show_up_here'),
          style: Theme.of(context).textTheme.bodyText1,
          textAlign: TextAlign.center,
        ),
        iconData: FeatherIcons.shoppingCart,
        textButton: Text(translate('cart_shopping_now')),
        onPressed: () => navigate(context, {
          "type": "tab",
          "router": "/",
          "args": {"key": "screens_category"}
        }),
      ),
    );
  }
}
