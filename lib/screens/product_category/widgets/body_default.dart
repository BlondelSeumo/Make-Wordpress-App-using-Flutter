import 'package:cirilla/constants/strings.dart';
import 'package:cirilla/mixins/mixins.dart';
import 'package:cirilla/models/product_category/product_category.dart';
import 'package:cirilla/models/setting/setting.dart';
import 'package:cirilla/utils/convert_data.dart';
import 'package:cirilla/widgets/widgets.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'body.dart';
import 'list_category_scroll_load_more.dart';

/// Default layout Category
///
class DefaultCategory extends StatelessWidget with LoadingMixin, Utility {
  // List top categories (parent = 0)
  final List<ProductCategory> categories;

  // setting page category list
  final WidgetConfig widgetConfig;

  // Config style category list
  final Map<String, dynamic> configs;

  // Key set language
  final String languageKey;

  // Key set theme darkmode
  final String themeModeKey;

  DefaultCategory({
    Key key,
    this.categories,
    this.widgetConfig,
    this.configs,
    this.themeModeKey,
    this.languageKey,
  }) : super(key: key);

  List<ProductCategory> getListItem(ProductCategory parent, enableShowAll, positionShowAll) {
    if (enableShowAll) {
      if (positionShowAll == 'start') {
        return [parent]..addAll([...parent.categories]);
      } else {
        return [...parent.categories]..addAll([parent]);
      }
    }
    return parent.categories;
  }

  @override
  Widget build(BuildContext context) {
    String layoutView = get(widgetConfig.fields, ['styleView'], Strings.layoutCategoryList);
    int col = ConvertData.stringToInt(get(widgetConfig.fields, ['columnGrid'], 2), 2);
    double ratio = ConvertData.stringToDouble(get(widgetConfig.fields, ['childAspectRatio'], 1), 1);

    // Config item show all
    // bool enableShowAll = get(widgetConfig.fields, ['enableShowAll'], true);
    // bool enableChangeNameShowAll = get(widgetConfig.fields, ['enableChangeNameShowAll'], true);
    // String positionShowAll = get(widgetConfig.fields, ['positionShowAll'], 'start');
    String textShowAll = ConvertData.textFromConfigs(get(widgetConfig.fields, ['textShowAll'], ''), languageKey);

    double pad = ConvertData.stringToDouble(get(widgetConfig.fields, ['padItem'], 16));

    Map<String, dynamic> template =
        get(widgetConfig.fields, ['template'], {'template': Strings.productCategoryItemHorizontal, 'data': {}});

    Widget appBar = buildAppBar(context, configs: configs);
    Widget banner = buildBanner(context, configs: configs, languageKey: languageKey);

    return CustomScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      slivers: [
        if (appBar != null) appBar,
        if (banner != null) banner,
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          sliver: ListCategoryScrollLoadMore(
            // categories: getListItem(parent, enableShowAll, positionShowAll),
            categories: categories,
            layout: layoutView,
            col: col,
            ratio: ratio,
            enableTextShowAll: false,
            textShowAll: textShowAll,
            idShowAll: -1,
            template: template,
            styles: widgetConfig?.styles ?? {},
            pad: pad,
            themeModeKey: themeModeKey,
          ),
        ),
      ],
    );
  }

  // Build Layout App bar
  Widget buildAppBar(BuildContext context, {Map<String, dynamic> configs}) {
    String type = get(configs, ['appBarType'], Strings.appbarFloating);
    bool enableSearch = get(configs, ['enableSearch'], true);
    bool enableCart = get(configs, ['enableCart'], true);

    if (!enableSearch && !enableCart) {
      return null;
    }

    // ==== Title
    Widget title = enableSearch ? SearchProductWidget() : null;

    // ==== Actions
    List<Widget> actions = [
      if (enableCart)
        Padding(
          padding: EdgeInsetsDirectional.only(end: 17),
          child: CirillaCartIcon(
            icon: Icon(FeatherIcons.shoppingCart),
            enableCount: true,
            color: Colors.transparent,
          ),
        ),
    ];
    return SliverAppBar(
      floating: type == Strings.appbarFloating,
      elevation: 0,
      primary: true,
      pinned: true,
      automaticallyImplyLeading: false,
      centerTitle: false,
      title: title,
      actions: actions,
      expandedHeight: 73,
      leadingWidth: 0,
      titleSpacing: 20,
    );
  }

  // Build Banner
  Widget buildBanner(BuildContext context, {Map<String, dynamic> configs, String languageKey}) {
    bool enableBanner = get(configs, ['enableBanner'], true);

    if (!enableBanner) {
      return null;
    }
    return SliverPadding(
      padding: EdgeInsets.only(left: 20, right: 20, bottom: 16),
      sliver: SliverToBoxAdapter(
        child: BannerWidget(configs: configs, languageKey: languageKey),
      ),
    );
  }
}
