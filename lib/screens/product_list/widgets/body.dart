import 'package:cirilla/constants/constants.dart';
import 'package:cirilla/constants/strings.dart';
import 'package:cirilla/mixins/mixins.dart';
import 'package:cirilla/models/product/product.dart';
import 'package:cirilla/models/product_category/product_category.dart';
import 'package:cirilla/screens/product_list/widgets/product_list.dart';
import 'package:cirilla/store/product/filter_store.dart';
import 'package:cirilla/store/product/products_store.dart';
import 'package:cirilla/types/types.dart';
import 'package:cirilla/utils/app_localization.dart';
import 'package:cirilla/utils/currency_format.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

const List types = [
  {
    'icon': FeatherIcons.grid,
    'layout': 'grid',
    'type': Strings.productItemContained,
    'pad': 32.0,
    'isDivider': false,
    'size': Size(160, 190),
  },
  {
    'icon': FeatherIcons.square,
    'layout': 'list',
    'type': Strings.productItemContained,
    'pad': 32.0,
    'isDivider': false,
    'size': Size(335, 397),
  },
  {
    'icon': FeatherIcons.list,
    'layout': 'list',
    'type': Strings.productItemHorizontal,
    'pad': 48.0,
    'isDivider': true,
    'size': Size(86, 102),
  },
];

class Body extends StatefulWidget {
  final List<Product> products;
  final bool loading;
  final bool canLoadMore;
  final Function refresh;
  final Function getProducts;

  final Widget refine;
  final Widget sort;

  final ProductCategory category;

  final FilterStore filterStore;
  final ProductsStore productsStore;

  const Body({
    Key key,
    this.products,
    this.loading,
    this.refresh,
    this.getProducts,
    this.canLoadMore,
    this.sort,
    this.refine,
    this.category,
    this.filterStore,
    this.productsStore,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> with LoadingMixin, AppBarMixin {
  final ScrollController _controller = ScrollController();

  int visit = 0;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onScroll);
  }

  void _onScroll() {
    if (!_controller.hasClients || widget.loading || !widget.canLoadMore) return;
    final thresholdReached = _controller.position.extentAfter < endReachedThreshold;

    if (thresholdReached) {
      widget.getProducts();
    }
  }

  Widget buildType(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: List.generate(types.length, (index) {
          Map<String, dynamic> data = types[index];
          return IconButton(
            icon: Icon(data['icon']),
            iconSize: 20,
            color: index == visit ? theme.primaryColor : null,
            constraints: BoxConstraints(minWidth: 36, maxWidth: 36),
            splashRadius: 18,
            onPressed: () => setState(() {
              if (index != visit) {
                visit = index;
              }
            }),
          );
        }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> typeView = types[visit] ?? types[1];
    TranslateType translate = AppLocalizations.of(context).translate;

    FilterStore filterStore = widget.productsStore.filter;

    List<Map<String, dynamic>> filters = [
      {
        'text': translate('product_list_clear_all'),
        'onDeleted': () => filterStore.clearAll(category: widget.category),
      }
    ];

    if (filterStore.inStock) {
      filters.add({
        'text': translate('product_list_in_stock'),
        'onDeleted': () => filterStore.onChange(inStock: false),
      });
    }

    if (filterStore.onSale) {
      filters.add({
        'text': translate('product_list_on_sale'),
        'onDeleted': () => filterStore.onChange(onSale: false),
      });
    }

    if (filterStore.featured) {
      filters.add({
        'text': translate('product_list_featured'),
        'onDeleted': () => filterStore.onChange(featured: false),
      });
    }

    if (filterStore.category != null && filterStore.category.id != widget.category.id) {
      filters.add({
        'text': filterStore.category.name,
        'onDeleted': () => filterStore.onChange(category: widget.category),
      });
    }

    if (filterStore.attributeSelected.length > 0) {
      for (int i = 0; i < filterStore.attributeSelected.length; i++) {
        filters.add({
          'text': filterStore.attributeSelected[i].title,
          'onDeleted': () {
            filterStore.selectAttribute(filterStore.attributeSelected[i]);
            filterStore.onChange(attributeSelected: filterStore.attributeSelected);
          },
        });
      }
    }

    if (filterStore.rangePrices.start > widget.filterStore.productPrices.minPrice) {
      filters.add({
        'text': translate(
          'product_list_min_price',
          {
            'price': formatCurrency(context, price: '${filterStore.rangePrices.start}'),
          },
        ),
        'onDeleted': () {
          RangeValues rangePrices = RangeValues(
            widget.filterStore.productPrices.minPrice,
            filterStore.rangePrices.end,
          );
          filterStore.onChange(rangePrices: rangePrices);
        },
      });
    }

    if (filterStore.rangePrices.end < widget.filterStore.productPrices.maxPrice && filterStore.rangePrices.end > 0) {
      filters.add({
        'text': translate(
          'product_list_max_price',
          {
            'price': formatCurrency(context, price: '${filterStore.rangePrices.end}'),
          },
        ),
        'onDeleted': () {
          RangeValues rangePrices = RangeValues(
            filterStore.rangePrices.start,
            widget.filterStore.productPrices.maxPrice,
          );
          filterStore.onChange(rangePrices: rangePrices);
        },
      });
    }

    return CustomScrollView(
      physics: BouncingScrollPhysics(),
      controller: _controller,
      slivers: <Widget>[
        SliverAppBar(
          leading: leading(),
          title: Text(widget.category != null ? widget.category.name : translate('product_list_products')),
          pinned: false,
          floating: false,
          actions: [
            SizedBox(),
          ],
        ),
        SliverPersistentHeader(
          pinned: false,
          floating: true,
          delegate: StickyTabBarDelegate(
            child: Header(
              color: Theme.of(context).colorScheme.surface,
              leading: Row(
                children: [
                  if (widget.sort != null) widget.sort,
                  if (widget.refine != null) widget.refine,
                ],
              ),
              trailing: Expanded(
                child: buildType(context),
              ),
            ),
          ),
        ),
        if (filters.length > 1)
          SliverPersistentHeader(
            pinned: false,
            floating: true,
            delegate: StickyTabBarDelegate(
              child: Container(
                alignment: Alignment.centerLeft,
                child: Container(
                  child: ListView(
                    padding: EdgeInsetsDirectional.only(start: 20, end: 20),
                    scrollDirection: Axis.horizontal,
                    children: [
                      ...List.generate(filters.length, (index) {
                        return Padding(
                          padding: EdgeInsetsDirectional.only(end: 8),
                          child: InputChip(
                            label: Text(filters[index]['text']),
                            deleteIcon: Icon(Icons.clear, size: 16),
                            onDeleted: filters[index]['onDeleted'],
                          ),
                        );
                      }).toList(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        CupertinoSliverRefreshControl(
          onRefresh: widget.refresh,
          builder: buildAppRefreshIndicator,
        ),
        SliverPadding(padding: EdgeInsets.only(top: filters.length > 1 ? 0 : 24)),
        ProductListLayout(
          products: widget.products,
          layout: typeView['layout'],
          templateItem: typeView['type'],
          pad: typeView['pad'],
          isDivider: typeView['isDivider'],
          size: typeView['size'],
        ),
        if (widget.loading)
          SliverToBoxAdapter(
            child: buildLoading(context, isLoading: widget.canLoadMore),
          ),
      ],
    );
  }
}
