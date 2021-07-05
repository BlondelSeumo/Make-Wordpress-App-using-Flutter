// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_category_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PostCategoryStore on _PostCategoryStore, Store {
  Computed<bool> _$loadingComputed;

  @override
  bool get loading =>
      (_$loadingComputed ??= Computed<bool>(() => super.loading, name: '_PostCategoryStore.loading')).value;
  Computed<ObservableList<PostCategory>> _$postCategoriesComputed;

  @override
  ObservableList<PostCategory> get postCategories => (_$postCategoriesComputed ??=
          Computed<ObservableList<PostCategory>>(() => super.postCategories, name: '_PostCategoryStore.postCategories'))
      .value;
  Computed<bool> _$canLoadMoreComputed;

  @override
  bool get canLoadMore =>
      (_$canLoadMoreComputed ??= Computed<bool>(() => super.canLoadMore, name: '_PostCategoryStore.canLoadMore')).value;
  Computed<int> _$perPageComputed;

  @override
  int get perPage =>
      (_$perPageComputed ??= Computed<int>(() => super.perPage, name: '_PostCategoryStore.perPage')).value;
  Computed<String> _$langComputed;

  @override
  String get lang => (_$langComputed ??= Computed<String>(() => super.lang, name: '_PostCategoryStore.lang')).value;

  final _$fetchPostCategoriesFutureAtom = Atom(name: '_PostCategoryStore.fetchPostCategoriesFuture');

  @override
  ObservableFuture<List<PostCategory>> get fetchPostCategoriesFuture {
    _$fetchPostCategoriesFutureAtom.reportRead();
    return super.fetchPostCategoriesFuture;
  }

  @override
  set fetchPostCategoriesFuture(ObservableFuture<List<PostCategory>> value) {
    _$fetchPostCategoriesFutureAtom.reportWrite(value, super.fetchPostCategoriesFuture, () {
      super.fetchPostCategoriesFuture = value;
    });
  }

  final _$_postCategoriesAtom = Atom(name: '_PostCategoryStore._postCategories');

  @override
  ObservableList<PostCategory> get _postCategories {
    _$_postCategoriesAtom.reportRead();
    return super._postCategories;
  }

  @override
  set _postCategories(ObservableList<PostCategory> value) {
    _$_postCategoriesAtom.reportWrite(value, super._postCategories, () {
      super._postCategories = value;
    });
  }

  final _$successAtom = Atom(name: '_PostCategoryStore.success');

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

  final _$_nextPageAtom = Atom(name: '_PostCategoryStore._nextPage');

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

  final _$_perPageAtom = Atom(name: '_PostCategoryStore._perPage');

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

  final _$_langAtom = Atom(name: '_PostCategoryStore._lang');

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

  final _$_loadingAtom = Atom(name: '_PostCategoryStore._loading');

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

  final _$_canLoadMoreAtom = Atom(name: '_PostCategoryStore._canLoadMore');

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

  final _$getPostCategoriesAsyncAction = AsyncAction('_PostCategoryStore.getPostCategories');

  @override
  Future<void> getPostCategories() {
    return _$getPostCategoriesAsyncAction.run(() => super.getPostCategories());
  }

  final _$_PostCategoryStoreActionController = ActionController(name: '_PostCategoryStore');

  @override
  Future<void> refresh() {
    final _$actionInfo = _$_PostCategoryStoreActionController.startAction(name: '_PostCategoryStore.refresh');
    try {
      return super.refresh();
    } finally {
      _$_PostCategoryStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
fetchPostCategoriesFuture: ${fetchPostCategoriesFuture},
success: ${success},
loading: ${loading},
postCategories: ${postCategories},
canLoadMore: ${canLoadMore},
perPage: ${perPage},
lang: ${lang}
    ''';
  }
}
