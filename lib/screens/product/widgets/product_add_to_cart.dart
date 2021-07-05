import 'package:cirilla/mixins/mixins.dart';
import 'package:cirilla/models/product/product.dart';
import 'package:cirilla/models/product/product_type.dart';
import 'package:cirilla/utils/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductAddToCart extends StatelessWidget with LoadingMixin {
  final Product product;
  final Function onPress;
  final bool loading;

  const ProductAddToCart({
    Key key,
    this.product,
    this.onPress,
    this.loading,
  }) : super(key: key);

  void addToCart() async {
    if (loading) return;
    if (product.type == ProductType.external) {
      await launch(product.externalUrl);
      return;
    }

    onPress();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      child: ElevatedButton(
        child: loading
            ? entryLoading(context, color: Colors.white)
            : Text(
                product.type == ProductType.external
                    ? product.buttonText
                    : AppLocalizations.of(context).translate('product_add_to_cart'),
              ),
        onPressed: addToCart,
      ),
    );
  }
}
