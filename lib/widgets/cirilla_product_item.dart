import 'package:cirilla/constants/strings.dart';
import 'package:cirilla/mixins/cart_mixin.dart';
import 'package:cirilla/mixins/mixins.dart';
import 'package:cirilla/mixins/product_mixin.dart';
import 'package:cirilla/models/models.dart';
import 'package:cirilla/models/product/product_type.dart';
import 'package:cirilla/screens/product/product.dart';
import 'package:cirilla/utils/app_localization.dart';
import 'package:cirilla/utils/convert_data.dart';
import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

class CirillaProductItem extends StatefulWidget {
  final Product product;

  // Product item template
  final String template;

  final double width;

  final double height;

  final Map<String, dynamic> dataTemplate;

  final Color background;
  final Color textColor;
  final Color subTextColor;
  final Color priceColor;
  final Color salePriceColor;
  final Color regularPriceColor;

  final Color labelNewColor;
  final Color labelNewTextColor;
  final double labelNewRadius;

  final Color labelSaleColor;
  final Color labelSaleTextColor;
  final double labelSaleRadius;

  final double radius;
  final double radiusImage;

  final List<BoxShadow> boxShadow;

  final Border border;

  const CirillaProductItem({
    Key key,
    this.product,
    this.template = Strings.productItemContained,
    this.width = 160,
    this.height = 190,
    this.dataTemplate = const {},
    this.background,
    this.textColor,
    this.subTextColor,
    this.priceColor,
    this.salePriceColor,
    this.regularPriceColor,
    this.labelNewColor,
    this.labelNewTextColor,
    this.labelNewRadius = 10,
    this.labelSaleColor,
    this.labelSaleTextColor,
    this.labelSaleRadius = 10,
    this.radius = 0,
    this.radiusImage = 10,
    this.boxShadow,
    this.border,
  }) : super(key: key);

  @override
  _CirillaProductItemState createState() => _CirillaProductItemState();
}

class _CirillaProductItemState extends State<CirillaProductItem>
    with CartMixin, SnackMixin, ProductMixin, Utility, WishListMixin, LoadingMixin {
  bool _loading = false;

  ///
  /// Handle add to cart
  Future<void> _handleAddToCart(BuildContext context) async {
    if (widget.product == null || widget.product.id == null) return;

    if (widget.product.type == ProductType.variable || widget.product.type == ProductType.grouped) {
      _navigate(context);
      return;
    }

    setState(() {
      _loading = true;
    });
    try {
      await addToCart(productId: widget.product.id, qty: 1);
      showSuccess(context, AppLocalizations.of(context).translate('product_add_to_cart_success'));
      setState(() {
        _loading = false;
      });
    } catch (e) {
      showError(context, e);
      setState(() {
        _loading = false;
      });
    }
  }

  ///
  /// Handle navigate
  void _navigate(BuildContext context) {
    if (widget.product == null || widget.product.id == null) return;
    Navigator.pushNamed(context, ProductScreen.routeName, arguments: {'product': widget.product});
  }

  ///
  /// Handle wishlist
  void _wishlist(BuildContext context) {
    if (widget.product == null || widget.product.id == null) return;
    addWishList(productId: widget.product.id);
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    bool enableLabelNew = get(widget.dataTemplate, ['enableLabelNew'], true);
    bool enableLabelSale = get(widget.dataTemplate, ['enableLabelSale'], true);
    bool enableRating = get(widget.dataTemplate, ['enableRating'], true);
    BoxFit fit = ConvertData.toBoxFit(get(widget.dataTemplate, ['imageSize'], 'cover'));

    TextStyle stylePrice = theme.textTheme.subtitle2.copyWith(color: widget.priceColor);
    TextStyle styleSale = theme.textTheme.subtitle2.copyWith(color: widget.salePriceColor ?? Color(0xFFF01F0E));
    TextStyle styleRegular =
        theme.textTheme.subtitle2.copyWith(color: widget.regularPriceColor, fontWeight: FontWeight.normal);
    TextStyle styleTextFrom = theme.textTheme.caption.copyWith(color: widget.subTextColor);

    switch (widget.template) {
      case Strings.productItemHorizontal:
        double widthImage = 86;
        double heightImage = (widthImage * widget.height) / widget.width;
        return SizedBox(
          width: widget.width ?? 335,
          child: ProductHorizontalItem(
            image: buildImage(
              context,
              product: widget.product,
              width: widthImage,
              height: heightImage,
              borderRadius: widget.radiusImage,
              fit: fit,
            ),
            name: buildName(
              context,
              product: widget.product,
              style: theme.textTheme.bodyText2.copyWith(color: widget.textColor),
            ),
            price: buildPrice(
              context,
              product: widget.product,
              priceStyle: stylePrice,
              saleStyle: styleSale,
              regularStyle: styleRegular,
              styleFrom: styleTextFrom,
            ),
            tagExtra: enableLabelNew || enableLabelSale
                ? buildTagExtra(
                    context,
                    product: widget.product,
                    enableNew: enableLabelNew,
                    newColor: widget.labelNewColor,
                    newTextColor: widget.labelNewTextColor,
                    newRadius: widget.labelNewRadius,
                    enableSale: enableLabelSale,
                    saleColor: widget.labelSaleColor,
                    saleTextColor: widget.labelSaleTextColor,
                    saleRadius: widget.labelSaleRadius,
                  )
                : null,
            addCard: _loading
                ? _buildLoading(context)
                : buildAddCart(context, product: widget.product, onTap: () => _handleAddToCart(context)),
            rating: enableRating ? buildRating(context, product: widget.product, color: widget.subTextColor) : null,
            borderRadius: BorderRadius.circular(widget.radius),
            border: widget.border,
            boxShadow: widget.boxShadow,
            color: widget.background ?? Colors.transparent,
            onClick: () => _navigate(context),
          ),
        );
      case Strings.productItemEmerge:
        return ProductEmergeItem(
          image: buildImage(
            context,
            product: widget.product,
            width: widget.width,
            height: widget.height,
            borderRadius: widget.radiusImage,
            fit: fit,
          ),
          name: buildName(
            context,
            product: widget.product,
            style: theme.textTheme.subtitle1.copyWith(color: widget.textColor),
          ),
          price: buildPrice(
            context,
            product: widget.product,
            priceStyle: stylePrice,
            saleStyle: styleSale,
            regularStyle: styleRegular,
            styleFrom: styleTextFrom,
          ),
          tagExtra: enableLabelNew || enableLabelSale
              ? buildTagExtra(
                  context,
                  product: widget.product,
                  enableNew: enableLabelNew,
                  newColor: widget.labelNewColor,
                  newTextColor: widget.labelNewTextColor,
                  newRadius: widget.labelNewRadius,
                  enableSale: enableLabelSale,
                  saleColor: widget.labelSaleColor,
                  saleTextColor: widget.labelSaleTextColor,
                  saleRadius: widget.labelSaleRadius,
                )
              : null,
          addCard: _loading
              ? _buildLoading(context)
              : buildAddCart(context, product: widget.product, isRound: true, onTap: () => _handleAddToCart(context)),
          rating: enableRating ? buildRating(context, product: widget.product, color: widget.subTextColor) : null,
          category: buildCategory(context, product: widget.product, color: widget.subTextColor),
          wishlist: buildWishlist(
            context,
            product: widget.product,
            isSelected: existWishList(productId: widget.product.id),
            onTap: () => _wishlist(context),
          ),
          width: widget.width,
          borderRadius: BorderRadius.circular(widget.radius),
          border: widget.border,
          boxShadow: widget.boxShadow,
          color: widget.background,
          onClick: () => _navigate(context),
        );
      case Strings.productItemVertical:
        return ProductVerticalItem(
          image: buildImage(
            context,
            product: widget.product,
            width: widget.width,
            height: widget.height,
            borderRadius: widget.radiusImage,
            fit: fit,
          ),
          name: buildName(
            context,
            product: widget.product,
            style: theme.textTheme.subtitle1.copyWith(color: widget.textColor),
          ),
          price: buildPrice(
            context,
            product: widget.product,
            priceStyle: stylePrice,
            saleStyle: styleSale,
            regularStyle: styleRegular,
            styleFrom: styleTextFrom,
          ),
          tagExtra: enableLabelNew || enableLabelSale
              ? buildTagExtra(
                  context,
                  product: widget.product,
                  enableNew: enableLabelNew,
                  newColor: widget.labelNewColor,
                  newTextColor: widget.labelNewTextColor,
                  newRadius: widget.labelNewRadius,
                  enableSale: enableLabelSale,
                  saleColor: widget.labelSaleColor,
                  saleTextColor: widget.labelSaleTextColor,
                  saleRadius: widget.labelSaleRadius,
                )
              : null,
          addCard: _loading
              ? _buildLoading(context)
              : buildAddCart(context, product: widget.product, isRound: true, onTap: () => _handleAddToCart(context)),
          rating: enableRating ? buildRating(context, product: widget.product, color: widget.subTextColor) : null,
          category: buildCategory(context, product: widget.product, color: widget.subTextColor),
          wishlist: buildWishlist(
            context,
            product: widget.product,
            isSelected: existWishList(productId: widget.product.id),
            onTap: () => _wishlist(context),
          ),
          width: widget.width,
          borderRadius: BorderRadius.circular(widget.radius),
          border: widget.border,
          boxShadow: widget.boxShadow,
          color: widget.background,
          onClick: () => _navigate(context),
        );
      case Strings.productItemVerticalCenter:
        return ProductVerticalItem(
          image: buildImage(
            context,
            product: widget.product,
            width: widget.width,
            height: widget.height,
            borderRadius: widget.radiusImage,
            fit: fit,
          ),
          name: buildName(
            context,
            product: widget.product,
            style: theme.textTheme.subtitle1.copyWith(color: widget.textColor),
          ),
          price: buildPrice(
            context,
            product: widget.product,
            priceStyle: stylePrice,
            saleStyle: styleSale,
            regularStyle: styleRegular,
            styleFrom: styleTextFrom,
          ),
          tagExtra: enableLabelNew || enableLabelSale
              ? buildTagExtra(
                  context,
                  product: widget.product,
                  enableNew: enableLabelNew,
                  newColor: widget.labelNewColor,
                  newTextColor: widget.labelNewTextColor,
                  newRadius: widget.labelNewRadius,
                  enableSale: enableLabelSale,
                  saleColor: widget.labelSaleColor,
                  saleTextColor: widget.labelSaleTextColor,
                  saleRadius: widget.labelSaleRadius,
                )
              : null,
          addCard: _loading
              ? _buildLoading(context)
              : buildAddCart(context,
                  product: widget.product, isButtonElevated: true, onTap: () => _handleAddToCart(context)),
          rating: enableRating ? buildRating(context, product: widget.product, color: widget.subTextColor) : null,
          category: buildCategory(context, product: widget.product, color: widget.subTextColor),
          wishlist: buildWishlist(
            context,
            product: widget.product,
            isSelected: existWishList(productId: widget.product.id),
            onTap: () => _wishlist(context),
          ),
          width: widget.width,
          type: ProductVerticalItemType.center,
          borderRadius: BorderRadius.circular(widget.radius),
          border: widget.border,
          boxShadow: widget.boxShadow,
          color: widget.background,
          onClick: () => _navigate(context),
        );
      default:
        return ProductContainedItem(
          image: buildImage(
            context,
            product: widget.product,
            width: widget.width,
            height: widget.height,
            borderRadius: widget.radiusImage,
            fit: fit,
          ),
          name: buildName(
            context,
            product: widget.product,
            style: theme.textTheme.bodyText2.copyWith(color: widget.textColor),
          ),
          price: buildPrice(
            context,
            product: widget.product,
            priceStyle: stylePrice,
            saleStyle: styleSale,
            regularStyle: styleRegular,
            styleFrom: styleTextFrom,
          ),
          tagExtra: enableLabelNew || enableLabelSale
              ? buildTagExtra(
                  context,
                  product: widget.product,
                  enableNew: enableLabelNew,
                  newColor: widget.labelNewColor,
                  newTextColor: widget.labelNewTextColor,
                  newRadius: widget.labelNewRadius,
                  enableSale: enableLabelSale,
                  saleColor: widget.labelSaleColor,
                  saleTextColor: widget.labelSaleTextColor,
                  saleRadius: widget.labelSaleRadius,
                )
              : null,
          wishlist: buildWishlist(
            context,
            product: widget.product,
            isSelected: existWishList(productId: widget.product.id),
            onTap: () => _wishlist(context),
          ),
          addCard: _loading
              ? _buildLoading(context)
              : buildAddCart(context, product: widget.product, onTap: () => _handleAddToCart(context)),
          rating: enableRating ? buildRating(context, product: widget.product, color: widget.subTextColor) : null,
          width: widget.width,
          borderRadius: BorderRadius.circular(widget.radius),
          border: widget.border,
          boxShadow: widget.boxShadow,
          color: widget.background ?? Colors.transparent,
          onClick: () => _navigate(context),
        );
    }
  }

  _buildLoading(BuildContext context) {
    return Container(child: Center(child: entryLoading(context)), width: 32, height: 32);
  }
}
