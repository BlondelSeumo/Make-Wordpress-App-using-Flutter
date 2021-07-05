import 'package:cirilla/constants/strings.dart';
import 'package:cirilla/mixins/mixins.dart';
import 'package:cirilla/models/models.dart';
import 'package:cirilla/store/product/filter_store.dart';
import 'package:cirilla/store/product/products_store.dart';
import 'package:cirilla/store/setting/setting_store.dart';
import 'package:cirilla/utils/app_localization.dart';
import 'package:cirilla/utils/convert_data.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'widgets/body.dart';
import 'widgets/refine.dart';
import 'widgets/sort.dart';

/// Filter product on catalog screen
Function productCatalog = (product) => product.catalogVisibility == 'visible' || product.catalogVisibility == 'catalog';

class ProductListScreen extends StatefulWidget {
  static const routeName = '/product_list';

  const ProductListScreen({Key key, this.args, this.store}) : super(key: key);

  @override
  _ProductListScreenState createState() => _ProductListScreenState();

  final Map args;
  final SettingStore store;
}

class _ProductListScreenState extends State<ProductListScreen> with ShapeMixin, Utility {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  ProductsStore _productsStore;
  FilterStore _filterStore;

  @override
  void initState() {
    super.initState();
    // Configs
    Data data = widget.store.data.screens['products'];
    WidgetConfig widgetConfig = data.widgets['productListPage'];
    _productsStore = ProductsStore(
      widget.store.requestHelper,
      category: widget.args != null ? widget.args['category'] : null,
      perPage: ConvertData.stringToInt(get(widgetConfig.fields, ['itemPerPage'], 10)),
      currency: widget.store.currency,
      language: widget.store.locale,
    );
    _filterStore = FilterStore(
      widget.store.requestHelper,
      category: widget.args['category'],
    );
    init();
  }

  Future<void> init() async {
    await _productsStore.getProducts();
    await _filterStore.getAttributes();
    await _filterStore.getMinMaxPrices();
  }

  // Fetch product data
  Future<void> _getProducts() async {
    return _productsStore.getProducts();
  }

  Future _refresh() {
    return _productsStore.refresh();
  }

  void _clearAll() {
    _filterStore.onChange(
      inStock: _productsStore.filter.inStock,
      onSale: _productsStore.filter.onSale,
      featured: _productsStore.filter.featured,
      category: _productsStore.filter.category,
      attributeSelected: _productsStore.filter.attributeSelected,
      productPrices: _productsStore.filter.productPrices,
      rangePrices: _productsStore.filter.rangePrices,
    );
  }

  void onSubmit(FilterStore filter) {
    if (filter != null) {
      print(filter.attributeSelected);
      _productsStore.onChanged(filterStore: filter);
    } else {
      _clearAll();
    }
  }

  @override
  Widget build(BuildContext context) {
    // Configs
    Data data = widget.store.data.screens['products'];
    WidgetConfig widgetConfig = data.widgets['productListPage'];

    String refinePosition = get(widgetConfig.fields, ['refinePosition'], Strings.refinePositionBottom);
    String refineItemStyle = get(widgetConfig.fields, ['refineItemStyle'], Strings.refineItemStyleListTitle);
    int itemPerPage = ConvertData.stringToInt(get(widgetConfig.fields, ['itemPerPage'], 10));

    List<Product> loadingProduct = List.generate(itemPerPage, (index) => Product()).toList();

    return Observer(
      builder: (_) {
        bool isShimmer = _productsStore.products.length == 0 && _productsStore.loading;
        return Scaffold(
          key: _scaffoldKey,
          drawer: Drawer(
            child: buildRefine(context, min: 1, refineItemStyle: refineItemStyle),
          ),
          endDrawer: Drawer(
            child: buildRefine(context, min: 1, refineItemStyle: refineItemStyle),
          ),
          body: SafeArea(
            child: Body(
              category: widget.args['category'],
              products: isShimmer ? loadingProduct : _productsStore.products.where(productCatalog).toList(),
              loading: _productsStore.loading,
              refresh: _refresh,
              getProducts: _getProducts,
              canLoadMore: _productsStore.canLoadMore,
              sort: buildSort(context),
              refine: buildButtonRefine(context, refinePosition: refinePosition, refineItemStyle: refineItemStyle),
              filterStore: _filterStore,
              productsStore: _productsStore,
            ),
          ),
        );
      },
    );
  }

  Widget buildSort(BuildContext context) {
    return TextButton(
      child: Row(
        children: [
          Icon(FeatherIcons.barChart2, size: 20),
          SizedBox(width: 8),
          Text(AppLocalizations.of(context).translate('product_list_sort'))
        ],
      ),
      onPressed: () async {
        Map<String, dynamic> sort = await showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          shape: borderRadiusTop(),
          builder: (context) {
            return Sort(
              value: _productsStore.sort,
            );
          },
        );
        if (sort != null) {
          _productsStore.onChanged(sort: sort);
        }
      },
    );
  }

  Widget buildButtonRefine(
    BuildContext context, {
    String refinePosition = Strings.refinePositionBottom,
    String refineItemStyle,
  }) {
    return TextButton(
      child: Row(
        children: [
          Icon(FeatherIcons.sliders, size: 20),
          SizedBox(width: 8),
          Text(AppLocalizations.of(context).translate('product_list_refine'))
        ],
      ),
      onPressed: () async {
        if (refinePosition == Strings.refinePositionLeft) {
          _scaffoldKey.currentState.openDrawer();
        } else if (refinePosition == Strings.refinePositionRight) {
          _scaffoldKey.currentState.openEndDrawer();
        } else {
          showModalBottomSheet<FilterStore>(
            isScrollControlled: true,
            context: context,
            shape: borderRadiusTop(),
            builder: (context) => buildRefine(context, refineItemStyle: refineItemStyle),
          );
        }
      },
    );
  }

  Widget buildRefine(
    BuildContext context, {
    double min = 0.8,
    String refineItemStyle = Strings.refineItemStyleListTitle,
  }) {
    return Refine(
      filterStore: _filterStore,
      category: widget.args['category'],
      clearAll: _clearAll,
      onSubmit: onSubmit,
      min: min,
      refineItemStyle: refineItemStyle,
    );
  }
}
