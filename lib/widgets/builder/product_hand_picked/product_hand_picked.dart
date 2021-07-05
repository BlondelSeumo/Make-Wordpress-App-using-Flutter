import 'package:cirilla/constants/strings.dart';
import 'package:cirilla/mixins/mixins.dart';
import 'package:cirilla/models/models.dart';
import 'package:cirilla/store/store.dart';
import 'package:cirilla/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../product/product.dart';

class ProductHandPickedWidget extends StatefulWidget {
  final WidgetConfig widgetConfig;

  ProductHandPickedWidget({
    Key key,
    this.widgetConfig,
  }) : super(key: key);

  @override
  _ProductHandPickedState createState() => _ProductHandPickedState();
}

class _ProductHandPickedState extends State<ProductHandPickedWidget> with Utility, PostMixin {
  AppStore _appStore;
  SettingStore _settingStore;
  ProductsStore _productsStore;

  @override
  void didChangeDependencies() {
    _appStore = Provider.of<AppStore>(context);
    _settingStore = Provider.of<SettingStore>(context);

    Map<String, dynamic> fields = widget?.widgetConfig?.fields ?? {};
    List<dynamic> product = get(fields, ['product'], []);

    // Filter
    int limit = ConvertData.stringToInt(get(fields, ['limit'], '4'));

    List<Product> inProducts = product.map((e) => Product(id: ConvertData.stringToInt(e['key']))).toList();

    String key = StringGenerate.getProductKeyStore(
      widget.widgetConfig.id,
      currency: _settingStore.currency,
      language: _settingStore.locale,
      includeProduct: inProducts,
      limit: limit,
    );

    // Add store to list store
    if (widget.widgetConfig != null && _appStore.getStoreByKey(key) == null) {
      ProductsStore store = ProductsStore(
        _settingStore.requestHelper,
        key: key,
        perPage: limit,
        sort: Map<String, dynamic>.from({
          'key': 'product_list_default',
          'query': {
            'orderby': 'date',
            'order': 'desc',
          }
        }),
        include: inProducts,
        language: _settingStore.locale,
        currency: _settingStore.currency,
      )..getProducts();
      _appStore.addStore(store);
      _productsStore ??= store;
    } else {
      _productsStore = _appStore.getStoreByKey(key);
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    String themeModeKey = _settingStore?.themeModeKey ?? 'value';

    // Item style
    WidgetConfig configs = widget.widgetConfig;

    // Item template
    String layout = configs.layout ?? Strings.productLayoutList;

    // Style
    Map<String, dynamic> margin = get(configs.styles, ['margin'], {});
    Map<String, dynamic> padding = get(configs.styles, ['padding'], {});
    Map<String, dynamic> background = get(configs.styles, ['background', themeModeKey], {});

    return Container(
      margin: ConvertData.space(margin, 'margin'),
      color: ConvertData.fromRGBA(background, Colors.transparent),
      child: ProductWidget(
        fields: configs.fields,
        styles: configs.styles,
        productsStore: _productsStore,
        layout: layout,
        padding: ConvertData.space(padding, 'padding'),
      ),
    );
  }
}
