import 'dart:convert';

import 'package:cirilla/models/product/product.dart';
import 'package:cirilla/models/product_category/product_category.dart';
import 'package:cirilla/service/helpers/request_helper.dart';
import 'package:cirilla/store/error/error_store.dart';
import 'package:cirilla/store/product/filter_store.dart';
import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';

part 'products_store.g.dart';

class ProductsStore = _ProductsStore with _$ProductsStore;

abstract class _ProductsStore with Store {
  final String key;

  // Request helper instance
  RequestHelper _requestHelper;

  // store for handling errors
  final ErrorStore errorStore = ErrorStore();

  // Filter store
  @observable
  FilterStore _filterStore;

  // constructor:-------------------------------------------------------------------------------------------------------
  _ProductsStore(
    RequestHelper requestHelper, {
    this.key,
    ProductCategory category,
    bool onSale,
    bool featured,
    int perPage,
    String search,
    Map sort,
    List<Product> include,
    List<Product> exclude,
    List<int> tag,
    String currency,
    String language,
  }) {
    _requestHelper = requestHelper;
    _filterStore = FilterStore(
      requestHelper,
      category: category,
      onSale: onSale,
      featured: featured,
      productsStore: this,
    );
    if (perPage != null) _perPage = perPage;
    if (search != null) _search = search;
    if (sort != null) _sort = sort;
    if (include != null) _include = ObservableList<Product>.of(include);
    if (exclude != null) _exclude = ObservableList<Product>.of(exclude);
    if (tag != null) _tag = ObservableList<int>.of(tag);
    if (currency != null) _currency = currency;
    if (language != null) _language = language;
    _reaction();
  }

  // store variables:---------------------------------------------------------------------------------------------------
  static ObservableFuture<List<Product>> emptyPostResponse = ObservableFuture.value([]);

  @observable
  ObservableFuture<List<Product>> fetchProductsFuture = emptyPostResponse;

  @observable
  ObservableList<Product> _products = ObservableList<Product>.of([]);

  @observable
  bool success = false;

  @observable
  int _nextPage = 1;

  @observable
  int _perPage = 20;

  @observable
  ObservableList<Product> _include = ObservableList<Product>.of([]);

  @observable
  ObservableList<Product> _exclude = ObservableList<Product>.of([]);

  @observable
  ObservableList<int> _tag = ObservableList<int>.of([]);

  @observable
  bool _canLoadMore = true;

  @observable
  String _search = '';

  @observable
  String _currency = '';

  @observable
  String _language = '';

  @observable
  Map<String, dynamic> _sort = {
    'key': 'product_list_default',
    'query': {
      'order': 'asc',
      'orderby': 'menu_order',
    }
  };

  // computed:----------------------------------------------------------------------------------------------------------
  @computed
  RequestHelper get requestHelper => _requestHelper;

  @computed
  bool get loading => fetchProductsFuture.status == FutureStatus.pending;

  @computed
  ObservableList<Product> get products => _products;

  @computed
  bool get canLoadMore => _canLoadMore;

  @computed
  Map get sort => _sort;

  @computed
  int get perPage => _perPage;

  @computed
  FilterStore get filter => _filterStore;

  @computed
  String get search => _search;

  // actions:-----------------------------------------------------------------------------------------------------------
  @action
  Future<List<Product>> getProducts({CancelToken token}) async {
    Map<String, dynamic> query = {
      "page": _nextPage,
      "category": _filterStore.category != null ? _filterStore.category.id : '',
      "per_page": _perPage,
      "status": "publish",
      "search": _search,
      "order": _sort['query']['order'],
      "orderby": _sort['query']['orderby'],
      "include": _include.map((e) => e.id).toList().join(','),
      "exclude": _exclude.map((e) => e.id).toList().join(','),
      "tag": _tag.join(','),
      "min_price": _filterStore.rangePrices.start > 0 ? _filterStore.rangePrices.start : null,
      "max_price": _filterStore.rangePrices.end > 0 ? _filterStore.rangePrices.end : null,
      "currency": _currency,
      "language": _language,
    };

    if (_filterStore.featured) {
      query['featured'] = _filterStore.featured;
    }

    if (_filterStore.onSale) {
      query['on_sale'] = _filterStore.onSale;
    }

    if (_filterStore.inStock) {
      query['stock_status'] = 'instock';
    }

    if (_filterStore.attributeSelected.length > 0) {
      query['attrs'] = jsonEncode(_filterStore.attributeSelected.map((attr) => attr.query).toList());
    }

    query.removeWhere((key, value) => key == null || value == null || value == "");

    final future = _requestHelper.getProducts(queryParameters: query, cancelToken: token);
    fetchProductsFuture = ObservableFuture(future);
    return future.then((products) {
      // Replace state in the first time or refresh
      if (_nextPage <= 1) {
        _products = ObservableList<Product>.of(products);
      } else {
        // Add products when load more page
        _products.addAll(ObservableList<Product>.of(products));
      }

      // Check if can load more item
      if (products.length >= _perPage) {
        _nextPage++;
      } else {
        _canLoadMore = false;
      }
      return products;
    }).catchError((error) {
      throw error;
    });
  }

  @action
  Future<List<Product>> refresh({CancelToken token}) {
    _canLoadMore = true;
    _nextPage = 1;
    _products.clear();
    return getProducts(token: token);
  }

  @action
  void onChanged({
    Map sort,
    String search,
    ProductCategory category,
    int perPage,
    FilterStore filterStore,
  }) {
    if (sort != null) _sort = sort;
    if (search != null) _search = search;
    if (perPage != null) _perPage = perPage;
    if (filterStore != null)
      _filterStore.onChange(
        inStock: filterStore.inStock,
        onSale: filterStore.onSale,
        featured: filterStore.featured,
        category: filterStore.category,
        attributeSelected: filterStore.attributeSelected,
        rangePrices: filterStore.rangePrices,
        productPrices: filterStore.productPrices,
      );
  }

  // disposers:---------------------------------------------------------------------------------------------------------
  List<ReactionDisposer> _disposers;

  void _reaction() {
    _disposers = [
      reaction((_) => _sort, (key) => refresh()),
    ];
  }

  void dispose() {
    for (final d in _disposers) {
      d();
    }
  }
}
