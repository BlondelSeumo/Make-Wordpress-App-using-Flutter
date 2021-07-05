import 'package:cirilla/mixins/mixins.dart';
import 'package:cirilla/models/product/product.dart';
import 'package:cirilla/widgets/cirilla_cart_icon.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:share/share.dart';

class ProductAppbar extends StatefulWidget {
  final Map<String, dynamic> configs;
  final Product product;

  const ProductAppbar({
    Key key,
    this.configs,
    this.product,
  }) : super(key: key);

  @override
  _ProductAppbarState createState() => _ProductAppbarState();
}

class _ProductAppbarState extends State<ProductAppbar> with AppBarMixin, Utility, NavigationMixin, WishListMixin {
  @override
  Widget build(BuildContext context) {
    bool enableAppbarSearch = get(widget.configs, ['enableAppbarSearch'], false);
    bool enableAppbarHome = get(widget.configs, ['enableAppbarHome'], false);
    bool enableAppbarShare = get(widget.configs, ['enableAppbarShare'], true);
    bool enableAppbarWishList = get(widget.configs, ['enableAppbarWishList'], true);
    bool enableAppbarCart = get(widget.configs, ['enableAppbarCart'], true);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        leadingPined(),
        Row(
          children: [
            if (enableAppbarHome) iconHome(context),
            if (enableAppbarSearch) iconSearch(context),
            if (enableAppbarShare) iconShare(context),
            if (enableAppbarWishList) iconWishList(context),
            if (enableAppbarCart) iconCart(context)
          ],
        )
      ],
    );
  }

  Widget iconHome(BuildContext context) {
    return Row(
      children: [
        leadingButton(
          icon: FeatherIcons.home,
          onPress: () => navigate(context, {
            'type': 'tab',
            'route': '/',
            'args': {'key': 'screens_home'}
          }),
        ),
        SizedBox(width: 8.0)
      ],
    );
  }

  Widget iconSearch(BuildContext context) {
    return Row(
      children: [
        leadingButton(
          icon: FeatherIcons.search,
          onPress: () => navigate(context, {
            'type': 'tab',
            'route': '/',
            'args': {'key': 'screens_category'}
          }),
        ),
        SizedBox(width: 8.0)
      ],
    );
  }

  Widget iconWishList(BuildContext context) {
    return Row(
      children: [
        leadingButton(
          icon: existWishList(productId: widget.product.id) ? FontAwesomeIcons.solidHeart : FontAwesomeIcons.heart,
          onPress: () {
            addWishList(productId: widget.product.id);
          },
        ),
        SizedBox(width: 8.0)
      ],
    );
  }

  Widget iconShare(BuildContext context) {
    return Row(
      children: [
        leadingButton(
          icon: FeatherIcons.share2,
          onPress: () => Share.share(widget.product.permalink, subject: widget.product.name),
        ),
        SizedBox(width: 8.0)
      ],
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
