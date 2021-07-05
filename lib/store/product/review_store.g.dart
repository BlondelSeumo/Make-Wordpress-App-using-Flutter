// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ProductReviewStore on _ProductReviewStore, Store {
  Computed<bool> _$loadingComputed;

  @override
  bool get loading =>
      (_$loadingComputed ??= Computed<bool>(() => super.loading, name: '_ProductReviewStore.loading')).value;
  Computed<int> _$productIdComputed;

  @override
  int get productId =>
      (_$productIdComputed ??= Computed<int>(() => super.productId, name: '_ProductReviewStore.productId')).value;
  Computed<int> _$nextPageComputed;

  @override
  int get nextPage =>
      (_$nextPageComputed ??= Computed<int>(() => super.nextPage, name: '_ProductReviewStore.nextPage')).value;
  Computed<ObservableList<ProductReview>> _$reviewsComputed;

  @override
  ObservableList<ProductReview> get reviews => (_$reviewsComputed ??=
          Computed<ObservableList<ProductReview>>(() => super.reviews, name: '_ProductReviewStore.reviews'))
      .value;
  Computed<bool> _$canLoadMoreComputed;

  @override
  bool get canLoadMore =>
      (_$canLoadMoreComputed ??= Computed<bool>(() => super.canLoadMore, name: '_ProductReviewStore.canLoadMore'))
          .value;
  Computed<Map<dynamic, dynamic>> _$sortComputed;

  @override
  Map<dynamic, dynamic> get sort =>
      (_$sortComputed ??= Computed<Map<dynamic, dynamic>>(() => super.sort, name: '_ProductReviewStore.sort')).value;
  Computed<int> _$perPageComputed;

  @override
  int get perPage =>
      (_$perPageComputed ??= Computed<int>(() => super.perPage, name: '_ProductReviewStore.perPage')).value;
  Computed<RatingCount> _$ratingCountComputed;

  @override
  RatingCount get ratingCount => (_$ratingCountComputed ??=
          Computed<RatingCount>(() => super.ratingCount, name: '_ProductReviewStore.ratingCount'))
      .value;

  final _$fetchReviewsFutureAtom = Atom(name: '_ProductReviewStore.fetchReviewsFuture');

  @override
  ObservableFuture<List<ProductReview>> get fetchReviewsFuture {
    _$fetchReviewsFutureAtom.reportRead();
    return super.fetchReviewsFuture;
  }

  @override
  set fetchReviewsFuture(ObservableFuture<List<ProductReview>> value) {
    _$fetchReviewsFutureAtom.reportWrite(value, super.fetchReviewsFuture, () {
      super.fetchReviewsFuture = value;
    });
  }

  final _$_reviewsAtom = Atom(name: '_ProductReviewStore._reviews');

  @override
  ObservableList<ProductReview> get _reviews {
    _$_reviewsAtom.reportRead();
    return super._reviews;
  }

  @override
  set _reviews(ObservableList<ProductReview> value) {
    _$_reviewsAtom.reportWrite(value, super._reviews, () {
      super._reviews = value;
    });
  }

  final _$successAtom = Atom(name: '_ProductReviewStore.success');

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

  final _$_perPageAtom = Atom(name: '_ProductReviewStore._perPage');

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

  final _$_productIdAtom = Atom(name: '_ProductReviewStore._productId');

  @override
  int get _productId {
    _$_productIdAtom.reportRead();
    return super._productId;
  }

  @override
  set _productId(int value) {
    _$_productIdAtom.reportWrite(value, super._productId, () {
      super._productId = value;
    });
  }

  final _$_langAtom = Atom(name: '_ProductReviewStore._lang');

  @override
  String get _lang {
    _$_langAtom.reportRead();
    return super._lang;
  }

  @override
  set _lang(String value) {
    _$_langAtom.reportWrite(value, super._lang, () {
      super._lang = value;
    });
  }

  final _$_nextPageAtom = Atom(name: '_ProductReviewStore._nextPage');

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

  final _$_loadingAtom = Atom(name: '_ProductReviewStore._loading');

  @override
  bool get _loading {
    _$_loadingAtom.reportRead();
    return super._loading;
  }

  @override
  set _loading(bool value) {
    _$_loadingAtom.reportWrite(value, super._loading, () {
      super._loading = value;
    });
  }

  final _$_canLoadMoreAtom = Atom(name: '_ProductReviewStore._canLoadMore');

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

  final _$_sortAtom = Atom(name: '_ProductReviewStore._sort');

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

  final _$_ratingCountAtom = Atom(name: '_ProductReviewStore._ratingCount');

  @override
  RatingCount get _ratingCount {
    _$_ratingCountAtom.reportRead();
    return super._ratingCount;
  }

  @override
  set _ratingCount(RatingCount value) {
    _$_ratingCountAtom.reportWrite(value, super._ratingCount, () {
      super._ratingCount = value;
    });
  }

  final _$_includeAtom = Atom(name: '_ProductReviewStore._include');

  @override
  ObservableList<ProductReview> get _include {
    _$_includeAtom.reportRead();
    return super._include;
  }

  @override
  set _include(ObservableList<ProductReview> value) {
    _$_includeAtom.reportWrite(value, super._include, () {
      super._include = value;
    });
  }

  final _$getReviewsAsyncAction = AsyncAction('_ProductReviewStore.getReviews');

  @override
  Future<List<ProductReview>> getReviews() {
    return _$getReviewsAsyncAction.run(() => super.getReviews());
  }

  final _$_ProductReviewStoreActionController = ActionController(name: '_ProductReviewStore');

  @override
  Future<void> refresh() {
    final _$actionInfo = _$_ProductReviewStoreActionController.startAction(name: '_ProductReviewStore.refresh');
    try {
      return super.refresh();
    } finally {
      _$_ProductReviewStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void onChanged({Map<dynamic, dynamic> sort, String search, bool silent = false}) {
    final _$actionInfo = _$_ProductReviewStoreActionController.startAction(name: '_ProductReviewStore.onChanged');
    try {
      return super.onChanged(sort: sort, search: search, silent: silent);
    } finally {
      _$_ProductReviewStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
fetchReviewsFuture: ${fetchReviewsFuture},
success: ${success},
loading: ${loading},
productId: ${productId},
nextPage: ${nextPage},
reviews: ${reviews},
canLoadMore: ${canLoadMore},
sort: ${sort},
perPage: ${perPage},
ratingCount: ${ratingCount}
    ''';
  }
}
