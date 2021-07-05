// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'variation_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$VariationStore on _VariationStore, Store {
  Computed<ObservableMap<String, dynamic>> _$dataComputed;

  @override
  ObservableMap<String, dynamic> get data =>
      (_$dataComputed ??= Computed<ObservableMap<String, dynamic>>(() => super.data, name: '_VariationStore.data'))
          .value;
  Computed<ObservableMap<String, String>> _$selectedComputed;

  @override
  ObservableMap<String, String> get selected => (_$selectedComputed ??=
          Computed<ObservableMap<String, String>>(() => super.selected, name: '_VariationStore.selected'))
      .value;
  Computed<bool> _$loadingComputed;

  @override
  bool get loading =>
      (_$loadingComputed ??= Computed<bool>(() => super.loading, name: '_VariationStore.loading')).value;
  Computed<bool> _$canAddToCartComputed;

  @override
  bool get canAddToCart =>
      (_$canAddToCartComputed ??= Computed<bool>(() => super.canAddToCart, name: '_VariationStore.canAddToCart')).value;
  Computed<Map<String, dynamic>> _$findVariationComputed;

  @override
  Map<String, dynamic> get findVariation => (_$findVariationComputed ??=
          Computed<Map<String, dynamic>>(() => super.findVariation, name: '_VariationStore.findVariation'))
      .value;
  Computed<Product> _$productVariationComputed;

  @override
  Product get productVariation => (_$productVariationComputed ??=
          Computed<Product>(() => super.productVariation, name: '_VariationStore.productVariation'))
      .value;

  final _$_productIdAtom = Atom(name: '_VariationStore._productId');

  @override
  int get _productId {
    _$_productIdAtom.reportRead();
    return super._productId;
  }

  @override
  set _productId(int value) {
    _$_productIdAtom.reportWrite(value, super._productId, () {
      super._productId = value;
    });
  }

  final _$_selectedAtom = Atom(name: '_VariationStore._selected');

  @override
  ObservableMap<String, String> get _selected {
    _$_selectedAtom.reportRead();
    return super._selected;
  }

  @override
  set _selected(ObservableMap<String, String> value) {
    _$_selectedAtom.reportWrite(value, super._selected, () {
      super._selected = value;
    });
  }

  final _$_dataAtom = Atom(name: '_VariationStore._data');

  @override
  ObservableMap<String, dynamic> get _data {
    _$_dataAtom.reportRead();
    return super._data;
  }

  @override
  set _data(ObservableMap<String, dynamic> value) {
    _$_dataAtom.reportWrite(value, super._data, () {
      super._data = value;
    });
  }

  final _$_loadingAtom = Atom(name: '_VariationStore._loading');

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

  final _$getVariationAsyncAction = AsyncAction('_VariationStore.getVariation');

  @override
  Future<void> getVariation() {
    return _$getVariationAsyncAction.run(() => super.getVariation());
  }

  final _$_VariationStoreActionController = ActionController(name: '_VariationStore');

  @override
  void selectTerm({String key, String value}) {
    final _$actionInfo = _$_VariationStoreActionController.startAction(name: '_VariationStore.selectTerm');
    try {
      return super.selectTerm(key: key, value: value);
    } finally {
      _$_VariationStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clear() {
    final _$actionInfo = _$_VariationStoreActionController.startAction(name: '_VariationStore.clear');
    try {
      return super.clear();
    } finally {
      _$_VariationStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic dispose() {
    final _$actionInfo = _$_VariationStoreActionController.startAction(name: '_VariationStore.dispose');
    try {
      return super.dispose();
    } finally {
      _$_VariationStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
data: ${data},
selected: ${selected},
loading: ${loading},
canAddToCart: ${canAddToCart},
findVariation: ${findVariation},
productVariation: ${productVariation}
    ''';
  }
}
