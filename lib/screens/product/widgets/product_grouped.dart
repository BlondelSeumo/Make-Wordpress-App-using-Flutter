import 'package:cirilla/mixins/mixins.dart';
import 'package:cirilla/models/models.dart';
import 'package:cirilla/models/product/product_type.dart';
import 'package:cirilla/store/store.dart';
import 'package:cirilla/service/helpers/request_helper.dart';
import 'package:cirilla/widgets/cirilla_quantity.dart';
import 'package:cirilla/widgets/cirilla_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:ui/ui.dart';

import '../product.dart';

class ProductTypeGrouped extends StatefulWidget {
  final Product product;

  final Map<int, int> qty;
  final Function onChanged;

  ProductTypeGrouped({Key key, this.product, this.qty, this.onChanged}) : super(key: key);

  @override
  _ProductTypeGroupedState createState() => _ProductTypeGroupedState();
}

class _ProductTypeGroupedState extends State<ProductTypeGrouped> with ProductMixin {
  ProductsStore _productsStore;

  @override
  void didChangeDependencies() {
    RequestHelper requestHelper = Provider.of<RequestHelper>(context);

    _productsStore =
        ProductsStore(requestHelper, include: widget.product.groupedIds.map((e) => Product(id: e)).toList())
          ..getProducts();

    super.didChangeDependencies();
  }

  ///
  /// Handle navigate
  void _navigate(BuildContext context, Product product) {
    if (product.id == null) {
      return null;
    }
    Navigator.pushNamed(context, ProductScreen.routeName, arguments: {'product': product});
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    if (widget.product.groupedIds.length == 0) return Container();

    List<Product> loadingProduct = List.generate(widget.product.groupedIds.length, (index) => Product()).toList();

    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Observer(
        builder: (_) {
          List<Product> products = _productsStore.loading ? loadingProduct : _productsStore.products;
          return Column(
            children: List.generate(products.length, (index) {
              Product product = products[index];
              return Padding(
                padding: EdgeInsets.only(bottom: index < loadingProduct.length - 1 ? 1 : 0),
                child: ProductGroupedItem(
                  name: buildName(context, product: product, style: theme.textTheme.bodyText2),
                  quantity: buildQuantity(context, product: product, theme: theme),
                  price: buildPrice(context, product: product),
                  onClick: () => _navigate(context, product),
                  color: theme.dividerColor,
                ),
              );
            }),
          );
        },
      ),
    );
  }

  Widget buildQuantity(
    BuildContext context, {
    Product product,
    ThemeData theme,
    double shimmerWidth = 80,
    double shimmerHeight = 28,
  }) {
    if (product.id == null) {
      return CirillaShimmer(
        child: Container(
          height: shimmerHeight,
          width: shimmerWidth,
          color: Colors.white,
        ),
      );
    }
    if (product.type != ProductType.simple) {
      return SizedBox(
        width: shimmerWidth,
        child: ElevatedButton(onPressed: () => {}, child: Text('Select options')),
      );
    }
    return CirillaQuantity(
      onChanged: (value) {
        widget.onChanged(product: product, qty: value);
      },
      value: widget.qty[product.id] ?? 0,
      size: shimmerHeight,
      color: theme.scaffoldBackgroundColor,
    );
  }
}
