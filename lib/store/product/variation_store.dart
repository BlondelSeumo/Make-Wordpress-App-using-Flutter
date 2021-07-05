import 'package:cirilla/models/product/product.dart';
import 'package:cirilla/models/product/product_variable.dart';
import 'package:cirilla/service/service.dart';
import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';

part 'variation_store.g.dart';

class VariationStore = _VariationStore with _$VariationStore;

abstract class _VariationStore with Store {
  final String key;
  final RequestHelper _requestHelper;

  // constructor: ------------------------------------------------------------------------------------------------------
  _VariationStore(this._requestHelper, {this.key, int productId}) {
    _productId = productId;
  }

  // store variables: --------------------------------------------------------------------------------------------------
  @observable
  int _productId;

  @observable
  ObservableMap<String, String> _selected = ObservableMap<String, String>.of({});

  @observable
  ObservableMap<String, dynamic> _data;

  @observable
  bool _loading = false;

  // computed: ---------------------------------------------------------------------------------------------------------

  // Get product variation info
  @computed
  ObservableMap<String, dynamic> get data => _data;

  // Get term selected
  @computed
  ObservableMap<String, String> get selected => _selected;

  @computed
  bool get loading => _loading;

  @computed
  bool get canAddToCart =>
      _data != null && _selected.keys.length > 0 && _selected.keys.length == _data['attribute_ids'].keys.length;

  @computed
  Map<String, dynamic> get findVariation => _data != null && canAddToCart
      ? _data['variations']?.firstWhere((e) {
          Map<String, String> attributes = Map<String, String>.from(e['attributes']);
          return _selected.keys.every(
            (el) {
              String key = "attribute_${el.toLowerCase()}";
              return attributes[key] == null || attributes[key] == '' || attributes[key] == _selected[el];
            },
          );
        }, orElse: () => null)
      : null;

  @computed
  Product get productVariation => findVariation != null ? Product.fromVariation(findVariation) : null;

  // actions: ----------------------------------------------------------------------------------------------------------
  @action
  void selectTerm({String key, String value}) {
    if (_selected.containsKey(key)) {
      _selected.update(key, (v) => value);
    } else {
      _selected.putIfAbsent(key, () => value);
    }
  }

  @action
  void clear() {
    _selected = ObservableMap<String, String>.of({});
  }

  @action
  Future<void> getVariation() async {
    _loading = true;
    try {
      ProductVariable data = await _requestHelper.getProductVariations(queryParameters: {
        'product_id': _productId,
      });
      _data = ObservableMap<String, dynamic>.of(data.toJson());
      _loading = false;
    } on DioError catch (e) {
      _loading = false;
      throw e;
    }
  }

  // dispose: ----------------------------------------------------------------------------------------------------------
  @action
  dispose() {}
}
