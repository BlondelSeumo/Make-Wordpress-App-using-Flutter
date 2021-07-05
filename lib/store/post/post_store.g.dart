// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PostStore on _PostStore, Store {
  Computed<PostCategoryStore> _$postCategoryStoreComputed;

  @override
  PostCategoryStore get postCategoryStore => (_$postCategoryStoreComputed ??=
          Computed<PostCategoryStore>(() => super.postCategoryStore, name: '_PostStore.postCategoryStore'))
      .value;
  Computed<PostTagStore> _$postTagStoreComputed;

  @override
  PostTagStore get postTagStore =>
      (_$postTagStoreComputed ??= Computed<PostTagStore>(() => super.postTagStore, name: '_PostStore.postTagStore'))
          .value;
  Computed<bool> _$loadingComputed;

  @override
  bool get loading => (_$loadingComputed ??= Computed<bool>(() => super.loading, name: '_PostStore.loading')).value;
  Computed<int> _$nextPageComputed;

  @override
  int get nextPage => (_$nextPageComputed ??= Computed<int>(() => super.nextPage, name: '_PostStore.nextPage')).value;
  Computed<ObservableList<Post>> _$postsComputed;

  @override
  ObservableList<Post> get posts =>
      (_$postsComputed ??= Computed<ObservableList<Post>>(() => super.posts, name: '_PostStore.posts')).value;
  Computed<bool> _$canLoadMoreComputed;

  @override
  bool get canLoadMore =>
      (_$canLoadMoreComputed ??= Computed<bool>(() => super.canLoadMore, name: '_PostStore.canLoadMore')).value;
  Computed<Map<dynamic, dynamic>> _$sortComputed;

  @override
  Map<dynamic, dynamic> get sort =>
      (_$sortComputed ??= Computed<Map<dynamic, dynamic>>(() => super.sort, name: '_PostStore.sort')).value;
  Computed<int> _$perPageComputed;

  @override
  int get perPage => (_$perPageComputed ??= Computed<int>(() => super.perPage, name: '_PostStore.perPage')).value;
  Computed<ObservableList<PostTag>> _$tagSelectedComputed;

  @override
  ObservableList<PostTag> get tagSelected => (_$tagSelectedComputed ??=
          Computed<ObservableList<PostTag>>(() => super.tagSelected, name: '_PostStore.tagSelected'))
      .value;

  final _$fetchPostsFutureAtom = Atom(name: '_PostStore.fetchPostsFuture');

  @override
  ObservableFuture<List<Post>> get fetchPostsFuture {
    _$fetchPostsFutureAtom.reportRead();
    return super.fetchPostsFuture;
  }

  @override
  set fetchPostsFuture(ObservableFuture<List<Post>> value) {
    _$fetchPostsFutureAtom.reportWrite(value, super.fetchPostsFuture, () {
      super.fetchPostsFuture = value;
    });
  }

  final _$_postsAtom = Atom(name: '_PostStore._posts');

  @override
  ObservableList<Post> get _posts {
    _$_postsAtom.reportRead();
    return super._posts;
  }

  @override
  set _posts(ObservableList<Post> value) {
    _$_postsAtom.reportWrite(value, super._posts, () {
      super._posts = value;
    });
  }

  final _$successAtom = Atom(name: '_PostStore.success');

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

  final _$_perPageAtom = Atom(name: '_PostStore._perPage');

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

  final _$_langAtom = Atom(name: '_PostStore._lang');

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

  final _$_nextPageAtom = Atom(name: '_PostStore._nextPage');

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

  final _$_loadingAtom = Atom(name: '_PostStore._loading');

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

  final _$_canLoadMoreAtom = Atom(name: '_PostStore._canLoadMore');

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

  final _$_searchAtom = Atom(name: '_PostStore._search');

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

  final _$_sortAtom = Atom(name: '_PostStore._sort');

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

  final _$_categorySelectedAtom = Atom(name: '_PostStore._categorySelected');

  @override
  ObservableList<PostCategory> get _categorySelected {
    _$_categorySelectedAtom.reportRead();
    return super._categorySelected;
  }

  @override
  set _categorySelected(ObservableList<PostCategory> value) {
    _$_categorySelectedAtom.reportWrite(value, super._categorySelected, () {
      super._categorySelected = value;
    });
  }

  final _$_tagSelectedAtom = Atom(name: '_PostStore._tagSelected');

  @override
  ObservableList<PostTag> get _tagSelected {
    _$_tagSelectedAtom.reportRead();
    return super._tagSelected;
  }

  @override
  set _tagSelected(ObservableList<PostTag> value) {
    _$_tagSelectedAtom.reportWrite(value, super._tagSelected, () {
      super._tagSelected = value;
    });
  }

  final _$_includeAtom = Atom(name: '_PostStore._include');

  @override
  ObservableList<Post> get _include {
    _$_includeAtom.reportRead();
    return super._include;
  }

  @override
  set _include(ObservableList<Post> value) {
    _$_includeAtom.reportWrite(value, super._include, () {
      super._include = value;
    });
  }

  final _$getPostsAsyncAction = AsyncAction('_PostStore.getPosts');

  @override
  Future<List<Post>> getPosts() {
    return _$getPostsAsyncAction.run(() => super.getPosts());
  }

  final _$searchAsyncAction = AsyncAction('_PostStore.search');

  @override
  Future<List<PostSearch>> search({Map<String, dynamic> queryParameters, CancelToken cancelToken}) {
    return _$searchAsyncAction.run(() => super.search(queryParameters: queryParameters, cancelToken: cancelToken));
  }

  final _$_PostStoreActionController = ActionController(name: '_PostStore');

  @override
  Future<void> refresh() {
    final _$actionInfo = _$_PostStoreActionController.startAction(name: '_PostStore.refresh');
    try {
      return super.refresh();
    } finally {
      _$_PostStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void onChanged(
      {Map<dynamic, dynamic> sort,
      String search,
      List<PostCategory> categorySelected,
      List<PostTag> tagSelected,
      bool silent = false}) {
    final _$actionInfo = _$_PostStoreActionController.startAction(name: '_PostStore.onChanged');
    try {
      return super.onChanged(
          sort: sort, search: search, categorySelected: categorySelected, tagSelected: tagSelected, silent: silent);
    } finally {
      _$_PostStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
fetchPostsFuture: ${fetchPostsFuture},
success: ${success},
postCategoryStore: ${postCategoryStore},
postTagStore: ${postTagStore},
loading: ${loading},
nextPage: ${nextPage},
posts: ${posts},
canLoadMore: ${canLoadMore},
sort: ${sort},
perPage: ${perPage},
tagSelected: ${tagSelected}
    ''';
  }
}
