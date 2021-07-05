// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'products_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ProductsStore on _ProductsStore, Store {
  Computed<RequestHelper> _$requestHelperComputed;

  @override
  RequestHelper get requestHelper => (_$requestHelperComputed ??=
          Computed<RequestHelper>(() => super.requestHelper, name: '_ProductsStore.requestHelper'))
      .value;
  Computed<bool> _$loadingComputed;

  @override
  bool get loading => (_$loadingComputed ??= Computed<bool>(() => super.loading, name: '_ProductsStore.loading')).value;
  Computed<ObservableList<Product>> _$productsComputed;

  @override
  ObservableList<Product> get products =>
      (_$productsComputed ??= Computed<ObservableList<Product>>(() => super.products, name: '_ProductsStore.products'))
          .value;
  Computed<bool> _$canLoadMoreComputed;

  @override
  bool get canLoadMore =>
      (_$canLoadMoreComputed ??= Computed<bool>(() => super.canLoadMore, name: '_ProductsStore.canLoadMore')).value;
  Computed<Map<dynamic, dynamic>> _$sortComputed;

  @override
  Map<dynamic, dynamic> get sort =>
      (_$sortComputed ??= Computed<Map<dynamic, dynamic>>(() => super.sort, name: '_ProductsStore.sort')).value;
  Computed<int> _$perPageComputed;

  @override
  int get perPage => (_$perPageComputed ??= Computed<int>(() => super.perPage, name: '_ProductsStore.perPage')).value;
  Computed<FilterStore> _$filterComputed;

  @override
  FilterStore get filter =>
      (_$filterComputed ??= Computed<FilterStore>(() => super.filter, name: '_ProductsStore.filter')).value;
  Computed<String> _$searchComputed;

  @override
  String get search => (_$searchComputed ??= Computed<String>(() => super.search, name: '_ProductsStore.search')).value;

  final _$_filterStoreAtom = Atom(name: '_ProductsStore._filterStore');

  @override
  FilterStore get _filterStore {
    _$_filterStoreAtom.reportRead();
    return super._filterStore;
  }

  @override
  set _filterStore(FilterStore value) {
    _$_filterStoreAtom.reportWrite(value, super._filterStore, () {
      super._filterStore = value;
    });
  }

  final _$fetchProductsFutureAtom = Atom(name: '_ProductsStore.fetchProductsFuture');

  @override
  ObservableFuture<List<Product>> get fetchProductsFuture {
    _$fetchProductsFutureAtom.reportRead();
    return super.fetchProductsFuture;
  }

  @override
  set fetchProductsFuture(ObservableFuture<List<Product>> value) {
    _$fetchProductsFutureAtom.reportWrite(value, super.fetchProductsFuture, () {
      super.fetchProductsFuture = value;
    });
  }

  final _$_productsAtom = Atom(name: '_ProductsStore._products');

  @override
  ObservableList<Product> get _products {
    _$_productsAtom.reportRead();
    return super._products;
  }

  @override
  set _products(ObservableList<Product> value) {
    _$_productsAtom.reportWrite(value, super._products, () {
      super._products = value;
    });
  }

  final _$successAtom = Atom(name: '_ProductsStore.success');

  @override
  bool get success {
    _$successAtom.reportRead();
    return super.success;
  }

  @override
  set success(bool value) {
    _$successAtom.reportWrite(value, super.success, () {
      super.success = value;
    });
  }

  final _$_nextPageAtom = Atom(name: '_ProductsStore._nextPage');

  @override
  int get _nextPage {
    _$_nextPageAtom.reportRead();
    return super._nextPage;
  }

  @override
  set _nextPage(int value) {
    _$_nextPageAtom.reportWrite(value, super._nextPage, () {
      super._nextPage = value;
    });
  }

  final _$_perPageAtom = Atom(name: '_ProductsStore._perPage');

  @override
  int get _perPage {
    _$_perPageAtom.reportRead();
    return super._perPage;
  }

  @override
  set _perPage(int value) {
    _$_perPageAtom.reportWrite(value, super._perPage, () {
      super._perPage = value;
    });
  }

  final _$_includeAtom = Atom(name: '_ProductsStore._include');

  @override
  ObservableList<Product> get _include {
    _$_includeAtom.reportRead();
    return super._include;
  }

  @override
  set _include(ObservableList<Product> value) {
    _$_includeAtom.reportWrite(value, super._include, () {
      super._include = value;
    });
  }

  final _$_excludeAtom = Atom(name: '_ProductsStore._exclude');

  @override
  ObservableList<Product> get _exclude {
    _$_excludeAtom.reportRead();
    return super._exclude;
  }

  @override
  set _exclude(ObservableList<Product> value) {
    _$_excludeAtom.reportWrite(value, super._exclude, () {
      super._exclude = value;
    });
  }

  final _$_tagAtom = Atom(name: '_ProductsStore._tag');

  @override
  ObservableList<int> get _tag {
    _$_tagAtom.reportRead();
    return super._tag;
  }

  @override
  set _tag(ObservableList<int> value) {
    _$_tagAtom.reportWrite(value, super._tag, () {
      super._tag = value;
    });
  }

  final _$_canLoadMoreAtom = Atom(name: '_ProductsStore._canLoadMore');

  @override
  bool get _canLoadMore {
    _$_canLoadMoreAtom.reportRead();
    return super._canLoadMore;
  }

  @override
  set _canLoadMore(bool value) {
    _$_canLoadMoreAtom.reportWrite(value, super._canLoadMore, () {
      super._canLoadMore = value;
    });
  }

  final _$_searchAtom = Atom(name: '_ProductsStore._search');

  @override
  String get _search {
    _$_searchAtom.reportRead();
    return super._search;
  }

  @override
  set _search(String value) {
    _$_searchAtom.reportWrite(value, super._search, () {
      super._search = value;
    });
  }

  final _$_currencyAtom = Atom(name: '_ProductsStore._currency');

  @override
  String get _currency {
    _$_currencyAtom.reportRead();
    return super._currency;
  }

  @override
  set _currency(String value) {
    _$_currencyAtom.reportWrite(value, super._currency, () {
      super._currency = value;
    });
  }

  final _$_languageAtom = Atom(name: '_ProductsStore._language');

  @override
  String get _language {
    _$_languageAtom.reportRead();
    return super._language;
  }

  @override
  set _language(String value) {
    _$_languageAtom.reportWrite(value, super._language, () {
      super._language = value;
    });
  }

  final _$_sortAtom = Atom(name: '_ProductsStore._sort');

  @override
  Map<String, dynamic> get _sort {
    _$_sortAtom.reportRead();
    return super._sort;
  }

  @override
  set _sort(Map<String, dynamic> value) {
    _$_sortAtom.reportWrite(value, super._sort, () {
      super._sort = value;
    });
  }

  final _$getProductsAsyncAction = AsyncAction('_ProductsStore.getProducts');

  @override
  Future<List<Product>> getProducts({CancelToken token}) {
    return _$getProductsAsyncAction.run(() => super.getProducts(token: token));
  }

  final _$_ProductsStoreActionController = ActionController(name: '_ProductsStore');

  @override
  Future<List<Product>> refresh({CancelToken token}) {
    final _$actionInfo = _$_ProductsStoreActionController.startAction(name: '_ProductsStore.refresh');
    try {
      return super.refresh(token: token);
    } finally {
      _$_ProductsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void onChanged(
      {Map<dynamic, dynamic> sort, String search, ProductCategory category, int perPage, FilterStore filterStore}) {
    final _$actionInfo = _$_ProductsStoreActionController.startAction(name: '_ProductsStore.onChanged');
    try {
      return super
          .onChanged(sort: sort, search: search, category: category, perPage: perPage, filterStore: filterStore);
    } finally {
      _$_ProductsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
fetchProductsFuture: ${fetchProductsFuture},
success: ${success},
requestHelper: ${requestHelper},
loading: ${loading},
products: ${products},
canLoadMore: ${canLoadMore},
sort: ${sort},
perPage: ${perPage},
filter: ${filter},
search: ${search}
    ''';
  }
}
