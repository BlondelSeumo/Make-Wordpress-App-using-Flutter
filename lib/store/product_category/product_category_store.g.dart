// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_category_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ProductCategoryStore on _ProductCategoryStore, Store {
  Computed<RequestHelper> _$requestHelperComputed;

  @override
  RequestHelper get requestHelper => (_$requestHelperComputed ??=
          Computed<RequestHelper>(() => super.requestHelper, name: '_ProductCategoryStore.requestHelper'))
      .value;
  Computed<bool> _$loadingComputed;

  @override
  bool get loading =>
      (_$loadingComputed ??= Computed<bool>(() => super.loading, name: '_ProductCategoryStore.loading')).value;
  Computed<ObservableList<ProductCategory>> _$categoriesComputed;

  @override
  ObservableList<ProductCategory> get categories => (_$categoriesComputed ??=
          Computed<ObservableList<ProductCategory>>(() => super.categories, name: '_ProductCategoryStore.categories'))
      .value;
  Computed<bool> _$canLoadMoreComputed;

  @override
  bool get canLoadMore =>
      (_$canLoadMoreComputed ??= Computed<bool>(() => super.canLoadMore, name: '_ProductCategoryStore.canLoadMore'))
          .value;
  Computed<Map<dynamic, dynamic>> _$sortComputed;

  @override
  Map<dynamic, dynamic> get sort =>
      (_$sortComputed ??= Computed<Map<dynamic, dynamic>>(() => super.sort, name: '_ProductCategoryStore.sort')).value;
  Computed<int> _$parentComputed;

  @override
  int get parent =>
      (_$parentComputed ??= Computed<int>(() => super.parent, name: '_ProductCategoryStore.parent')).value;
  Computed<int> _$perPageComputed;

  @override
  int get perPage =>
      (_$perPageComputed ??= Computed<int>(() => super.perPage, name: '_ProductCategoryStore.perPage')).value;

  final _$fetchCategoriesFutureAtom = Atom(name: '_ProductCategoryStore.fetchCategoriesFuture');

  @override
  ObservableFuture<List<ProductCategory>> get fetchCategoriesFuture {
    _$fetchCategoriesFutureAtom.reportRead();
    return super.fetchCategoriesFuture;
  }

  @override
  set fetchCategoriesFuture(ObservableFuture<List<ProductCategory>> value) {
    _$fetchCategoriesFutureAtom.reportWrite(value, super.fetchCategoriesFuture, () {
      super.fetchCategoriesFuture = value;
    });
  }

  final _$_categoriesAtom = Atom(name: '_ProductCategoryStore._categories');

  @override
  ObservableList<ProductCategory> get _categories {
    _$_categoriesAtom.reportRead();
    return super._categories;
  }

  @override
  set _categories(ObservableList<ProductCategory> value) {
    _$_categoriesAtom.reportWrite(value, super._categories, () {
      super._categories = value;
    });
  }

  final _$successAtom = Atom(name: '_ProductCategoryStore.success');

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

  final _$_canLoadMoreAtom = Atom(name: '_ProductCategoryStore._canLoadMore');

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

  final _$_nextPageAtom = Atom(name: '_ProductCategoryStore._nextPage');

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

  final _$_perPageAtom = Atom(name: '_ProductCategoryStore._perPage');

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

  final _$_parentAtom = Atom(name: '_ProductCategoryStore._parent');

  @override
  int get _parent {
    _$_parentAtom.reportRead();
    return super._parent;
  }

  @override
  set _parent(int value) {
    _$_parentAtom.reportWrite(value, super._parent, () {
      super._parent = value;
    });
  }

  final _$_hideEmptyAtom = Atom(name: '_ProductCategoryStore._hideEmpty');

  @override
  bool get _hideEmpty {
    _$_hideEmptyAtom.reportRead();
    return super._hideEmpty;
  }

  @override
  set _hideEmpty(bool value) {
    _$_hideEmptyAtom.reportWrite(value, super._hideEmpty, () {
      super._hideEmpty = value;
    });
  }

  final _$_searchAtom = Atom(name: '_ProductCategoryStore._search');

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

  final _$_sortAtom = Atom(name: '_ProductCategoryStore._sort');

  @override
  Map<dynamic, dynamic> get _sort {
    _$_sortAtom.reportRead();
    return super._sort;
  }

  @override
  set _sort(Map<dynamic, dynamic> value) {
    _$_sortAtom.reportWrite(value, super._sort, () {
      super._sort = value;
    });
  }

  final _$getCategoriesAsyncAction = AsyncAction('_ProductCategoryStore.getCategories');

  @override
  Future<void> getCategories() {
    return _$getCategoriesAsyncAction.run(() => super.getCategories());
  }

  final _$_ProductCategoryStoreActionController = ActionController(name: '_ProductCategoryStore');

  @override
  Future<void> refresh() {
    final _$actionInfo = _$_ProductCategoryStoreActionController.startAction(name: '_ProductCategoryStore.refresh');
    try {
      return super.refresh();
    } finally {
      _$_ProductCategoryStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void onChanged({Map<dynamic, dynamic> sort, String search, int parent, int perPage}) {
    final _$actionInfo = _$_ProductCategoryStoreActionController.startAction(name: '_ProductCategoryStore.onChanged');
    try {
      return super.onChanged(sort: sort, search: search, parent: parent, perPage: perPage);
    } finally {
      _$_ProductCategoryStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
fetchCategoriesFuture: ${fetchCategoriesFuture},
success: ${success},
requestHelper: ${requestHelper},
loading: ${loading},
categories: ${categories},
canLoadMore: ${canLoadMore},
sort: ${sort},
parent: ${parent},
perPage: ${perPage}
    ''';
  }
}
