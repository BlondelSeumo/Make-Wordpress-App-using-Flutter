import 'package:cirilla/constants/strings.dart';
import 'package:cirilla/mixins/cart_mixin.dart';
import 'package:cirilla/mixins/mixins.dart';

import 'package:cirilla/models/models.dart';
import 'package:cirilla/models/product/product_type.dart';
import 'package:cirilla/service/helpers/request_helper.dart';
import 'package:cirilla/store/app_store.dart';
import 'package:cirilla/store/product/variation_store.dart';
import 'package:cirilla/store/setting/setting_store.dart';
import 'package:cirilla/utils/app_localization.dart';
import 'package:cirilla/utils/convert_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import 'layout/default.dart';
import 'layout/zoom.dart';
import 'layout/scroll.dart';

import 'widgets/product_appbar.dart';
import 'widgets/product_bottom_bar.dart';
import 'widgets/product_slideshow.dart';
import 'widgets/product_category.dart' as pc;
import 'widgets/product_name.dart';
import 'widgets/product_rating.dart';
import 'widgets/product_price.dart';
import 'widgets/product_type.dart';
import 'widgets/product_quantity.dart';
import 'widgets/product_description.dart';
import 'widgets/product_related.dart';
import 'widgets/product_addition_information.dart';
import 'widgets/product_review.dart';
import 'widgets/product_sort_description.dart';
import 'widgets/product_status.dart';
import 'widgets/product_add_to_cart.dart';
import 'widgets/product_action.dart';
import 'widgets/product_custom.dart';

class ProductScreen extends StatefulWidget {
  static const String routeName = '/product';

  const ProductScreen({Key key, this.args, this.store}) : super(key: key);

  final Map args;
  final SettingStore store;

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> with Utility, CartMixin, SnackMixin, LoadingMixin {
  AppStore _appStore;

  // Add to cart loading
  bool _addToCartLoading = false;

  Product _product;
  int _qty = 1;
  VariationStore _variationStore;
  Map<int, int> _groupQty = {};

  bool _loading = true;

  @override
  void didChangeDependencies() {
    _appStore = Provider.of<AppStore>(context);
    if (widget.args != null && widget.args['product'] != null) {
      setState(() {
        _loading = false;
      });
      _product = widget.args['product'];
      init();
    } else {
      getProduct(widget.args['id']);
    }
    super.didChangeDependencies();
  }

  void init() {
    if (_product != null && _product.type == ProductType.variable) {
      String key = 'variation_${_product.id}';
      if (_appStore.getStoreByKey(key) == null) {
        VariationStore store = VariationStore(
          Provider.of<RequestHelper>(context),
          productId: _product.id,
          key: key,
        )..getVariation();
        _appStore.addStore(store);
        _variationStore ??= store;
      } else {
        _variationStore = _appStore.getStoreByKey(key);
      }
    }
  }

  Future<void> getProduct(int id) async {
    try {
      _product = await Provider.of<RequestHelper>(context).getProduct(id: id);
      setState(() {
        _loading = false;
      });
      init();
    } catch (e) {
      setState(() {
        _loading = false;
      });
      showError(context, e);
    }
  }

  void setLoading(bool value) {
    setState(() {
      _addToCartLoading = value;
    });
  }

  void _updateGroupQty({Product product, qty = 1}) {
    Map<int, int> groupQty = Map<int, int>.of(_groupQty);
    if (_groupQty.containsKey(product.id)) {
      groupQty.update(product.id, (value) => qty);
    } else {
      groupQty.putIfAbsent(product.id, () => qty);
    }
    setState(() {
      _groupQty = groupQty;
    });
  }

  ///
  /// Handle add to cart
  Future<void> _handleAddToCart() async {
    if (_product == null || _product.id == null) return;
    setLoading(true);
    try {
      // Check product variable
      if (_product.type == ProductType.variable) {
        // Exist variation store not exist
        if (_variationStore == null || !_variationStore.canAddToCart) {
          setLoading(false);
          return;
        }
        // Prepare variation data for cart
        List<Map<String, dynamic>> variation = _variationStore.selected.entries
            .map((e) => {
                  'attribute': e.key,
                  'value': e.value,
                })
            .toList();
        await addToCart(
          productId: _variationStore.productVariation.id,
          qty: _qty,
          variation: variation,
        );
      } else if (_product.type == ProductType.grouped) {
        if (_groupQty.keys.length == 0) {
          setLoading(false);
          return;
        }
        int i = 0;
        List<int> keys = _groupQty.keys.toList();
        await Future.doWhile(() async {
          await addToCart(productId: keys[i], qty: _groupQty[keys[i]]);
          i++;
          return i < keys.length;
        });
      } else {
        await addToCart(productId: _product.id, qty: _qty);
      }
      showSuccess(context, AppLocalizations.of(context).translate('product_add_to_cart_success'));
      setState(() {
        _addToCartLoading = false;
        _qty = 1;
      });
    } catch (e) {
      print(e);
      showError(context, e);
      setLoading(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.store.data == null) return Container();

    SettingStore settingStore = Provider.of<SettingStore>(context);
    String themeModeKey = settingStore?.themeModeKey ?? 'value';

    if (_loading) {
      return Scaffold(
        body: Center(child: buildLoading(context, isLoading: _loading)),
      );
    }

    return Observer(builder: (_) {
      // Settings
      Data data = widget.store.data.screens['product'];
      String appBarType = get(data.configs, ['appBarType'], 'floating');
      bool extendBodyBehindAppBar = get(data.configs, ['extendBodyBehindAppBar'], true);
      bool enableAppbar = get(data.configs, ['enableAppbar'], true);
      bool enableBottomBar = get(data.configs, ['enableBottomBar'], false);
      bool enableCartIcon = get(data.configs, ['enableCartIcon'], false);
      String cartIconType = get(data.configs, ['cartIconType'], 'pinned');
      String floatingActionButtonLocation = get(data.configs, ['floatingActionButtonLocation'], 'centerDocked');

      // Configs
      WidgetConfig configs = data.widgets['productDetailPage'];

      // Config slideshow size
      dynamic size = get(configs.fields, ['productGallerySize'], {'width': 375, 'height': 440});
      double height = ConvertData.stringToDouble(size is Map ? size['height'] : '440');

      // Layout
      String layout = configs.layout ?? Strings.productDetailLayoutDefault;

      // Style
      Color background = ConvertData.fromRGBA(
          get(configs.styles, ['background', themeModeKey]), Theme.of(context).scaffoldBackgroundColor);

      // Build Product Content
      List<dynamic> rows = get(configs.fields, ['rows'], []);

      // Map<String, Widget> blocks = buildBlocksInfo(configs);
      List<Widget> rowList = buildRows(rows, background: background, themeModeKey: themeModeKey);

      Widget appbar = enableAppbar
          ? ProductAppbar(
              configs: data.configs,
              product: _product,
            )
          : null;

      Widget bottomBar = enableBottomBar
          ? ProductBottomBar(
              configs: data.configs,
              product: _product,
              onPress: _handleAddToCart,
              loading: _addToCartLoading,
              qty: ProductQuantity(
                qty: _qty,
                onChanged: (int value) {
                  setState(() {
                    _qty = value;
                  });
                },
              ),
            )
          : null;

      Widget cartIcon = enableCartIcon ? buildCartIcon(context) : null;

      if (layout == Strings.productDetailLayoutZoom) {
        return ProductLayoutZoomSlideshow(
          product: _product,
          appbar: appbar,
          bottomBar: bottomBar,
          slideshow: buildSlideshow(configs),
          productInfo: rowList,
          extendBodyBehindAppBar: extendBodyBehindAppBar,
          height: height,
          appBarType: appBarType,
          cartIcon: cartIcon,
          cartIconType: cartIconType,
          floatingActionButtonLocation: floatingActionButtonLocation,
        );
      }

      if (layout == Strings.productDetailLayoutScroll) {
        return ProductLayoutDraggableScrollableSheet(
          product: _product,
          appbar: appbar,
          bottomBar: bottomBar,
          slideshow: buildSlideshow(configs),
          productInfo: rowList,
          extendBodyBehindAppBar: extendBodyBehindAppBar,
          // height: height,
          // appBarType: appBarType,
          addToCart: _handleAddToCart,
          addToCartLoading: _addToCartLoading,
          cartIcon: cartIcon,
          cartIconType: cartIconType,
          floatingActionButtonLocation: floatingActionButtonLocation,
        );
      }

      return ProductLayoutDefault(
        product: _product,
        appbar: appbar,
        bottomBar: bottomBar,
        slideshow: buildSlideshow(configs),
        productInfo: rowList,
        extendBodyBehindAppBar: extendBodyBehindAppBar,
        cartIcon: cartIcon,
        cartIconType: cartIconType,
        floatingActionButtonLocation: floatingActionButtonLocation,
      );
    });
  }

  Widget buildCartIcon(BuildContext context) {
    return FloatingActionButton(
      onPressed: _handleAddToCart,
      child: _addToCartLoading
          ? entryLoading(context, color: Theme.of(context).colorScheme.onPrimary)
          : Icon(Icons.shopping_cart),
      // backgroundColor: Theme.of(context).primaryColor,
    );
  }

  List<Widget> buildRows(List<dynamic> rows, {Color background = Colors.white, String themeModeKey}) {
    if (rows == null) return [Container()];

    return rows.map((e) {
      String mainAxisAlignment = get(e, ['data', 'mainAxisAlignment'], 'start');
      String crossAxisAlignment = get(e, ['data', 'crossAxisAlignment'], 'start');
      bool divider = get(e, ['data', 'divider'], false);
      List<dynamic> columns = get(e, ['data', 'columns']);

      return Container(
        color: background,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: ConvertData.mainAxisAlignment(mainAxisAlignment),
              crossAxisAlignment: ConvertData.crossAxisAlignment(crossAxisAlignment),
              children: buildColumn(columns, themeModeKey: themeModeKey),
            ),
            if (divider) Divider(endIndent: 20, indent: 20),
          ],
        ),
      );
    }).toList();
  }

  List<Widget> buildColumn(List<dynamic> columns, {String themeModeKey}) {
    if (columns == null) return [Container()];
    return columns.map((e) {
      String type = get(e, ['value', 'type'], '');

      int flex = ConvertData.stringToInt(get(e, ['value', 'flex'], '1'), 1);

      bool expand = get(e, ['value', 'expand'], false);

      EdgeInsetsDirectional margin = ConvertData.space(
        get(e, ['value', 'margin'], null),
        'margin',
        EdgeInsetsDirectional.zero,
      );

      EdgeInsetsDirectional padding = ConvertData.space(
        get(e, ['value', 'padding'], null),
        'padding',
        EdgeInsetsDirectional.only(start: 20, end: 20),
      );

      String align = get(e, ['value', 'align'], 'left');

      Color foreground = ConvertData.fromRGBA(
          get(e, ['value', 'foreground', themeModeKey]), Theme.of(context).scaffoldBackgroundColor);

      return Expanded(
        child: Container(
          margin: margin,
          padding: type == ProductBlocks.RelatedProduct ? EdgeInsets.zero : padding,
          color: foreground,
          child: buildBlock(
            type,
            padding: padding,
            align: align,
            expand: expand,
          ),
        ),
        flex: flex,
      );
    }).toList();
  }

  Widget buildBlock(
    String type, {
    EdgeInsetsDirectional margin = EdgeInsetsDirectional.zero,
    EdgeInsetsDirectional padding = EdgeInsetsDirectional.zero,
    bool expand = false,
    String align = 'left',
  }) {
    if (type == ProductBlocks.RelatedProduct) {
      return ProductRelated(product: _product, padding: padding, align: align);
    }

    if (type == ProductBlocks.Quantity && _product.type == ProductType.grouped) {
      return Container();
    }

    switch (type) {
      case ProductBlocks.Category:
        return pc.ProductCategory(product: _product, align: align);
      case ProductBlocks.Name:
        return ProductName(product: _product, align: align);
      case ProductBlocks.Rating:
        return ProductRating(product: _product, align: align);
      case ProductBlocks.Price:
        return ProductPrice(
          product: _variationStore != null && _variationStore.productVariation != null
              ? _variationStore.productVariation
              : _product,
          align: align,
        );
      case ProductBlocks.Status:
        return ProductStatus(product: _product, align: align);
      case ProductBlocks.Type:
        return ProductTypeWidget(
          product: _product,
          store: _variationStore,
          align: align,
          qty: _groupQty,
          onChanged: _updateGroupQty,
        );
      case ProductBlocks.Quantity:
        return ProductQuantity(
          qty: _qty,
          onChanged: (int value) {
            setState(() {
              _qty = value;
            });
          },
          align: align,
        );
      case ProductBlocks.SortDescription:
        return ProductSortDescription(product: _product);
      case ProductBlocks.Description:
        return ProductDescription(
          product: _product,
          expand: expand,
          align: align,
        );
      case ProductBlocks.AdditionInformation:
        return ProductAdditionInformation(
          product: _product,
          expand: expand,
          align: align,
        );
      case ProductBlocks.Review:
        return ProductReview(
          product: _product,
          expand: expand,
          align: align,
        );
      case ProductBlocks.RelatedProduct:
        return ProductRelated(product: _product, padding: padding, align: align);
      case ProductBlocks.AddToCart:
        return ProductAddToCart(
          product: _product,
          onPress: _handleAddToCart,
          loading: _addToCartLoading,
        );
      case ProductBlocks.Action:
        return ProductAction(product: _product, align: align);
      case ProductBlocks.Custom:
        return ProductCustom();
      default:
        return Container(child: Text(type));
    }
  }

  Widget buildSlideshow(WidgetConfig configs) {
    int scrollDirection = ConvertData.stringToInt(get(configs.fields, ['productGalleryScrollDirection'], 0));

    // Config size
    dynamic size = get(configs.fields, ['productGallerySize'], {'width': 375, 'height': 440});
    double width = ConvertData.stringToDouble(size is Map ? size['width'] : '375');
    double height = ConvertData.stringToDouble(size is Map ? size['height'] : '440');

    // Image fit
    String productGalleryFit = get(configs.fields, ['productGalleryFit'], 'cover');

    return ProductSlideshow(
      images: _variationStore != null && _variationStore.productVariation != null
          ? _variationStore.productVariation.images
          : _product.images,
      scrollDirection: scrollDirection,
      width: width,
      height: height,
      productGalleryFit: productGalleryFit,
      configs: configs,
    );
  }
}
