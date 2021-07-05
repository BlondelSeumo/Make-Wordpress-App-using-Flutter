// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_comment_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PostCommentStore on _PostCommentStore, Store {
  Computed<bool> _$loadingComputed;

  @override
  bool get loading =>
      (_$loadingComputed ??= Computed<bool>(() => super.loading, name: '_PostCommentStore.loading')).value;
  Computed<ObservableList<PostComment>> _$postCommentsComputed;

  @override
  ObservableList<PostComment> get postComments => (_$postCommentsComputed ??=
          Computed<ObservableList<PostComment>>(() => super.postComments, name: '_PostCommentStore.postComments'))
      .value;
  Computed<bool> _$canLoadMoreComputed;

  @override
  bool get canLoadMore =>
      (_$canLoadMoreComputed ??= Computed<bool>(() => super.canLoadMore, name: '_PostCommentStore.canLoadMore')).value;
  Computed<int> _$perPageComputed;

  @override
  int get perPage =>
      (_$perPageComputed ??= Computed<int>(() => super.perPage, name: '_PostCommentStore.perPage')).value;
  Computed<String> _$langComputed;

  @override
  String get lang => (_$langComputed ??= Computed<String>(() => super.lang, name: '_PostCommentStore.lang')).value;

  final _$fetchPostCommentsFutureAtom = Atom(name: '_PostCommentStore.fetchPostCommentsFuture');

  @override
  ObservableFuture<List<PostComment>> get fetchPostCommentsFuture {
    _$fetchPostCommentsFutureAtom.reportRead();
    return super.fetchPostCommentsFuture;
  }

  @override
  set fetchPostCommentsFuture(ObservableFuture<List<PostComment>> value) {
    _$fetchPostCommentsFutureAtom.reportWrite(value, super.fetchPostCommentsFuture, () {
      super.fetchPostCommentsFuture = value;
    });
  }

  final _$_postCommentsAtom = Atom(name: '_PostCommentStore._postComments');

  @override
  ObservableList<PostComment> get _postComments {
    _$_postCommentsAtom.reportRead();
    return super._postComments;
  }

  @override
  set _postComments(ObservableList<PostComment> value) {
    _$_postCommentsAtom.reportWrite(value, super._postComments, () {
      super._postComments = value;
    });
  }

  final _$successAtom = Atom(name: '_PostCommentStore.success');

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

  final _$_postAtom = Atom(name: '_PostCommentStore._post');

  @override
  int get _post {
    _$_postAtom.reportRead();
    return super._post;
  }

  @override
  set _post(int value) {
    _$_postAtom.reportWrite(value, super._post, () {
      super._post = value;
    });
  }

  final _$_parentAtom = Atom(name: '_PostCommentStore._parent');

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

  final _$_nextPageAtom = Atom(name: '_PostCommentStore._nextPage');

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

  final _$_perPageAtom = Atom(name: '_PostCommentStore._perPage');

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

  final _$_langAtom = Atom(name: '_PostCommentStore._lang');

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

  final _$_orderAtom = Atom(name: '_PostCommentStore._order');

  @override
  String get _order {
    _$_orderAtom.reportRead();
    return super._order;
  }

  @override
  set _order(String value) {
    _$_orderAtom.reportWrite(value, super._order, () {
      super._order = value;
    });
  }

  final _$_orderbyAtom = Atom(name: '_PostCommentStore._orderby');

  @override
  String get _orderby {
    _$_orderbyAtom.reportRead();
    return super._orderby;
  }

  @override
  set _orderby(String value) {
    _$_orderbyAtom.reportWrite(value, super._orderby, () {
      super._orderby = value;
    });
  }

  final _$_loadingAtom = Atom(name: '_PostCommentStore._loading');

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

  final _$_canLoadMoreAtom = Atom(name: '_PostCommentStore._canLoadMore');

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

  final _$getPostCommentsAsyncAction = AsyncAction('_PostCommentStore.getPostComments');

  @override
  Future<void> getPostComments() {
    return _$getPostCommentsAsyncAction.run(() => super.getPostComments());
  }

  final _$_PostCommentStoreActionController = ActionController(name: '_PostCommentStore');

  @override
  Future<void> refresh() {
    final _$actionInfo = _$_PostCommentStoreActionController.startAction(name: '_PostCommentStore.refresh');
    try {
      return super.refresh();
    } finally {
      _$_PostCommentStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void onChange({int parent}) {
    final _$actionInfo = _$_PostCommentStoreActionController.startAction(name: '_PostCommentStore.onChange');
    try {
      return super.onChange(parent: parent);
    } finally {
      _$_PostCommentStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
fetchPostCommentsFuture: ${fetchPostCommentsFuture},
success: ${success},
loading: ${loading},
postComments: ${postComments},
canLoadMore: ${canLoadMore},
perPage: ${perPage},
lang: ${lang}
    ''';
  }
}
