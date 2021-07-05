import 'package:cirilla/models/post_tag/post_tag.dart';
import 'package:cirilla/service/helpers/request_helper.dart';
import 'package:mobx/mobx.dart';

part 'post_tag_store.g.dart';

class PostTagStore = _PostTagStore with _$PostTagStore;

abstract class _PostTagStore with Store {
  final String key;

  // Request helper instance
  RequestHelper _requestHelper;

  // store for handling errors
  // final ErrorStore errorStore = ErrorStore();

  // constructor:---------------------------------------------------------------
  _PostTagStore(this._requestHelper, {int perPage, String lang, this.key}) {
    if (perPage != null) _perPage = perPage;
    if (lang != null) _lang = lang;
    _reaction();
  }

  // store variables:-----------------------------------------------------------
  static ObservableFuture<List<PostTag>> emptyPostTagResponse = ObservableFuture.value([]);

  @observable
  ObservableFuture<List<PostTag>> fetchPostTagsFuture = emptyPostTagResponse;

  @observable
  ObservableList<PostTag> _postTags = ObservableList<PostTag>.of([]);

  @observable
  bool success = false;

  @observable
  int _nextPage = 1;

  @observable
  int _perPage = 10;

  @observable
  String _lang = '';

  @observable
  bool _loading = true;

  @observable
  bool _canLoadMore = true;

  // computed:-------------------------------------------------------------------
  @computed
  bool get loading => fetchPostTagsFuture.status == FutureStatus.pending;

  @computed
  ObservableList<PostTag> get postTags => _postTags;

  @computed
  bool get canLoadMore => _canLoadMore;

  @computed
  int get perPage => _perPage;

  @computed
  String get lang => _lang;

  // actions:-------------------------------------------------------------------
  @action
  Future<void> getPostTags() async {
    final future = _requestHelper.getPostTags(queryParameters: {
      "per_page": _perPage,
      'page': _nextPage,
      'lang': _lang,
    });
    fetchPostTagsFuture = ObservableFuture(future);
    return future.then((data) {
      // Replace state in the first time or refresh
      if (_nextPage <= 1) {
        _postTags = ObservableList<PostTag>.of(data);
      } else {
        // Add posts when load more page
        _postTags.addAll(ObservableList<PostTag>.of(data));
      }

      // Check if can load more item
      if (data.length >= 10) {
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
    return getPostTags();
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
