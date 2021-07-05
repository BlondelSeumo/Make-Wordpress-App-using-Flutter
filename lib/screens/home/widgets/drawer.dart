import 'package:cirilla/constants/assets.dart';
import 'package:cirilla/constants/constants.dart';
import 'package:cirilla/mixins/mixins.dart';
import 'package:cirilla/models/product_category/product_category.dart';
import 'package:cirilla/models/setting/setting.dart';
import 'package:cirilla/store/setting/setting_store.dart';
import 'package:cirilla/utils/convert_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'drawer_categories.dart';
import 'drawer_header.dart';
import 'drawer_help_info.dart';

class Sidebar extends StatelessWidget with CategoryMixin, Utility {
  final Data data;
  final List<ProductCategory> categories;

  const Sidebar({
    Key key,
    this.data,
    this.categories,
  }) : super(key: key);

  List<ProductCategory> showHierarchy({List<ProductCategory> categories, hierarchy = true}) {
    if (hierarchy) return categories;
    return flatten(categories: categories);
  }

  @override
  Widget build(BuildContext context) {
    WidgetConfig widgetConfig = data.widgets['sidebar'];
    bool enableImageBg = get(widgetConfig.styles, ['enableImageBg'], true);
    String imageBg = get(widgetConfig.styles, ['imageBg', 'src'], Assets.noImageUrl);
    String style9 = get(widgetConfig.layout, [], 'default');

    List<int> excludeCategory = get(widgetConfig.fields, ['excludeCategory'], [])
        .map((e) => ConvertData.stringToInt(e['key']))
        .toList()
        .cast<int>();

    List<int> includeCategory = get(widgetConfig.fields, ['includeCategory'], [])
        .map((e) => ConvertData.stringToInt(e['key']))
        .toList()
        .cast<int>();

    int maxDepth = get(widgetConfig.fields, ['depth'], 3);

    bool hierarchy = get(widgetConfig.fields, ['showHierarchy'], true);

    Color color = ConvertData.fromRGBA(
      get(widgetConfig.styles, ['color', Provider.of<SettingStore>(context).themeModeKey]),
      Theme.of(context).textTheme.bodyText1.color,
    );

    Color background = ConvertData.fromRGBA(
      get(widgetConfig.styles, ['background', Provider.of<SettingStore>(context).themeModeKey]),
      Theme.of(context).canvasColor,
    );

    Color borderColor = ConvertData.fromRGBA(
      get(widgetConfig.styles, ['borderColor', Provider.of<SettingStore>(context).themeModeKey]),
      Theme.of(context).dividerColor,
    );

    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: background,
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: color,
              displayColor: color,
              decorationColor: color,
            ),
        iconTheme: Theme.of(context).iconTheme.copyWith(
              color: color,
            ),
        dividerColor: borderColor,
      ),
      child: Stack(
        children: [
          Container(
            color: enableImageBg == true ? Colors.black : background,
            child: enableImageBg == true
                ? Opacity(
                    opacity: 0.6,
                    child: Image.network(
                      '$imageBg',
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,
                    ))
                : null,
          ),
          Container(
            padding: EdgeInsetsDirectional.only(
              start: itemPadding * 3,
              end: itemPadding * 3,
              bottom: itemPadding * 3,
              top: itemPadding * 3,
            ),
            width: style9 == 'style9' ? MediaQuery.of(context).size.width : MediaQuery.of(context).size.width * 0.75,
            child: ListView(
              children: [
                if (widgetConfig.fields['enableHeaderSidebar'] == true)
                  Header(
                    data: data,
                  ),
                if (widgetConfig.fields['enableCategory'] == true)
                  Categories(
                    categories: depth(
                      categories: exclude(
                        categories: include(
                          categories: showHierarchy(
                            hierarchy: hierarchy,
                            categories: categories,
                          ),
                          includes: includeCategory,
                        ),
                        excludes: excludeCategory,
                      ),
                      maxDepth: maxDepth,
                    ),
                    data: data,
                  ),
                if (widgetConfig.fields['enableCustomize'] == true)
                  DrawerHelpInfo(
                    data: data,
                  ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
