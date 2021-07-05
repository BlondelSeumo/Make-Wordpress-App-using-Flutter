import 'package:cirilla/constants/strings.dart';
import 'package:cirilla/mixins/loading_mixin.dart';
import 'package:cirilla/mixins/navigation_mixin.dart';
import 'package:cirilla/models/models.dart';
import 'package:cirilla/store/store.dart';
import 'package:cirilla/store/wishlist/wishlist_store.dart';
import 'package:cirilla/types/types.dart';
import 'package:cirilla/utils/app_localization.dart';
import 'package:cirilla/utils/utils.dart';
import 'package:cirilla/widgets/cirilla_product_item.dart';
import 'package:cirilla/widgets/widgets.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:ui/notification/notification_screen.dart';
import 'package:ui/ui.dart';

class WishListScreen extends StatefulWidget {
  @override
  _WishListScreenState createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> with NavigationMixin, LoadingMixin {
  SettingStore _settingStore;
  ProductsStore _productsStore;
  AppStore _appStore;
  WishListStore _wishListStore;

  @override
  void didChangeDependencies() {
    _settingStore = Provider.of<SettingStore>(context);
    _wishListStore = Provider.of<AuthStore>(context).wishListStore;
    _appStore = Provider.of<AppStore>(context);

    List<Product> productWishList = _wishListStore.data.map((String id) => Product(id: int.parse(id))).toList();

    String key = StringGenerate.getProductKeyStore(
      'wishlist_product',
      includeProduct: productWishList,
      currency: _settingStore.currency,
      language: _settingStore.locale,
    );

    if (_appStore.getStoreByKey(key) == null) {
      ProductsStore store = ProductsStore(
        _settingStore.requestHelper,
        include: productWishList,
        key: key,
        language: _settingStore.locale,
        currency: _settingStore.currency,
      )..getProducts();

      _appStore.addStore(store);
      _productsStore ??= store;
    } else {
      _productsStore = _appStore.getStoreByKey(key);
    }

    super.didChangeDependencies();
  }

  void refresh() {
    setState(() {});
  }

  void dismissItem(
    BuildContext context,
    int index,
    DismissDirection direction,
    Product product,
  ) {
    String id = _wishListStore.data[index];

    _wishListStore.addWishList(id);

    final snackBar = SnackBar(
      content: Text(AppLocalizations.of(context).translate('wishlist_notification_deleted', {'name': product.name})),
      action: SnackBarAction(
        label: AppLocalizations.of(context).translate('undo'),
        onPressed: () {
          _wishListStore.addWishList(id, position: index);
        },
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    double widthItem = width - 40;
    double heightItem = (widthItem * 102) / 86;

    return Observer(builder: (_) {
      List<Product> products = _productsStore.products;

      return Scaffold(
        appBar: _buildAppbar(context),
        body: _wishListStore.data.isEmpty
            ? _buildNoWishList(context)
            : ListView(
                children: List.generate(
                  _wishListStore.data.length,
                  (index) {
                    Product product = products.firstWhere(
                      (p) => '${p.id}' == _wishListStore.data[index],
                      orElse: () => Product(),
                    );
                    return DismissibleItem(
                      item: product,
                      onDismissed: (direction) => dismissItem(context, index, direction, product),
                      confirmDismiss: (DismissDirection direction) => Future.value(true),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                            child: CirillaProductItem(
                              product: product,
                              template: Strings.productItemHorizontal,
                              width: widthItem,
                              height: heightItem,
                            ),
                          ),
                          Divider(height: 1, thickness: 1),
                        ],
                      ),
                    );
                  },
                ),
              ),
      );
    });
  }

  Widget _buildAppbar(BuildContext context) {
    TranslateType translate = AppLocalizations.of(context).translate;
    return AppBar(
      title: Column(
        children: [
          Text(
            translate('wishlist'),
            style: Theme.of(context).textTheme.subtitle1,
          ),
          Text(
              translate(
                'wishlist_items',
                {
                  'count': _wishListStore.count.toString(),
                },
              ),
              style: Theme.of(context).textTheme.caption)
        ],
      ),
      actions: [
        Padding(
          padding: EdgeInsetsDirectional.only(end: 17),
          child: CirillaCartIcon(
            icon: Icon(FeatherIcons.shoppingCart),
            enableCount: true,
            color: Colors.transparent,
          ),
        )
      ],
      elevation: 0,
      titleSpacing: 20,
    );
  }

  Widget _buildNoWishList(BuildContext context) {
    TranslateType translate = AppLocalizations.of(context).translate;
    return NotificationScreen(
      iconData: FeatherIcons.heart,
      title: Container(
        width: 147,
        child: Text(
          translate('wishlist_empty'),
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      content: Container(
        width: 220,
        child: Text(
          translate('wishlist_empty_description'),
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyText2,
        ),
      ),
      textButton: Text(translate('wishlist_shopping_now')),
      onPressed: () => navigate(context, {
        "type": "tab",
        "router": "/",
        "args": {"key": "screens_category"}
      }),
    );
  }
}
