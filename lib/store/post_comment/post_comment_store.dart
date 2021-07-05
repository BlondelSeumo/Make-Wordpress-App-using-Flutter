import 'package:cirilla/models/post/post_comment.dart';
import 'package:cirilla/service/helpers/request_helper.dart';
import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';

part 'post_comment_store.g.dart';

class PostCommentStore = _PostCommentStore with _$PostCommentStore;

abstract class _PostCommentStore with Store {
  final String key;

  // Request helper instance
  RequestHelper _requestHelper;

  // store for handling errors
  // final ErrorStore errorStore = ErrorStore();

  // constructor:---------------------------------------------------------------
  _PostCommentStore(this._requestHelper, {this.key, int perPage, String lang, int post, int parent, String order}) {
    if (perPage != null) _perPage = perPage;
    if (lang != null) _lang = lang;
    if (post != null) _post = post;
    if (parent != null) _parent = parent;
    if (order != null) _order = order;
    _reaction();
  }

  // store variables:-----------------------------------------------------------
  static ObservableFuture<List<PostComment>> emptyPostCommentResponse = ObservableFuture.value([]);

  @observable
  ObservableFuture<List<PostComment>> fetchPostCommentsFuture = emptyPostCommentResponse;

  @observable
  ObservableList<PostComment> _postComments = ObservableList<PostComment>.of([]);

  @observable
  bool success = false;

  @observable
  int _post;

  @observable
  int _parent = 0;

  @observable
  int _nextPage = 1;

  @observable
  int _perPage = 10;

  @observable
  String _lang = '';

  @observable
  String _order = 'asc';

  @observable
  String _orderby = 'date';

  @observable
  bool _loading = true;

  @observable
  bool _canLoadMore = true;

  // computed:-------------------------------------------------------------------
  @computed
  bool get loading => fetchPostCommentsFuture.status == FutureStatus.pending;

  @computed
  ObservableList<PostComment> get postComments => _postComments;

  @computed
  bool get canLoadMore => _canLoadMore;

  @computed
  int get perPage => _perPage;

  @computed
  String get lang => _lang;

  // actions:-------------------------------------------------------------------
  @action
  Future<void> getPostComments() async {
    final future = _requestHelper.getPostComments(queryParameters: {
      "post": _post,
      "parent": _parent,
      "per_page": _perPage,
      "page": _nextPage,
      "lang": _lang,
      "order": "asc",
      "orderby": "date",
    });
    fetchPostCommentsFuture = ObservableFuture(future);
    return future.then((data) {
      // Replace state in the first time or refresh
      if (_nextPage <= 1) {
        _postComments = ObservableList<PostComment>.of(data);
      } else {
        // Add posts when load more page
        _postComments.addAll(ObservableList<PostComment>.of(data));
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

  /// Write a comment
  Future<PostComment> writeComment({String content, int parent}) async {
    Map<String, dynamic> data = {
      'content': content,
      'post': _post,
      'parent': parent != null ? parent : _parent,
    };

    try {
      PostComment comment = await _requestHelper.writeComments(queryParameters: data);
      return comment;
    } on DioError catch (e) {
      throw e;
    }
  }

  @action
  Future<void> refresh() {
    _canLoadMore = true;
    _nextPage = 1;
    return getPostComments();
  }

  @action
  void onChange({int parent}) {
    if (parent != null) _parent = parent;
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
