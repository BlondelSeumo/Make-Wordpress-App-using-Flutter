import 'package:mobx/mobx.dart';

part 'app_store.g.dart';

class AppStore = _AppStore with _$AppStore;

abstract class _AppStore with Store {
  final ObservableList<dynamic> _stores = ObservableList<dynamic>.of([]);

  @action
  void addStore(dynamic store) {
    int index = _stores.indexWhere((_store) => _store.key == store.key);
    if (index == -1) {
      _stores.add(store);
    }
  }

  @action
  void removeStore(int index) {
    _stores.removeAt(index);
  }

  @action
  dynamic getStoreByIndex(int index) {
    return _stores[index];
  }

  @action
  dynamic getStoreByKey(String key) {
    return _stores.firstWhere((element) => element != null && element.key == key, orElse: () => null);
  }
}
