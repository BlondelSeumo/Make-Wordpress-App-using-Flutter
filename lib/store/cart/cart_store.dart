import 'package:cirilla/models/cart/cart.dart';
import 'package:cirilla/service/helpers/persist_helper.dart';
import 'package:cirilla/service/helpers/request_helper.dart';
import 'package:cirilla/store/auth/auth_store.dart';
import 'package:cirilla/utils/string_generate.dart';
import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';

part 'cart_store.g.dart';

class CartStore = _CartStore with _$CartStore;

abstract class _CartStore with Store {
  final PersistHelper _persistHelper;
  final RequestHelper _requestHelper;
  final AuthStore _authStore;

  @observable
  bool _loading = false;

  @observable
  String _cartKey;

  @observable
  CartData _cartData;

  @observable
  bool _canLoadMore = true;

  @computed
  bool get canLoadMore => _canLoadMore;

  @computed
  bool get loading => _loading;

  @computed
  CartData get cartData => _cartData;

  @computed
  int get count => _cartData != null ? _cartData.itemsCount : 0;

  @computed
  String get cartKey => _cartKey;

  // Action: -----------------------------------------------------------------------------------------------------------
  @action
  Future<void> setCartKey(String value) async {
    if (value == null) return;
    _cartKey = value;
    return await _persistHelper.saveCartKey(value);
  }

  @action
  Future<void> mergeCart({bool isLogin}) async {
    if (isLogin == true && _authStore.user != null) {
      await setCartKey(_authStore.user.id);
    } else {
      String id = StringGenerate.uuid();
      await setCartKey(id);
    }
  }

  @action
  Future<void> getCart() async {
    _loading = true;
    try {
      Map<String, dynamic> json = await _requestHelper.getCart(
        queryParameters: {'cart_key': _cartKey},
      );
      // print(json);
      _cartData = CartData.fromJson(json);
      _loading = false;
      _canLoadMore = false;
    } on DioError catch (e) {
      _loading = false;
      _canLoadMore = false;
      throw e;
    }
  }

  @action
  Future<void> refresh() async {
    _canLoadMore = true;
    return getCart();
  }

  @action
  Future<void> updateQuantity({key: String, quantity: int}) async {
    try {
      Map<String, dynamic> json = await _requestHelper.updateQuantity(
        cartKey: _cartKey,
        queryParameters: {'key': key, 'quantity': quantity},
      );
      _cartData = CartData.fromJson(json);
    } on DioError catch (e) {
      throw e;
    }
  }

  @action
  Future<void> applyCoupon({code: String}) async {
    _loading = true;
    try {
      Map<String, dynamic> json = await _requestHelper.applyCoupon(
        cartKey: _cartKey,
        queryParameters: {'code': code},
      );
      _cartData = CartData.fromJson(json);
      _loading = false;
    } on DioError catch (e) {
      _loading = false;
      throw e;
    }
  }

  @action
  Future<void> removeCoupon({code: String}) async {
    _loading = true;
    try {
      Map<String, dynamic> json = await _requestHelper.removeCoupon(
        cartKey: _cartKey,
        queryParameters: {'code': code},
      );
      _cartData = CartData.fromJson(json);
      _loading = false;
    } on DioError catch (e) {
      _loading = false;
      throw e;
    }
  }

  @action
  Future<void> removeCart({key: String}) async {
    _loading = true;
    try {
      Map<String, dynamic> json = await _requestHelper.removeCart(
        cartKey: _cartKey,
        queryParameters: {'key': key},
      );
      _cartData = CartData.fromJson(json);
      _loading = false;
    } on DioError catch (e) {
      _loading = false;
      throw e;
    }
  }

  @action
  Future<void> addToCart(Map<String, dynamic> data) async {
    try {
      Map<String, dynamic> json = await _requestHelper.addToCart(
        cartKey: _cartKey,
        queryParameters: data,
      );
      _cartData = CartData.fromJson(json);
    } on DioError catch (e) {
      throw e;
    }
  }

  // Constructor: ------------------------------------------------------------------------------------------------------
  _CartStore(this._persistHelper, this._requestHelper, this._authStore) {
    init();
    _reaction();
  }

  Future init() async {
    await restore();
    if (_cartKey != null) getCart();
  }

  Future<void> restore() async {
    String cartKey = _persistHelper.getCartKey();
    if (cartKey != null && cartKey != "") {
      _cartKey = cartKey;
      await setCartKey(cartKey);
    } else {
      String id = StringGenerate.uuid();
      await setCartKey(id);
    }
  }

  // disposers:---------------------------------------------------------------------------------------------------------
  List<ReactionDisposer> _disposers;

  void _reaction() {
    _disposers = [
      reaction((_) => _authStore.isLogin, (isLogin) => mergeCart(isLogin: isLogin)),
    ];
  }

  void dispose() {
    for (final d in _disposers) {
      d();
    }
  }
}
