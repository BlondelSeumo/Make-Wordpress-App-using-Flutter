// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$OrderStore on _OrderStore, Store {
  Computed<int> _$perPageComputed;

  @override
  int get perPage => (_$perPageComputed ??= Computed<int>(() => super.perPage, name: '_OrderStore.perPage')).value;
  Computed<bool> _$canLoadMoreComputed;

  @override
  bool get canLoadMore =>
      (_$canLoadMoreComputed ??= Computed<bool>(() => super.canLoadMore, name: '_OrderStore.canLoadMore')).value;
  Computed<bool> _$loadingComputed;

  @override
  bool get loading => (_$loadingComputed ??= Computed<bool>(() => super.loading, name: '_OrderStore.loading')).value;
  Computed<bool> _$loadingNodeComputed;

  @override
  bool get loadingNode =>
      (_$loadingNodeComputed ??= Computed<bool>(() => super.loadingNode, name: '_OrderStore.loadingNode')).value;
  Computed<ObservableList<OrderData>> _$ordersComputed;

  @override
  ObservableList<OrderData> get orders =>
      (_$ordersComputed ??= Computed<ObservableList<OrderData>>(() => super.orders, name: '_OrderStore.orders')).value;
  Computed<ObservableList<OrderNode>> _$orderNodeComputed;

  @override
  ObservableList<OrderNode> get orderNode => (_$orderNodeComputed ??=
          Computed<ObservableList<OrderNode>>(() => super.orderNode, name: '_OrderStore.orderNode'))
      .value;

  final _$_loadingAtom = Atom(name: '_OrderStore._loading');

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

  final _$fetchOrdersFutureAtom = Atom(name: '_OrderStore.fetchOrdersFuture');

  @override
  ObservableFuture<List<OrderData>> get fetchOrdersFuture {
    _$fetchOrdersFutureAtom.reportRead();
    return super.fetchOrdersFuture;
  }

  @override
  set fetchOrdersFuture(ObservableFuture<List<OrderData>> value) {
    _$fetchOrdersFutureAtom.reportWrite(value, super.fetchOrdersFuture, () {
      super.fetchOrdersFuture = value;
    });
  }

  final _$fetchOrderNodeFutureAtom = Atom(name: '_OrderStore.fetchOrderNodeFuture');

  @override
  ObservableFuture<List<OrderNode>> get fetchOrderNodeFuture {
    _$fetchOrderNodeFutureAtom.reportRead();
    return super.fetchOrderNodeFuture;
  }

  @override
  set fetchOrderNodeFuture(ObservableFuture<List<OrderNode>> value) {
    _$fetchOrderNodeFutureAtom.reportWrite(value, super.fetchOrderNodeFuture, () {
      super.fetchOrderNodeFuture = value;
    });
  }

  final _$_ordersAtom = Atom(name: '_OrderStore._orders');

  @override
  ObservableList<OrderData> get _orders {
    _$_ordersAtom.reportRead();
    return super._orders;
  }

  @override
  set _orders(ObservableList<OrderData> value) {
    _$_ordersAtom.reportWrite(value, super._orders, () {
      super._orders = value;
    });
  }

  final _$_orderNodeAtom = Atom(name: '_OrderStore._orderNode');

  @override
  ObservableList<OrderNode> get _orderNode {
    _$_orderNodeAtom.reportRead();
    return super._orderNode;
  }

  @override
  set _orderNode(ObservableList<OrderNode> value) {
    _$_orderNodeAtom.reportWrite(value, super._orderNode, () {
      super._orderNode = value;
    });
  }

  final _$_nextPageAtom = Atom(name: '_OrderStore._nextPage');

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

  final _$_perPageAtom = Atom(name: '_OrderStore._perPage');

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

  final _$_canLoadMoreAtom = Atom(name: '_OrderStore._canLoadMore');

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

  final _$_searchAtom = Atom(name: '_OrderStore._search');

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

  final _$getOrdersAsyncAction = AsyncAction('_OrderStore.getOrders');

  @override
  Future<void> getOrders({String userId}) {
    return _$getOrdersAsyncAction.run(() => super.getOrders(userId: userId));
  }

  final _$_OrderStoreActionController = ActionController(name: '_OrderStore');

  @override
  Future<void> refresh() {
    final _$actionInfo = _$_OrderStoreActionController.startAction(name: '_OrderStore.refresh');
    try {
      return super.refresh();
    } finally {
      _$_OrderStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
fetchOrdersFuture: ${fetchOrdersFuture},
fetchOrderNodeFuture: ${fetchOrderNodeFuture},
perPage: ${perPage},
canLoadMore: ${canLoadMore},
loading: ${loading},
loadingNode: ${loadingNode},
orders: ${orders},
orderNode: ${orderNode}
    ''';
  }
}
