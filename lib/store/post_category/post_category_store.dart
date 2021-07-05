import 'package:cirilla/models/post/post_category.dart';
import 'package:cirilla/service/helpers/request_helper.dart';
import 'package:mobx/mobx.dart';

part 'post_category_store.g.dart';

class PostCategoryStore = _PostCategoryStore with _$PostCategoryStore;

abstract class _PostCategoryStore with Store {
  final String key;

  // Request helper instance
  RequestHelper _requestHelper;

  // store for handling errors
  // final ErrorStore errorStore = ErrorStore();

  // constructor:---------------------------------------------------------------
  _PostCategoryStore(this._requestHelper, {int perPage, String lang, this.key}) {
    if (perPage != null) _perPage = perPage;
    if (lang != null) _lang = lang;
    _reaction();
  }

  // store variables:-----------------------------------------------------------
  static ObservableFuture<List<PostCategory>> emptyPostCategoryResponse = ObservableFuture.value([]);

  @observable
  ObservableFuture<List<PostCategory>> fetchPostCategoriesFuture = emptyPostCategoryResponse;

  @observable
  ObservableList<PostCategory> _postCategories = ObservableList<PostCategory>.of([]);

  @observable
  bool success = false;

  @observable
  int _nextPage = 1;

  @observable
  int _perPage = 20;

  @observable
  String _lang = '';

  @observable
  bool _loading = true;

  @observable
  bool _canLoadMore = true;

  // computed:-------------------------------------------------------------------
  @computed
  bool get loading => fetchPostCategoriesFuture.status == FutureStatus.pending;

  @computed
  ObservableList<PostCategory> get postCategories => _postCategories;

  @computed
  bool get canLoadMore => _canLoadMore;

  @computed
  int get perPage => _perPage;

  @computed
  String get lang => _lang;

  // actions:-------------------------------------------------------------------
  @action
  Future<void> getPostCategories() async {
    final future = _requestHelper.getPostCategories(queryParameters: {
      "per_page": _perPage,
      'page': _nextPage,
      'lang': _lang,
    });
    fetchPostCategoriesFuture = ObservableFuture(future);
    return future.then((postCategories) {
      // Replace state in the first time or refresh
      if (_nextPage <= 1) {
        _postCategories = ObservableList<PostCategory>.of(postCategories);
      } else {
        // Add posts when load more page
        _postCategories.addAll(ObservableList<PostCategory>.of(postCategories));
      }

      // Check if can load more item
      if (postCategories.length >= 10) {
        _nextPage++;
      } else {
        _canLoadMore = false;
      }
    }).catchError((error) {
      print(error);
      // errorStore.errorMessage = DioErrorUtil.handleError(error);
    });
  }

  @action
  Future<void> refresh() {
    _canLoadMore = true;
    _nextPage = 1;
    return getPostCategories();
  }

  // disposers:-----------------------------------------------------------------
  List<ReactionDisposer> _disposers;

  void _reaction() {
    _disposers = [];
  }

  void dispose() {
    for (final d in _disposers) {
      d();
    }
  }
}
