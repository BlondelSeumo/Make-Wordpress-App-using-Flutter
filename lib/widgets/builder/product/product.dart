import 'package:cirilla/constants/strings.dart';
import 'package:cirilla/mixins/mixins.dart';
import 'package:cirilla/models/models.dart';
import 'package:cirilla/screens/screens.dart';
import 'package:cirilla/store/store.dart';
import 'package:cirilla/utils/utils.dart';
import 'package:cirilla/widgets/cirilla_product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import 'layout/layout_list.dart';
import 'layout/layout_carousel.dart';
import 'layout/layout_masonry.dart';
import 'layout/layout_slideshow.dart';
import 'layout/layout_big_first.dart';
import 'layout/layout_grid.dart';

class ProductWidget extends StatelessWidget {
  final Map<String, dynamic> fields;
  final Map<String, dynamic> styles;
  final String layout;
  final ProductsStore productsStore;
  final EdgeInsetsDirectional padding;

  ProductWidget({
    Key key,
    this.styles = const {},
    this.fields = const {},
    this.layout,
    this.productsStore,
    this.padding = EdgeInsetsDirectional.zero,
  }) : super(key: key);

  void goDetail(BuildContext context, Product product) {
    Navigator.pushNamed(context, ProductScreen.routeName, arguments: {'product': product});
  }

  @override
  Widget build(BuildContext context) {
    SettingStore settingStore = Provider.of<SettingStore>(context);

    return Observer(builder: (_) {
      if (productsStore == null) return Container();

      String themeModeKey = settingStore?.themeModeKey ?? 'value';

      bool loading = productsStore.loading;
      List<Product> products = productsStore.products;

      // Style
      var height = get(styles, ['height'], '');

      // general config
      int limit = ConvertData.stringToInt(get(fields, ['limit'], 4));
      List<Product> emptyProducts = List.generate(limit, (index) => Product()).toList();

      return Container(
        height: height == "" || layout != Strings.productLayoutCarousel ? null : ConvertData.stringToDouble(height),
        child: LayoutProductList(
          fields: fields,
          styles: styles,
          products: loading ? emptyProducts : products,
          layout: layout,
          padding: padding,
          themeModeKey: themeModeKey,
        ),
      );
    });
  }
}

class LayoutProductList extends StatelessWidget {
  final Map<String, dynamic> fields;
  final Map<String, dynamic> styles;
  final List<Product> products;
  final String layout;
  final EdgeInsetsDirectional padding;
  final String themeModeKey;

  LayoutProductList({
    Key key,
    this.fields = const {},
    this.styles = const {},
    this.products,
    this.layout = Strings.productLayoutList,
    this.padding = EdgeInsetsDirectional.zero,
    this.themeModeKey = 'value',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, BoxConstraints constraints) {
      double widthView = constraints.maxWidth;
      return buildLayout(context, widthView);
    });
  }

  Widget buildLayout(BuildContext context, [double widthView = 300]) {
    // General config
    Map<String, dynamic> templateItem = get(fields, ['template'], {});
    double width = ConvertData.stringToDouble(get(templateItem, ['data', 'size', 'width'], 100));
    double height = ConvertData.stringToDouble(get(templateItem, ['data', 'size', 'height'], 100));
    int column = ConvertData.stringToInt(get(styles, ['col'], 2), 2);
    double ratio = ConvertData.stringToDouble(get(styles, ['ratio'], 1), 1);

    // Styles config
    double pad = ConvertData.stringToDouble(get(styles, ['pad'], 0));
    double dividerHeight = ConvertData.stringToDouble(get(styles, ['dividerWidth'], 1));
    Color dividerColor = ConvertData.fromRGBA(get(styles, ['dividerColor', themeModeKey], {}), Colors.transparent);
    Color indicatorColor = ConvertData.fromRGBA(
      get(styles, ['indicatorColor', themeModeKey], {}),
      Theme.of(context).dividerColor,
    );
    Color indicatorActiveColor = ConvertData.fromRGBA(
      get(styles, ['indicatorActiveColor', themeModeKey], {}),
      Theme.of(context).primaryColor,
    );

    switch (layout) {
      case Strings.productLayoutCarousel:
        return LayoutCarousel(
          products: products,
          buildItem: _buildItem,
          pad: pad,
          dividerColor: dividerColor,
          dividerHeight: dividerHeight,
          padding: padding,
          width: width,
          height: height,
        );
        break;
      case Strings.productLayoutMasonry:
        return LayoutMasonry(
          products: products,
          buildItem: _buildItem,
          pad: pad,
          dividerColor: dividerColor,
          dividerHeight: dividerHeight,
          padding: padding,
          width: width,
          height: height,
          widthView: widthView,
        );
        break;
      case Strings.productLayoutBigFirst:
        return LayoutBigFirst(
          products: products,
          buildItem: _buildItem,
          pad: pad,
          dividerColor: dividerColor,
          dividerHeight: dividerHeight,
          template: templateItem,
          padding: padding,
          widthView: widthView,
        );
        break;
      case Strings.productLayoutSlideshow:
        return LayoutSlideshow(
          products: products,
          buildItem: _buildItem,
          width: width,
          height: height,
          padding: padding,
          indicatorColor: indicatorColor,
          indicatorActiveColor: indicatorActiveColor,
          widthView: widthView,
        );
        break;
      case Strings.productLayoutGrid:
        return LayoutGrid(
          products: products,
          buildItem: _buildItem,
          width: width,
          height: height,
          padding: padding,
          column: column,
          ratio: ratio,
          pad: pad,
          widthView: widthView,
          dividerHeight: dividerHeight,
          dividerColor: dividerColor,
        );
        break;
      default:
        return LayoutList(
          products: products,
          buildItem: _buildItem,
          pad: pad,
          dividerColor: dividerColor,
          dividerHeight: dividerHeight,
          padding: padding,
          width: width,
          height: height,
          widthView: widthView,
        );
    }
  }

  Widget _buildItem(
    BuildContext context, {
    Product product,
    double width = 100,
    double height = 100,
  }) {
    ThemeData theme = Theme.of(context);
    // Template
    String template = get(fields, ['template', 'template'], Strings.productItemContained);
    Map<String, dynamic> dataTemplate = get(fields, ['template', 'data'], {});

    Color backgroundColor =
        ConvertData.fromRGBA(get(styles, ['backgroundColorItem', themeModeKey], {}), theme.cardColor);
    Color textColor =
        ConvertData.fromRGBA(get(styles, ['textColor', themeModeKey], {}), theme.textTheme.subtitle1.color);
    Color subTextColor =
        ConvertData.fromRGBA(get(styles, ['subTextColor', themeModeKey], {}), theme.textTheme.caption.color);
    Color priceColor =
        ConvertData.fromRGBA(get(styles, ['priceColor', themeModeKey], {}), theme.textTheme.subtitle1.color);
    Color salePriceColor = ConvertData.fromRGBA(get(styles, ['salePriceColor', themeModeKey], {}), Color(0xFFF01F0E));
    Color regularPriceColor =
        ConvertData.fromRGBA(get(styles, ['regularPriceColor', themeModeKey], {}), theme.textTheme.caption.color);

    Color labelNewColor = ConvertData.fromRGBA(get(styles, ['labelNewColor', themeModeKey], {}), Color(0xFF21BA45));
    Color labelNewTextColor = ConvertData.fromRGBA(get(styles, ['labelNewTextColor', themeModeKey], {}), Colors.white);
    double radiusLabelNew = ConvertData.stringToDouble(get(styles, ['radiusLabelNew'], 10));
    Color labelSaleColor = ConvertData.fromRGBA(get(styles, ['labelSaleColor', themeModeKey], {}), Color(0xFFF01F0E));
    Color labelSaleTextColor =
        ConvertData.fromRGBA(get(styles, ['labelSaleTextColor', themeModeKey], {}), Colors.white);
    double radiusLabelSale = ConvertData.stringToDouble(get(styles, ['radiusLabelSale'], 10));

    double radius = ConvertData.stringToDouble(get(styles, ['radius'], 0));
    double radiusImage = ConvertData.stringToDouble(get(styles, ['radiusImage'], 8));

    Color shadowColor = ConvertData.fromRGBA(get(styles, ['shadowColor', themeModeKey], {}), Colors.transparent);
    double offsetX = ConvertData.stringToDouble(get(styles, ['offsetX'], 0));
    double offsetY = ConvertData.stringToDouble(get(styles, ['offsetY'], 4));
    double blurRadius = ConvertData.stringToDouble(get(styles, ['blurRadius'], 24));
    double spreadRadius = ConvertData.stringToDouble(get(styles, ['spreadRadius'], 0));

    BoxShadow shadow = BoxShadow(
      color: shadowColor,
      offset: Offset(offsetX, offsetY),
      blurRadius: blurRadius,
      spreadRadius: spreadRadius,
    );

    return CirillaProductItem(
      product: product,
      width: width,
      height: height,
      template: template,
      dataTemplate: dataTemplate,
      background: backgroundColor,
      textColor: textColor,
      subTextColor: subTextColor,
      priceColor: priceColor,
      salePriceColor: salePriceColor,
      regularPriceColor: regularPriceColor,
      labelNewColor: labelNewColor,
      labelNewTextColor: labelNewTextColor,
      labelNewRadius: radiusLabelNew,
      labelSaleColor: labelSaleColor,
      labelSaleTextColor: labelSaleTextColor,
      labelSaleRadius: radiusLabelSale,
      radius: radius,
      radiusImage: radiusImage,
      boxShadow: [shadow],
    );
  }
}
