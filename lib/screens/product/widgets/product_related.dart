import 'package:cirilla/models/product/product.dart';
import 'package:cirilla/service/helpers/request_helper.dart';
import 'package:cirilla/store/app_store.dart';
import 'package:cirilla/store/product/products_store.dart';
import 'package:cirilla/store/setting/setting_store.dart';
import 'package:cirilla/types/types.dart';
import 'package:cirilla/utils/app_localization.dart';
import 'package:cirilla/utils/convert_data.dart';
import 'package:cirilla/utils/utils.dart';
import 'package:cirilla/widgets/cirilla_product_item.dart';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class ProductRelated extends StatefulWidget {
  final Product product;
  final EdgeInsetsDirectional padding;
  final String align;

  const ProductRelated({
    Key key,
    this.product,
    this.padding = EdgeInsetsDirectional.zero,
    this.align = 'left',
  }) : super(key: key);

  @override
  _ProductRelatedState createState() => _ProductRelatedState();
}

class _ProductRelatedState extends State<ProductRelated> {
  ProductsStore _productsStore;
  AppStore _appStore;

  @override
  void didChangeDependencies() {
    RequestHelper requestHelper = Provider.of<RequestHelper>(context);
    _appStore = Provider.of<AppStore>(context);
    SettingStore settingStore = Provider.of<SettingStore>(context);

    List<Product> productRelated = widget.product.relatedIds.map((e) => Product(id: e)).toList();

    String key = StringGenerate.getProductKeyStore(
      'related_product',
      includeProduct: productRelated,
      currency: settingStore.currency,
      language: settingStore.locale,
    );

    if (_appStore.getStoreByKey(key) == null) {
      ProductsStore store = ProductsStore(
        requestHelper,
        key: key,
        include: productRelated,
        language: settingStore.locale,
        currency: settingStore.currency,
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
    TranslateType translate = AppLocalizations.of(context).translate;

    if (widget.product.relatedIds.length == 0) return Container();

    List<Product> loadingProduct = List.generate(widget.product.relatedIds.length, (index) => Product()).toList();

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: widget.padding,
            child: Container(
              width: double.infinity,
              child: Text(
                translate('product_related'),
                style: Theme.of(context).textTheme.headline6,
                textAlign: ConvertData.toTextAlign(widget.align),
              ),
            ),
          ),
          SizedBox(height: 24),
          Container(
            height: 320,
            child: Observer(
              builder: (_) {
                List<Product> products = _productsStore.loading ? loadingProduct : _productsStore.products;
                return ListView.separated(
                  padding: widget.padding,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) => CirillaProductItem(
                    product: products[index],
                    template: 'default',
                    width: 142,
                    height: 169,
                  ),
                  separatorBuilder: (BuildContext context, int index) => SizedBox(width: 16),
                  itemCount: widget.product.relatedIds.length,
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
