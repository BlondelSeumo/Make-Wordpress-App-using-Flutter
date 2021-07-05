import 'package:cirilla/mixins/mixins.dart';
import 'package:cirilla/models/product/product.dart';
import 'package:cirilla/models/product/product_type.dart';
import 'package:cirilla/utils/app_localization.dart';
import 'package:cirilla/widgets/cirilla_cart_icon.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductBottomBar extends StatefulWidget {
  final Map<String, dynamic> configs;
  final Product product;
  final Widget qty;

  final Function onPress;
  final bool loading;

  const ProductBottomBar({
    Key key,
    this.configs,
    this.product,
    this.qty,
    this.onPress,
    this.loading,
  }) : super(key: key);

  @override
  _ProductBottomBarState createState() => _ProductBottomBarState();
}

class _ProductBottomBarState extends State<ProductBottomBar>
    with AppBarMixin, Utility, NavigationMixin, WishListMixin, LoadingMixin {
  void addToCart() async {
    if (loading) return;
    if (widget.product.type == ProductType.external) {
      await launch(widget.product.externalUrl);
      return;
    }
    widget.onPress();
  }

  @override
  Widget build(BuildContext context) {
    bool enableBottomBarSearch = get(widget.configs, ['enableBottomBarSearch'], false);
    bool enableBottomBarHome = get(widget.configs, ['enableBottomBarHome'], false);
    bool enableBottomBarShare = get(widget.configs, ['enableBottomBarShare'], true);
    bool enableBottomBarWishList = get(widget.configs, ['enableBottomBarWishList'], true);
    bool enableBottomBarCart = get(widget.configs, ['enableBottomBarCart'], true);
    bool enableBottomBarAddToCart = get(widget.configs, ['enableBottomBarAddToCart'], true);
    bool enableBottomBarQty = get(widget.configs, ['enableBottomBarQty'], false);

    return BottomAppBar(
      notchMargin: 8.0,
      shape: CircularNotchedRectangle(),
      elevation: 8,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            if (enableBottomBarHome) iconHome(context),
            if (enableBottomBarSearch) iconSearch(context),
            if (enableBottomBarQty && widget.product.type != ProductType.external) qty(context),
            if (!enableBottomBarAddToCart) Spacer(),
            if (enableBottomBarWishList) iconWishList(context),
            if (enableBottomBarShare) iconShare(context),
            if (enableBottomBarCart) iconCart(context),
            if (enableBottomBarAddToCart) addToCartBottom(context),
          ],
        ),
      ),
    );
  }

  Widget qty(BuildContext context) {
    return Container(
      margin: EdgeInsetsDirectional.only(start: 20),
      height: 48,
      // width: 100,
      child: widget.qty,
    );
  }

  Widget addToCartBottom(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        height: 48,
        child: ElevatedButton(
          child: widget.loading
              ? entryLoading(context, color: Colors.white)
              : Text(
                  widget.product.type == ProductType.external
                      ? widget.product.buttonText
                      : AppLocalizations.of(context).translate('product_add_to_cart'),
                ),
          onPressed: addToCart,
        ),
      ),
    );
  }

  Widget iconHome(BuildContext context) {
    return IconButton(
      icon: Icon(FeatherIcons.home, size: 20),
      onPressed: () => navigate(
        context,
        {
          'type': 'tab',
          'route': '/',
          'args': {'key': 'screens_home'}
        },
      ),
    );
  }

  Widget iconSearch(BuildContext context) {
    return IconButton(
      icon: Icon(FeatherIcons.search, size: 20),
      onPressed: () => navigate(
        context,
        {
          'type': 'tab',
          'route': '/',
          'args': {'key': 'screens_category'}
        },
      ),
    );
  }

  Widget iconWishList(BuildContext context) {
    return IconButton(
      icon: Icon(
        existWishList(productId: widget.product.id) ? FontAwesomeIcons.solidHeart : FontAwesomeIcons.heart,
        size: 20,
      ),
      onPressed: () {
        addWishList(productId: widget.product.id);
      },
    );
  }

  Widget iconShare(BuildContext context) {
    return IconButton(
      icon: Icon(FeatherIcons.share2, size: 20),
      onPressed: () => Share.share(widget.product.permalink, subject: widget.product.name),
    );
  }

  Widget iconCart(BuildContext context) {
    return Row(
      children: [
        CirillaCartIcon(
          color: Theme.of(context).appBarTheme.backgroundColor.withOpacity(0.6),
        ),
      ],
    );
  }
}
