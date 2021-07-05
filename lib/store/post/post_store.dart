import 'package:cirilla/models/models.dart';
import 'package:cirilla/service/helpers/request_helper.dart';
import 'package:cirilla/store/store.dart';
import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';

part 'post_store.g.dart';

class PostStore = _PostStore with _$PostStore;

abstract class _PostStore with Store {
  final String key;

  // Request helper instance
  RequestHelper _requestHelper;

  PostCategoryStore _postCategoryStore;

  PostTagStore _postTagStore;

  // constructor:---------------------------------------------------------------
  _PostStore(
    this._requestHelper, {
    this.key,
    String lang,
    int perPage,
    String search,
    List<Post> include,
    List<PostCategory> categories,
    List<PostTag> tags,
  }) {
    this._postCategoryStore = PostCategoryStore(this._requestHelper, lang: lang);
    this._postTagStore = PostTagStore(this._requestHelper, lang: lang);

    if (lang != null) _lang = lang;
    if (perPage != null) _perPage = perPage;
    if (search != null) _search = search;
    if (include != null) _include = ObservableList<Post>.of(include);
    if (categories != null) _categorySelected = ObservableList<PostCategory>.of(categories);
    if (tags != null) _tagSelected = ObservableList<PostTag>.of(tags);

    _reaction();
  }

  // store variables:-----------------------------------------------------------
  static ObservableFuture<List<Post>> emptyPostResponse = ObservableFuture.value([]);

  @observable
  ObservableFuture<List<Post>> fetchPostsFuture = emptyPostResponse;

  @observable
  ObservableList<Post> _posts = ObservableList<Post>.of([]);

  @observable
  bool success = false;

  @observable
  int _perPage = 10;

  @observable
  String _lang;

  @observable
  int _nextPage = 1;

  @observable
  bool _loading = true;

  @observable
  bool _canLoadMore = true;

  @observable
  String _search = '';

  @observable
  Map _sort = {
    'key': 'latest',
    'query': {
      'order': 'desc',
      'orderby': 'date',
    }
  };

  @observable
  ObservableList<PostCategory> _categorySelected = ObservableList<PostCategory>.of([]);

  @observable
  ObservableList<PostTag> _tagSelected = ObservableList<PostTag>.of([]);

  @observable
  ObservableList<Post> _include = ObservableList<Post>.of([]);

  // computed:-------------------------------------------------------------------
  @computed
  PostCategoryStore get postCategoryStore => _postCategoryStore;

  @computed
  PostTagStore get postTagStore => _postTagStore;

  @computed
  bool get loading => fetchPostsFuture.status == FutureStatus.pending;

  @computed
  int get nextPage => _nextPage;

  @computed
  ObservableList<Post> get posts => _posts;

  @computed
  bool get canLoadMore => _canLoadMore;

  @computed
  Map get sort => _sort;

  @computed
  int get perPage => _perPage;

  ObservableList<PostCategory> get categorySelected => _categorySelected;

  @computed
  ObservableList<PostTag> get tagSelected => _tagSelected;

  // actions:-------------------------------------------------------------------
  @action
  Future<List<Post>> getPosts() async {
    final qs = {
      "page": _nextPage,
      "per_page": _perPage,
      "search": _search,
      "order": _sort['query']['order'],
      "orderby": _sort['query']['orderby'],
      "categories": _categorySelected.map((e) => e.id).join(','),
      "tags": _tagSelected.map((e) => e.id).toList().join(','),
      "include": _include.map((e) => e.id).toList().join(','),
      "lang": _lang ?? ''
    };

    qs.removeWhere((key, value) => key == null || value == null || value == "");

    final future = _requestHelper.getPosts(queryParameters: qs);

    fetchPostsFuture = ObservableFuture(future);

    return future.then((posts) {
      // Replace state in the first time or refresh
      if (_nextPage <= 1) {
        _posts = ObservableList<Post>.of(posts);
      } else {
        // Add posts when load more page
        _posts.addAll(ObservableList<Post>.of(posts));
      }

      // Check if can load more item
      if (posts.length >= 10) {
        _nextPage++;
      } else {
        _canLoadMore = false;
      }
      return _posts;
    }).catchError((error) {
      print(error);
    });
  }

  @action
  Future<void> refresh() {
    _canLoadMore = true;
    _nextPage = 1;
    _posts.clear();
    return getPosts();
  }

  @action
  Future<List<PostSearch>> search({Map<String, dynamic> queryParameters, CancelToken cancelToken}) async {
    List<PostSearch> data = await _requestHelper.searchPost(
      queryParameters: queryParameters,
      cancelToken: cancelToken,
    );
    return data;
  }

  @action
  void onChanged(
      {Map sort, String search, List<PostCategory> categorySelected, List<PostTag> tagSelected, bool silent = false}) {
    if (sort != null) _sort = sort;
    if (search != null) _search = search;
    if (categorySelected != null) _categorySelected = ObservableList<PostCategory>.of(categorySelected);
    if (tagSelected != null) _tagSelected = ObservableList<PostTag>.of(tagSelected);

    if (!silent) refresh();
  }

  // disposers:-----------------------------------------------------------------
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
