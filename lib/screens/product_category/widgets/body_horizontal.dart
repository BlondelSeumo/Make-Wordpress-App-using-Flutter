import 'package:cirilla/constants/strings.dart';
import 'package:cirilla/mixins/mixins.dart';
import 'package:cirilla/models/product_category/product_category.dart';
import 'package:cirilla/models/setting/setting.dart';
import 'package:cirilla/utils/convert_data.dart';
import 'package:cirilla/widgets/widgets.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

import 'body.dart';
import 'list_category_scroll_load_more.dart';

/// Horizontal layout Category
///
class HorizontalCategory extends Body with LoadingMixin, Utility {
  const HorizontalCategory({
    Key key,
    List<ProductCategory> categories,
    WidgetConfig widgetConfig,
    Map<String, dynamic> configs,
    String themeModeKey,
    String languageKey,
  }) : super(
          key: key,
          categories: categories,
          widgetConfig: widgetConfig,
          configs: configs,
          languageKey: languageKey,
          themeModeKey: themeModeKey,
        );

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
  Widget buildBody(
    BuildContext context, {
    Widget appBar,
    Widget tab,
    ProductCategory parent,
    Widget banner,
    WidgetConfig widgetConfig,
    String languageKey,
    String themeModeKey,
  }) {
    // Config style view
    String layoutView = get(widgetConfig.fields, ['styleView'], Strings.layoutCategoryList);
    int col = ConvertData.stringToInt(get(widgetConfig.fields, ['columnGrid'], 2), 2);
    double ratio = ConvertData.stringToDouble(get(widgetConfig.fields, ['childAspectRatio'], 1), 1);

    // Config item show all
    bool enableShowAll = get(widgetConfig.fields, ['enableShowAll'], true);
    bool enableChangeNameShowAll = get(widgetConfig.fields, ['enableChangeNameShowAll'], true);
    String positionShowAll = get(widgetConfig.fields, ['positionShowAll'], 'start');
    String textShowAll = ConvertData.textFromConfigs(get(widgetConfig.fields, ['textShowAll'], ''), languageKey);

    double pad = ConvertData.stringToDouble(get(widgetConfig.fields, ['padItem'], 16));

    Map<String, dynamic> template =
        get(widgetConfig.fields, ['template'], {'template': Strings.productCategoryItemHorizontal, 'data': {}});

    return CustomScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      slivers: [
        if (appBar != null) appBar,
        if (banner != null) banner,
        SliverPadding(
          padding: EdgeInsets.only(bottom: 24),
          sliver: SliverPersistentHeader(
            pinned: true,
            floating: false,
            delegate: StickyTabBarDelegate(
              height: 33,
              child: tab,
            ),
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          sliver: ListCategoryScrollLoadMore(
            categories: getListItem(parent, enableShowAll, positionShowAll),
            layout: layoutView,
            col: col,
            ratio: ratio,
            enableTextShowAll: enableChangeNameShowAll,
            textShowAll: textShowAll,
            idShowAll: parent.id,
            template: template,
            styles: widgetConfig?.styles ?? {},
            pad: pad,
            themeModeKey: themeModeKey,
          ),
        ),
      ],
    );
  }

  @override
  Widget buildTabs(
    BuildContext context, {
    TabController tabController,
    List<ProductCategory> categories,
    Function onChanged,
    WidgetConfig widgetConfig,
  }) {
    ThemeData theme = Theme.of(context);
    return Container(
      color: theme.scaffoldBackgroundColor,
      margin: EdgeInsets.only(left: 20, right: 4),
      transform: Matrix4.translationValues(-16, 0, 0.0),
      child: TabBar(
        labelPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
        onTap: onChanged,
        isScrollable: true,
        labelColor: theme.primaryColor,
        controller: tabController,
        labelStyle: theme.textTheme.subtitle2,
        unselectedLabelColor: theme.textTheme.subtitle2.color,
        indicatorWeight: 2,
        indicatorColor: theme.primaryColor,
        indicatorPadding: EdgeInsets.symmetric(horizontal: 16),
        tabs: List.generate(
          categories.length,
          (inx) => Container(
            height: 33,
            alignment: Alignment.center,
            child: Text(
              categories[inx].name.toUpperCase(),
            ),
          ),
        ).toList(),
      ),
    );
  }

  // Build Layout App bar
  @override
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
      titleSpacing: 20,
    );
  }

  // Build Banner
  @override
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
