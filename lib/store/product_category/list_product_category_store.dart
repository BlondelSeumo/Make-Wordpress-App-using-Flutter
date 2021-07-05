import 'package:mobx/mobx.dart';

import 'product_category_store.dart';

part 'list_product_category_store.g.dart';

class ListProductCategoryStore = _ListProductCategoryStore with _$ListProductCategoryStore;

abstract class _ListProductCategoryStore with Store {
  final ObservableList<ProductCategoryStore> _stores = ObservableList<ProductCategoryStore>.of([]);

  @action
  void addStore(ProductCategoryStore store) {
    int index = _stores.indexWhere((_store) => _store.parent == store.parent);
    if (index == -1) {
      _stores.add(store);
    }
  }

  @action
  void removeStore(int index) {
    _stores.removeAt(index);
  }

  @action
  ProductCategoryStore getStoreByIndex(int index) {
    return _stores[index];
  }

  @action
  ProductCategoryStore getStoreByParent(int parent) {
    int index = _stores.indexWhere((_store) => _store.parent == parent);
    if (index == -1) return null;
    return _stores[index];
  }
}
