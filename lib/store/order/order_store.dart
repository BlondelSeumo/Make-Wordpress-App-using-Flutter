import 'package:cirilla/models/order/order.dart';
import 'package:cirilla/models/order_note/order_node.dart';
import 'package:cirilla/service/helpers/request_helper.dart';
import 'package:mobx/mobx.dart';

part 'order_store.g.dart';

class OrderStore = _OrderStore with _$OrderStore;

abstract class _OrderStore with Store {
  RequestHelper _requestHelper;

  @observable
  bool _loading = true;

  // store variables:-----------------------------------------------------------
  static ObservableFuture<List<OrderData>> emptyOrderResponse = ObservableFuture.value([]);

  static ObservableFuture<List<OrderNode>> emptyOrderNodeResponse = ObservableFuture.value([]);

  @observable
  ObservableFuture<List<OrderData>> fetchOrdersFuture = emptyOrderResponse;

  @observable
  ObservableFuture<List<OrderNode>> fetchOrderNodeFuture = emptyOrderNodeResponse;

  @observable
  ObservableList<OrderData> _orders = ObservableList<OrderData>.of([]);

  @observable
  ObservableList<OrderNode> _orderNode = ObservableList<OrderNode>.of([]);

  @observable
  int _nextPage = 1;

  @observable
  int _perPage = 10;

  @observable
  bool _canLoadMore = true;

  @computed
  int get perPage => _perPage;

  @computed
  bool get canLoadMore => _canLoadMore;

  @computed
  bool get loading => fetchOrdersFuture.status == FutureStatus.pending;

  @computed
  bool get loadingNode => fetchOrderNodeFuture.status == FutureStatus.pending;

  @computed
  ObservableList<OrderData> get orders => _orders;

  @computed
  ObservableList<OrderNode> get orderNode => _orderNode;

  @observable
  String _search = '';
  @action
  Future<void> getOrders({String userId}) async {
    final qs = {
      "customer": userId,
      "page": _nextPage,
      "per_page": _perPage,
      "search": _search,
    };

    qs.removeWhere((key, value) => key == null || value == null || value == "");

    final future = _requestHelper.getOrders(
      queryParameters: qs,
    );

    fetchOrdersFuture = ObservableFuture(future);
    return future.then((orders) {
      // Replace state in the first time or refresh
      if (_nextPage <= 1) {
        _orders = ObservableList<OrderData>.of(orders);
      } else {
        // Add posts when load more page
        _orders.addAll(ObservableList<OrderData>.of(orders));
      }
      // Check if can load more item
      if (orders.length >= 10) {
        _nextPage++;
      } else {
        _canLoadMore = false;
      }
    }).catchError((error) {
      throw error;
    });
  }

  @action
  Future<void> refresh() {
    _canLoadMore = true;
    _nextPage = 1;
    return getOrders();
  }

  Future<void> getOrderNodes({String userId, int orderId}) async {
    final type = {
      "type": "customer",
    };

    final futureNode = _requestHelper.getOrderNodes(queryParameters: type, orderId: orderId);

    fetchOrderNodeFuture = ObservableFuture(futureNode);
    return futureNode.then((orderNode) {
      _orderNode = ObservableList<OrderNode>.of(orderNode);
    }).catchError((error) {});
  }

  // Constructor: ------------------------------------------------------------------------------------------------------
  _OrderStore(RequestHelper requestHelper) {
    this._requestHelper = requestHelper;
    _reaction();
  }
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
