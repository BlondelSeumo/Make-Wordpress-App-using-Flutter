import 'package:cirilla/constants/constants.dart';
import 'package:cirilla/mixins/mixins.dart';
import 'package:cirilla/models/setting/setting.dart';
import 'package:cirilla/store/store.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ui/product_category/product_category_text_center_item.dart';
import 'package:ui/product_category/product_category_text_left_item.dart';
import 'package:ui/product_category/product_category_text_right_item.dart';

class DrawerHelpInfo extends StatelessWidget with Utility, NavigationMixin {
  final Data data;

  const DrawerHelpInfo({
    Key key,
    this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SettingStore settingStore = Provider.of<SettingStore>(context);
    String languageKey = settingStore.languageKey;

    WidgetConfig sidebarData = data.widgets['sidebar'];

    final itemsCustom = sidebarData.fields['itemsCustomize'];
    final headerSideBar = get(sidebarData.fields, ['titleCustomize', languageKey], '');

    String alignCustomize = get(sidebarData.fields, ['alignCustomize'], 'left');

    bool enableIconCustomize = get(sidebarData.fields, ['enableIconCustomize'], true);

    return Column(
        crossAxisAlignment: alignCustomize == 'center'
            ? CrossAxisAlignment.center
            : alignCustomize == 'left'
                ? CrossAxisAlignment.start
                : CrossAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
              bottom: itemPadding,
            ),
            child: Text(
              headerSideBar,
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          ...List.generate(itemsCustom.length, (index) {
            Map<String, dynamic> itemsData = itemsCustom.elementAt(index)['data'];

            String titles = get(itemsData, ['title', 'text'], '');

            Map<String, dynamic> action = get(itemsData, ['action'], {});

            String icons = get(itemsData, ['icon', 'name'], '');

            return Material(
                color: Colors.transparent,
                child: Column(
                  children: [
                    alignCustomize == 'left'
                        ? ProductCategoryTextLeftItem(
                            onTap: () => navigate(context, action),
                            name: Text(
                              titles,
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            image: enableIconCustomize == true ? buildIcon(icons: icons) : null,
                          )
                        : alignCustomize == 'right'
                            ? ProductCategoryTextRightItem(
                                onTap: () => navigate(context, action),
                                name: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    titles,
                                    style: Theme.of(context).textTheme.subtitle2,
                                  ),
                                ),
                                image: enableIconCustomize == true ? buildIcon(icons: icons) : null,
                              )
                            : ProductCategoryTextCenterItem(
                                onTap: () => navigate(context, action),
                                name: Text(
                                  titles,
                                  style: Theme.of(context).textTheme.subtitle2,
                                ),
                                image: enableIconCustomize == true ? buildIcon(icons: icons) : null,
                              ),
                  ],
                ));
          })
        ]);
  }

  Widget buildIcon({String icons}) {
    return Icon(
      FeatherIconsMap[icons],
      size: 14,
    );
  }
}
