import 'package:cirilla/mixins/mixins.dart';
import 'package:cirilla/models/models.dart';
import 'package:cirilla/models/setting/setting.dart';
import 'package:cirilla/store/store.dart';
import 'package:cirilla/utils/convert_data.dart';
import 'package:cirilla/constants/strings.dart';
import 'package:cirilla/widgets/cirilla_product_category_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import 'layout/layout_list.dart';
import 'layout/layout_carousel.dart';
import 'layout/layout_grid.dart';
import 'layout/layout_big_first.dart';
import 'layout/layout_masonry.dart';
import 'layout/layout_slideshow.dart';

class ProductCategoryWidget extends StatefulWidget {
  final WidgetConfig widgetConfig;

  ProductCategoryWidget({
    Key key,
    this.widgetConfig,
  }) : super(key: key);

  @override
  _ProductCategoryWidgetState createState() => _ProductCategoryWidgetState();
}

class _ProductCategoryWidgetState extends State<ProductCategoryWidget> with CategoryMixin, Utility {
  SettingStore _settingStore;
  ProductCategoryStore _productCategoryStore;

  @override
  void didChangeDependencies() {
    _settingStore = Provider.of<SettingStore>(context);
    _productCategoryStore = Provider.of<ProductCategoryStore>(context);

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    String themeModeKey = _settingStore?.themeModeKey ?? 'value';
    // Layout
    String layout = widget?.widgetConfig?.layout ?? Strings.productCategoryLayoutList;

    // Styles
    Map<String, dynamic> styles = widget?.widgetConfig?.styles ?? {};
    Map margin = get(styles, ['margin'], {});
    Map padding = get(styles, ['padding'], {});
    Color background = ConvertData.fromRGBA(get(styles, ['background', themeModeKey], {}), Colors.transparent);
    double pad = ConvertData.stringToDouble(get(styles, ['pad'], 16));
    double height = ConvertData.stringToDouble(get(styles, ['height'], 200));

    // Styles
    Map<String, dynamic> fields = widget?.widgetConfig?.fields ?? {};
    int limit = ConvertData.stringToInt(get(fields, ['limit'], 4));
    List<int> excludeCategory =
        get(fields, ['excludeCategory'], []).map((e) => ConvertData.stringToInt(e['key'])).toList().cast<int>();

    List<int> includeCategory =
        get(fields, ['includeCategory'], []).map((e) => ConvertData.stringToInt(e['key'])).toList().cast<int>();
    bool showHierarchy = get(fields, ['showHierarchy'], true);
    Map<String, dynamic> template = get(fields, ['template'], {});

    return Observer(
      builder: (_) {
        List<ProductCategory> categoriesList = exclude(
          categories: include(
            categories: showHierarchy
                ? _productCategoryStore.categories
                : flatten(categories: _productCategoryStore.categories),
            includes: includeCategory,
          ),
          excludes: excludeCategory,
        );
        int categoriesLength = categoriesList.length < limit ? categoriesList.length : limit;
        List<ProductCategory> categories = categoriesList.sublist(0, categoriesLength);

        return Container(
          margin: ConvertData.space(margin, 'margin'),
          color: background,
          height: layout == Strings.productCategoryLayoutCarousel ? height : null,
          child: LayoutBuilder(
            builder: (_, BoxConstraints constraints) {
              double widthView = constraints.maxWidth;
              return buildLayout(
                layout,
                categories: categories,
                pad: pad,
                styles: styles,
                template: template,
                themeModeKey: themeModeKey,
                padding: ConvertData.space(padding, 'padding'),
                widthView: widthView,
              );
            },
          ),
        );
      },
    );
  }

  Widget buildLayout(
    String layout, {
    List<ProductCategory> categories,
    double pad,
    Map<String, dynamic> styles,
    Map<String, dynamic> template,
    String themeModeKey,
    EdgeInsetsDirectional padding,
    double widthView: 300,
  }) {
    switch (layout) {
      case Strings.productCategoryLayoutCarousel:
        return LayoutCarousel(
          categories: categories,
          buildItem: (_, {ProductCategory category, double width, double height}) {
            return buildItem(category: category, template: template, styles: styles, width: width, height: height);
          },
          pad: pad,
          padding: padding,
        );
      case Strings.productCategoryLayoutGrid:
        int column = ConvertData.stringToInt(get(styles, ['col'], 2), 2);
        double ratio = ConvertData.stringToDouble(get(styles, ['ratio'], 1), 1);
        return LayoutGrid(
          categories: categories,
          buildItem: (_, {ProductCategory category, double width, double height}) {
            return buildItem(category: category, template: template, styles: styles, width: width, height: height);
          },
          column: column,
          ratio: ratio,
          pad: pad,
          padding: padding,
          widthView: widthView,
        );
      case Strings.productCategoryLayoutBigFirst:
        return LayoutBigFirst(
          categories: categories,
          buildItem: (_, {ProductCategory category, double width, double height}) {
            return buildItem(category: category, template: template, styles: styles, width: width, height: height);
          },
          pad: pad,
          template: template,
          padding: padding,
          widthView: widthView,
        );
      case Strings.productCategoryLayoutMasonry:
        return LayoutMasonry(
          categories: categories,
          buildItem: (_, {ProductCategory category, double width, double height}) {
            return buildItem(category: category, template: template, styles: styles, width: width, height: height);
          },
          pad: pad,
          padding: padding,
          widthView: widthView,
        );
      case Strings.productCategoryLayoutSlideshow:
        Color indicatorColor = ConvertData.fromRGBA(
          get(styles, ['indicatorColor', themeModeKey], {}),
          Theme.of(context).dividerColor,
        );
        Color indicatorActiveColor = ConvertData.fromRGBA(
          get(styles, ['indicatorActiveColor', themeModeKey], {}),
          Theme.of(context).primaryColor,
        );
        return LayoutSlideshow(
          categories: categories,
          buildItem: (_, {ProductCategory category, double width, double height}) {
            return buildItem(category: category, template: template, styles: styles, width: width, height: height);
          },
          indicatorColor: indicatorColor,
          indicatorActiveColor: indicatorActiveColor,
          padding: padding,
          widthView: widthView,
        );
      default:
        return LayoutList(
          categories: categories,
          buildItem: (_, {ProductCategory category, double width, double height}) {
            return buildItem(category: category, template: template, styles: styles, width: width, height: height);
          },
          pad: pad,
          padding: padding,
          widthView: widthView,
        );
    }
  }

  Widget buildItem({
    ProductCategory category,
    Map<String, dynamic> template,
    Map<String, dynamic> styles,
    double width,
    double height,
  }) {
    String themeModeKey = _settingStore?.themeModeKey ?? 'value';

    Color background = ConvertData.fromRGBA(get(styles, ['backgroundItem', themeModeKey], {}), Colors.transparent);
    Color textColor = ConvertData.fromRGBA(get(styles, ['textColor', themeModeKey], {}), Colors.black);
    Color subTextColor = ConvertData.fromRGBA(get(styles, ['subTextColor', themeModeKey], {}), Colors.black);
    double radius = ConvertData.stringToDouble(get(styles, ['radius'], 0));
    double radiusImage = ConvertData.stringToDouble(get(styles, ['radiusImage'], 0));

    return CirillaProductCategoryItem(
      category: category,
      template: template,
      background: background,
      textColor: textColor,
      subTextColor: subTextColor,
      radius: radius,
      radiusImage: radiusImage,
      width: width,
      height: height,
    );
  }
}
