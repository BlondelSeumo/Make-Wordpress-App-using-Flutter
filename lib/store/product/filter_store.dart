import 'dart:convert';
import 'package:cirilla/service/helpers/request_helper.dart';
import 'package:cirilla/models/product_category/product_category.dart';
import 'package:cirilla/models/product/attributes.dart';
import 'package:cirilla/models/product/product_prices.dart';
import 'package:cirilla/store/product/products_store.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'filter_store.g.dart';

class FilterStore = _FilterStore with _$FilterStore;

abstract class _FilterStore with Store {
  RequestHelper _requestHelper;
  ProductsStore _productsStore;

  // Constructor:-------------------------------------------------------------------------------------------------------
  _FilterStore(
    RequestHelper requestHelper, {
    bool onSale,
    bool featured,
    bool inStock,
    ProductCategory category,
    ProductPrices productPrices,
    RangeValues rangePrices,
    List<Attribute> attributes,
    List<ItemAttributeSelected> attributeSelected,
    ProductsStore productsStore,
  }) {
    _requestHelper = requestHelper;
    _productsStore = productsStore;

    if (onSale != null) _onSale = onSale;
    if (featured != null) _featured = featured;
    if (inStock != null) _inStock = inStock;
    if (category != null) _category = category;
    if (attributes != null) _attributes = ObservableList.of(attributes);
    if (attributeSelected != null) _attributeSelected = ObservableList.of(attributeSelected);
    if (rangePrices != null) _rangePrices = rangePrices;
    if (productPrices != null) _productPrices = productPrices;

    _reaction();
  }

  // Store variables:---------------------------------------------------------------------------------------------------

  @observable
  ObservableList<Attribute> _attributes = ObservableList<Attribute>.of([]);

  @observable
  ProductPrices _productPrices = ProductPrices(minPrice: 0.0, maxPrice: 0.0);

  @observable
  RangeValues _rangePrices = RangeValues(0.0, 0.0);

  @observable
  bool _featured = false;

  @observable
  bool _onSale = false;

  @observable
  bool _inStock = false;

  @observable
  ProductCategory _category;

  @observable
  bool _loadingAttributes = false;

  @observable
  bool _loadingPrices = false;

  @observable
  ObservableList<ItemAttributeSelected> _attributeSelected = ObservableList<ItemAttributeSelected>.of([]);

  @observable
  ObservableMap<String, bool> _itemExpand = ObservableMap<String, bool>.of({});

  // Computed variables:------------------------------------------------------------------------------------------------
  @computed
  bool get loadingAttributes => _loadingAttributes;

  @computed
  bool get loadingPrices => _loadingPrices;

  @computed
  bool get onSale => _onSale;

  @computed
  bool get inStock => _inStock;

  @computed
  bool get featured => _featured;

  @computed
  ProductCategory get category => _category;

  @computed
  RangeValues get rangePrices => _rangePrices;

  @computed
  ProductPrices get productPrices => _productPrices;

  @computed
  ObservableList<Attribute> get attributes => _attributes;

  @computed
  String get values =>
      "$_inStock $_onSale $_featured ${_category != null ? _category.id : 0} ${_attributeSelected.map((e) => e.toString())} ${_rangePrices.toString()}";

  @computed
  ObservableList<ItemAttributeSelected> get attributeSelected => _attributeSelected;

  @computed
  ObservableMap<String, bool> get itemExpand => _itemExpand;

  // Actions:-----------------------------------------------------------------------------------------------------------
  @action
  void expand(String key) {
    if (_itemExpand.containsKey(key)) {
      _itemExpand.remove(key);
    } else {
      _itemExpand.putIfAbsent(key, () => true);
    }
  }

  @action
  void selectAttribute(ItemAttributeSelected value) {
    int i = _attributeSelected.indexWhere((att) => att.taxonomy == value.taxonomy && att.terms == value.terms);
    if (i >= 0) {
      _attributeSelected.removeWhere((att) => att.taxonomy == value.taxonomy && att.terms == value.terms);
    } else {
      _attributeSelected.add(value);
    }
  }

  @action
  Future getAttributes({Map<String, dynamic> queryParameters, bool updateStore = true}) async {
    _loadingAttributes = true;
    try {
      List<Map> attrs = [];
      if (_category != null) {
        attrs.add({
          'taxonomy': 'product_cat',
          'field': 'cat_id',
          'terms': [_category.id],
        });
      }

      if (_attributeSelected.length > 0) {
        _attributeSelected.forEach((a) {
          attrs.add(a.query);
        });
      }

      Attributes attributes = await _requestHelper.getAttributes(queryParameters: {
        'attrs': jsonEncode(attrs),
      });
      _attributes = ObservableList<Attribute>.of(attributes.attributes);
      // TODO: Remove _attributeSelected not exist in new attributes
      _loadingAttributes = false;
    } catch (e) {
      _loadingAttributes = false;
      throw e;
    }
  }

  @action
  void setMinMaxPrice(double minPrice, double maxPrice) {
    _rangePrices = RangeValues(minPrice, maxPrice);
  }

  @action
  Future<void> getMinMaxPrices({ProductCategory category, bool updateStore = true}) async {
    try {
      ProductPrices prices = await _requestHelper.getMinMaxPrices(queryParameters: {'category': _category?.id ?? ''});
      _productPrices = prices;
      _rangePrices = RangeValues(prices.minPrice, prices.maxPrice);
    } catch (e) {
      throw e;
    }
  }

  @action
  void onChange(
      {Map sort,
      bool onSale,
      bool featured,
      bool inStock,
      ProductCategory category,
      ProductPrices productPrices,
      RangeValues rangePrices,
      List<Attribute> attributes,
      List<ItemAttributeSelected> attributeSelected,
      bool refresh = false}) {
    if (onSale != null) _onSale = onSale;
    if (featured != null) _featured = featured;
    if (inStock != null) _inStock = inStock;
    if (category != null) _category = category;
    if (attributes != null) _attributes = ObservableList.of(attributes);
    if (attributeSelected != null) _attributeSelected = ObservableList.of(attributeSelected);
    if (rangePrices != null)
      _rangePrices = RangeValues(
        rangePrices.start,
        rangePrices.end,
      );
    if (productPrices != null)
      _productPrices = ProductPrices(
        minPrice: productPrices.minPrice,
        maxPrice: productPrices.maxPrice,
      );
    if (_productsStore != null) _productsStore.refresh();
  }

  @action
  void clearAll({ProductCategory category}) {
    _category = category;
    _onSale = false;
    _featured = false;
    _inStock = false;
    _attributeSelected = ObservableList.of([]);
    _rangePrices = RangeValues(0.0, 0.0);
    _productPrices = ProductPrices(minPrice: 0, maxPrice: 0);

    if (_productsStore != null) _productsStore.refresh();
  }

  // disposers: --------------------------------------------------------------------------------------------------------
  List<ReactionDisposer> _disposers;

  void _reaction() {
    _disposers = [
      reaction((_) => _category.id, (categoryId) {
        getAttributes();
      }),
      reaction((_) => _attributeSelected.toString(), (attrs) {
        getAttributes();
      }),
    ];
  }

  void dispose() {
    for (final d in _disposers) {
      d();
    }
  }
}
