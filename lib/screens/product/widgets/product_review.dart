import 'package:cirilla/mixins/transition_mixin.dart';
import 'package:cirilla/models/product/product.dart';
import 'package:cirilla/service/helpers/request_helper.dart';
import 'package:cirilla/store/product/review_store.dart';
import 'package:cirilla/types/types.dart';
import 'package:cirilla/utils/app_localization.dart';
import 'package:cirilla/utils/utils.dart';
import 'package:cirilla/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'product_review_list.dart';

class ProductReview extends StatefulWidget {
  final Product product;
  final bool expand;
  final String align;

  const ProductReview({Key key, this.product, this.expand, this.align = 'left'}) : super(key: key);

  @override
  _ProductReviewState createState() => _ProductReviewState();
}

class _ProductReviewState extends State<ProductReview> with TransitionMixin {
  ProductReviewStore _productReviewStore;

  @override
  void didChangeDependencies() {
    _productReviewStore = ProductReviewStore(
      Provider.of<RequestHelper>(context),
      productId: widget.product.id,
    );
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TranslateType translate = AppLocalizations.of(context).translate;

    if (widget.expand) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            child: Text(
              translate('product_reviews'),
              style: theme.textTheme.subtitle1,
              textAlign: ConvertData.toTextAlign(widget.align),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: BasicInfoReview(product: widget.product, store: _productReviewStore),
          ),
          OutlinedButton(
            onPressed: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, _a1, _a2) =>
                      ProductReviewList(product: widget.product, store: _productReviewStore),
                  transitionsBuilder: slideTransition,
                ),
              );
            },
            child: Text(translate('product_all_reviews')),
          )
        ],
      );
    }

    return CirillaTile(
      title: Text(translate('product_reviews'), style: theme.textTheme.subtitle2),
      isDivider: false,
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, _a1, _a2) => ProductReviewList(
              product: widget.product,
              store: _productReviewStore,
            ),
            transitionsBuilder: slideTransition,
          ),
        );
      },
    );
  }
}
