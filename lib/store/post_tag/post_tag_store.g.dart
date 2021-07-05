// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_tag_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PostTagStore on _PostTagStore, Store {
  Computed<bool> _$loadingComputed;

  @override
  bool get loading => (_$loadingComputed ??= Computed<bool>(() => super.loading, name: '_PostTagStore.loading')).value;
  Computed<ObservableList<PostTag>> _$postTagsComputed;

  @override
  ObservableList<PostTag> get postTags =>
      (_$postTagsComputed ??= Computed<ObservableList<PostTag>>(() => super.postTags, name: '_PostTagStore.postTags'))
          .value;
  Computed<bool> _$canLoadMoreComputed;

  @override
  bool get canLoadMore =>
      (_$canLoadMoreComputed ??= Computed<bool>(() => super.canLoadMore, name: '_PostTagStore.canLoadMore')).value;
  Computed<int> _$perPageComputed;

  @override
  int get perPage => (_$perPageComputed ??= Computed<int>(() => super.perPage, name: '_PostTagStore.perPage')).value;
  Computed<String> _$langComputed;

  @override
  String get lang => (_$langComputed ??= Computed<String>(() => super.lang, name: '_PostTagStore.lang')).value;

  final _$fetchPostTagsFutureAtom = Atom(name: '_PostTagStore.fetchPostTagsFuture');

  @override
  ObservableFuture<List<PostTag>> get fetchPostTagsFuture {
    _$fetchPostTagsFutureAtom.reportRead();
    return super.fetchPostTagsFuture;
  }

  @override
  set fetchPostTagsFuture(ObservableFuture<List<PostTag>> value) {
    _$fetchPostTagsFutureAtom.reportWrite(value, super.fetchPostTagsFuture, () {
      super.fetchPostTagsFuture = value;
    });
  }

  final _$_postTagsAtom = Atom(name: '_PostTagStore._postTags');

  @override
  ObservableList<PostTag> get _postTags {
    _$_postTagsAtom.reportRead();
    return super._postTags;
  }

  @override
  set _postTags(ObservableList<PostTag> value) {
    _$_postTagsAtom.reportWrite(value, super._postTags, () {
      super._postTags = value;
    });
  }

  final _$successAtom = Atom(name: '_PostTagStore.success');

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

  final _$_nextPageAtom = Atom(name: '_PostTagStore._nextPage');

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

  final _$_perPageAtom = Atom(name: '_PostTagStore._perPage');

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

  final _$_langAtom = Atom(name: '_PostTagStore._lang');

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

  final _$_loadingAtom = Atom(name: '_PostTagStore._loading');

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

  final _$_canLoadMoreAtom = Atom(name: '_PostTagStore._canLoadMore');

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

  final _$getPostTagsAsyncAction = AsyncAction('_PostTagStore.getPostTags');

  @override
  Future<void> getPostTags() {
    return _$getPostTagsAsyncAction.run(() => super.getPostTags());
  }

  final _$_PostTagStoreActionController = ActionController(name: '_PostTagStore');

  @override
  Future<void> refresh() {
    final _$actionInfo = _$_PostTagStoreActionController.startAction(name: '_PostTagStore.refresh');
    try {
      return super.refresh();
    } finally {
      _$_PostTagStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
fetchPostTagsFuture: ${fetchPostTagsFuture},
success: ${success},
loading: ${loading},
postTags: ${postTags},
canLoadMore: ${canLoadMore},
perPage: ${perPage},
lang: ${lang}
    ''';
  }
}
