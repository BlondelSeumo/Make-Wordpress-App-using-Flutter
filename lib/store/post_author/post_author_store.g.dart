// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_author_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PostAuthorStore on _PostAuthorStore, Store {
  Computed<bool> _$loadingComputed;

  @override
  bool get loading =>
      (_$loadingComputed ??= Computed<bool>(() => super.loading, name: '_PostAuthorStore.loading')).value;
  Computed<ObservableList<PostAuthor>> _$postAuthorsComputed;

  @override
  ObservableList<PostAuthor> get postAuthors => (_$postAuthorsComputed ??=
          Computed<ObservableList<PostAuthor>>(() => super.postAuthors, name: '_PostAuthorStore.postAuthors'))
      .value;
  Computed<bool> _$canLoadMoreComputed;

  @override
  bool get canLoadMore =>
      (_$canLoadMoreComputed ??= Computed<bool>(() => super.canLoadMore, name: '_PostAuthorStore.canLoadMore')).value;
  Computed<int> _$perPageComputed;

  @override
  int get perPage => (_$perPageComputed ??= Computed<int>(() => super.perPage, name: '_PostAuthorStore.perPage')).value;

  final _$fetchPostAuthorsFutureAtom = Atom(name: '_PostAuthorStore.fetchPostAuthorsFuture');

  @override
  ObservableFuture<List<PostAuthor>> get fetchPostAuthorsFuture {
    _$fetchPostAuthorsFutureAtom.reportRead();
    return super.fetchPostAuthorsFuture;
  }

  @override
  set fetchPostAuthorsFuture(ObservableFuture<List<PostAuthor>> value) {
    _$fetchPostAuthorsFutureAtom.reportWrite(value, super.fetchPostAuthorsFuture, () {
      super.fetchPostAuthorsFuture = value;
    });
  }

  final _$_postAuthorsAtom = Atom(name: '_PostAuthorStore._postAuthors');

  @override
  ObservableList<PostAuthor> get _postAuthors {
    _$_postAuthorsAtom.reportRead();
    return super._postAuthors;
  }

  @override
  set _postAuthors(ObservableList<PostAuthor> value) {
    _$_postAuthorsAtom.reportWrite(value, super._postAuthors, () {
      super._postAuthors = value;
    });
  }

  final _$successAtom = Atom(name: '_PostAuthorStore.success');

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

  final _$_nextPageAtom = Atom(name: '_PostAuthorStore._nextPage');

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

  final _$_perPageAtom = Atom(name: '_PostAuthorStore._perPage');

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

  final _$_loadingAtom = Atom(name: '_PostAuthorStore._loading');

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

  final _$_canLoadMoreAtom = Atom(name: '_PostAuthorStore._canLoadMore');

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

  final _$getPostAuthorsAsyncAction = AsyncAction('_PostAuthorStore.getPostAuthors');

  @override
  Future<void> getPostAuthors() {
    return _$getPostAuthorsAsyncAction.run(() => super.getPostAuthors());
  }

  final _$_PostAuthorStoreActionController = ActionController(name: '_PostAuthorStore');

  @override
  Future<void> refresh() {
    final _$actionInfo = _$_PostAuthorStoreActionController.startAction(name: '_PostAuthorStore.refresh');
    try {
      return super.refresh();
    } finally {
      _$_PostAuthorStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
fetchPostAuthorsFuture: ${fetchPostAuthorsFuture},
success: ${success},
loading: ${loading},
postAuthors: ${postAuthors},
canLoadMore: ${canLoadMore},
perPage: ${perPage}
    ''';
  }
}
