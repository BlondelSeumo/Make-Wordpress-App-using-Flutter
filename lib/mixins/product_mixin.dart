import 'package:cirilla/constants/assets.dart';
import 'package:cirilla/constants/constants.dart';
import 'package:cirilla/models/product/product.dart';

import 'package:cirilla/models/product/product_category.dart';
import 'package:cirilla/models/product/product_type.dart';
import 'package:cirilla/utils/convert_data.dart';
import 'package:cirilla/utils/currency_format.dart';
import 'package:cirilla/utils/utils.dart';
import 'package:cirilla/widgets/cirilla_shimmer.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:ui/ui.dart';
import 'package:cirilla/widgets/widgets.dart';

mixin ProductMixin {
  Widget buildImage(
    BuildContext context, {
    Product product,
    double width = 100,
    double height = 100,
    double borderRadius = 8,
    BoxFit fit = BoxFit.cover,
  }) {
    if (product.id == null) {
      return CirillaShimmer(
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
      );
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: ImageLoading(
        product.images.length > 0 ? product.images[0].shopCatalog : Assets.noImageUrl,
        width: width,
        height: height,
        fit: fit,
      ),
    );
  }

  Widget buildName(
    BuildContext context, {
    Product product,
    TextStyle style,
    double shimmerWidth = 140,
    double shimmerHeight = 16,
  }) {
    if (product.id == null) {
      return CirillaShimmer(
        child: Container(
          height: shimmerHeight,
          width: shimmerWidth,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(1),
          ),
        ),
      );
    }

    return Text(
      product.name,
      style: style,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  int getPercent(Product product) {
    int salePrice = ConvertData.stringToInt(product.salePrice);
    int regularPrice = ConvertData.stringToInt(product.regularPrice);
    if (salePrice > 0 && salePrice <= regularPrice) {
      return ConvertData.stringToInt(((regularPrice - salePrice) * 100) / regularPrice);
    }
    return 0;
  }

  Widget buildPrice(
    BuildContext context, {
    Product product,
    TextStyle priceStyle,
    TextStyle saleStyle,
    TextStyle regularStyle,
    TextStyle styleFrom,
    TextStyle stylePercentSale,
    bool enablePercentSale = false,
    Color colorPercentSale = const Color(0xFFF01F0E),
    double sizePercentSale = 19,
    double spacing = 4,
    double shimmerWidth = 50,
    double shimmerHeight = 12,
  }) {
    if (product.id == null) {
      return CirillaShimmer(
        child: Container(
          margin: EdgeInsets.only(top: 4),
          height: shimmerHeight,
          width: shimmerWidth,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(1),
          ),
        ),
      );
    }
    ThemeData theme = Theme.of(context);
    TextStyle stylePrice = priceStyle is TextStyle ? priceStyle : theme.textTheme.subtitle2;
    TextStyle styleSale =
        saleStyle is TextStyle ? saleStyle : theme.textTheme.subtitle2.copyWith(color: Color(0xFFF01F0E));
    TextStyle styleRegular = regularStyle is TextStyle ? regularStyle : theme.textTheme.subtitle2;
    TextStyle styleTextFrom = styleFrom is TextStyle ? styleFrom : theme.textTheme.caption;
    TextStyle stylePercent =
        stylePercentSale is TextStyle ? stylePercentSale : theme.textTheme.overline.copyWith(color: Colors.white);

    String price = product.regularPrice is String && product.regularPrice != ''
        ? product.regularPrice
        : product.price is String && product.price != ''
            ? product.price
            : '0';
    String sale = product.salePrice is String && product.salePrice != '' ? product.salePrice : '0';

    if (product.type == ProductType.variable || product.type == ProductType.grouped) {
      return RichText(
        text: TextSpan(
          text: 'From ',
          children: [TextSpan(text: formatCurrency(context, price: price), style: stylePrice)],
          style: styleTextFrom,
        ),
      );
    }
    if (product.onSale) {
      int percent = getPercent(product);
      return Wrap(
        spacing: spacing,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Text(
            formatCurrency(context, price: price),
            style: styleRegular.copyWith(decoration: TextDecoration.lineThrough),
          ),
          Text(
            formatCurrency(context, price: sale),
            style: styleSale,
          ),
          if (enablePercentSale)
            Badge(
              text: Text('-$percent%', style: stylePercent),
              size: sizePercentSale,
              color: colorPercentSale,
              padding: EdgeInsets.symmetric(horizontal: 8),
            )
        ],
      );
    }
    return Text(
      formatCurrency(context, price: price),
      style: stylePrice,
    );
  }

  Widget buildTagExtra(
    BuildContext context, {
    Product product,
    double shimmerWidth = 0,
    double shimmerHeight = 0,
    bool enableNew = true,
    Color newColor,
    Color newTextColor,
    double newRadius,
    bool enableSale = true,
    Color saleColor,
    Color saleTextColor,
    double saleRadius,
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

    TextStyle style = Theme.of(context).textTheme.overline.copyWith(color: Colors.white);

    List<Widget> children = [];

    if (enableNew && compareSpaceDate(date: product.date, space: spaceTimeNew)) {
      children.add(
        Badge(
          text: Text(
            'NEW',
            style: style.copyWith(color: newTextColor ?? Colors.white),
          ),
          color: newColor ?? Color(0xFF21BA45),
          padding: EdgeInsets.symmetric(horizontal: 8),
          radius: newRadius,
        ),
      );
    }

    if (enableSale && product.type == ProductType.simple && product.onSale) {
      String price = product.regularPrice is String && product.regularPrice != ''
          ? product.regularPrice
          : product.price is String && product.price != ''
              ? product.price
              : '0';
      String sale = product.salePrice is String && product.salePrice != '' ? product.salePrice : '0';

      double numberPrice = ConvertData.stringToDouble(price);
      double numberSale = ConvertData.stringToDouble(sale);
      double percent = ((numberPrice - numberSale) * 100) / numberPrice;

      children.add(
        Badge(
          text: Text(
            '-${percent.floor()}%',
            style: style.copyWith(color: saleTextColor ?? Colors.white),
          ),
          color: saleColor ?? Color(0xFFF01F0E),
          padding: EdgeInsets.symmetric(horizontal: 8),
          radius: saleRadius,
        ),
      );
    }

    return Wrap(
      spacing: 8,
      children: children,
    );
  }

  Widget buildRating(
    BuildContext context, {
    Product product,
    Color color,
    double shimmerWidth = 80,
    double shimmerHeight = 12,
    WrapAlignment wrapAlignment = WrapAlignment.start,
  }) {
    if (product.id == null) {
      return CirillaShimmer(
        child: Container(
            width: shimmerWidth,
            height: shimmerHeight,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(1),
            )),
      );
    }

    double rating = ConvertData.stringToDouble(product.averageRating ?? 0);

    return Wrap(
      spacing: 4,
      alignment: wrapAlignment,
      children: [
        CirillaRating(
          initialValue: rating,
          color: color ?? Theme.of(context).textTheme.overline.color,
        ),
        Text('(${product.ratingCount})', style: Theme.of(context).textTheme.overline.copyWith(color: color))
      ],
    );
  }

  Widget buildWishlist(
    BuildContext context, {
    Product product,
    bool isSelected = false,
    GestureTapCallback onTap,
    double shimmerWidth = 0,
    double shimmerHeight = 0,
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
    return InkWell(
      onTap: onTap,
      child: Icon(isSelected ? FontAwesomeIcons.solidHeart : FontAwesomeIcons.heart, size: 16),
    );
  }

  Widget buildAddCart(
    BuildContext context, {
    Product product,
    bool isRound = false,
    bool isButtonElevated = false,
    GestureTapCallback onTap,
    double shimmerWidth = 0,
    double shimmerHeight = 0,
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
    ThemeData theme = Theme.of(context);
    if (isButtonElevated) {
      return SizedBox(
        height: 34,
        child: DottedBorder(
          borderType: BorderType.RRect,
          radius: Radius.circular(8),
          padding: EdgeInsets.zero,
          color: theme.primaryColor,
          child: ElevatedButton(
            onPressed: onTap,
            child: Text('Add to Cart'),
            style: ElevatedButton.styleFrom(
              primary: theme.primaryColor.withOpacity(0.1),
              onPrimary: theme.primaryColor,
              elevation: 0,
              textStyle: theme.textTheme.caption,
            ),
          ),
        ),
      );
    }
    return CirillaButtonSocial(
      icon: FeatherIcons.plus,
      sizeIcon: 18,
      size: 34,
      wRadius: 8,
      type: isRound ? SocialType.circle : SocialType.square,
      color: theme.primaryColor,
      onPressed: onTap,
    );
  }

  Widget buildCategory(
    BuildContext context, {
    Product product,
    Color color,
    double shimmerWidth = 0,
    double shimmerHeight = 0,
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
    List<ProductCategory> categories = product?.categories ?? [];
    String name = categories.map((ProductCategory category) => category.name).toList().join(' | ');
    return Text(name, style: Theme.of(context).textTheme.caption.copyWith(color: color));
  }
}
