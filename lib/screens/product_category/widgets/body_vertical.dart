import 'package:cirilla/constants/constants.dart';
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

/// Vertical layout category
class VerticalCategory extends Body with LoadingMixin, Utility {
  const VerticalCategory({
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
    Color background =
        ConvertData.fromRGBA(get(widgetConfig.styles, ['backgroundItems', themeModeKey], {}), Colors.white);

    // Config style view
    String layoutView = get(widgetConfig.fields, ['styleView'], Strings.layoutCategoryList);
    int col = ConvertData.stringToInt(get(widgetConfig.fields, ['columnGrid'], 2), 2);
    double ratio = ConvertData.stringToDouble(get(widgetConfig.fields, ['childAspectRatio'], 1), 1);

    // Config item show all
    bool enableShowAll = get(widgetConfig.fields, ['enableShowAll'], true);
    bool enableChangeNameShowAll = get(widgetConfig.fields, ['enableChangeNameShowAll'], true);
    String positionShowAll = get(widgetConfig.fields, ['positionShowAll'], 'start');
    String textShowAll = ConvertData.textFromConfigs(get(widgetConfig.fields, ['textShowAll'], 'sss'), languageKey);

    double pad = ConvertData.stringToDouble(get(widgetConfig.fields, ['padItem'], 16));
    Map<String, dynamic> template =
        get(widgetConfig.fields, ['template'], {'template': Strings.productCategoryItemHorizontal, 'data': {}});

    return Scaffold(
      appBar: appBar,
      body: Container(
        child: Column(
          children: [
            banner,
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  tab,
                  Expanded(
                    child: Container(
                      height: double.infinity,
                      child: CustomScrollView(
                        physics: AlwaysScrollableScrollPhysics(),
                        slivers: [
                          SliverPadding(
                            padding: EdgeInsets.all(16),
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
                            // sliver: SliverToBoxAdapter(
                            //   child: Text('Vertical'),
                            // ),
                          ),
                        ],
                      ),
                      color: background,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
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
    Color background =
        ConvertData.fromRGBA(get(widgetConfig.styles, ['backgroundItems', themeModeKey], {}), Colors.white);

    return SizedBox(
      width: tabVerticalWidth,
      height: double.infinity,
      child: RotatedBox(
        quarterTurns: 1,
        child: TabBar(
          onTap: onChanged,
          labelPadding: EdgeInsets.zero,
          indicatorWeight: 0,
          isScrollable: true,
          labelColor: theme.primaryColor,
          controller: tabController,
          labelStyle: theme.textTheme.bodyText1,
          unselectedLabelColor: theme.textTheme.bodyText1.color,
          indicator: BoxDecoration(
            color: background,
            border: Border(bottom: BorderSide(width: 4, color: Theme.of(context).primaryColor)),
          ),
          tabs: List.generate(
            categories.length,
            (inx) => RotatedBox(
              quarterTurns: 3,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                child: Text(
                  categories[inx].name,
                ),
              ),
            ),
          ).toList(),
        ),
      ),
    );
  }

  // Build Layout App bar
  @override
  Widget buildAppBar(BuildContext context, {Map<String, dynamic> configs}) {
    // String type = get(configs, ['appBarType'], Strings.appbarFloating);
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
    return AppBar(
      elevation: 0,
      primary: true,
      automaticallyImplyLeading: false,
      centerTitle: false,
      title: title,
      actions: actions,
      titleSpacing: 20,
      bottom: PreferredSize(
        child: Container(),
        preferredSize: Size.fromHeight(16),
      ),
    );
  }

  // Build Banner
  @override
  Widget buildBanner(BuildContext context, {Map<String, dynamic> configs, String languageKey}) {
    bool enableBanner = get(configs, ['enableBanner'], true);

    if (!enableBanner) {
      return null;
    }
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20, bottom: 16),
      child: BannerWidget(configs: configs, languageKey: languageKey),
    );
  }
}
