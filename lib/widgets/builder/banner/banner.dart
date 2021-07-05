import 'package:cirilla/constants/strings.dart';
import 'package:cirilla/utils/utils.dart';
import 'package:cirilla/mixins/mixins.dart';
import 'package:cirilla/models/models.dart';
import 'package:cirilla/store/store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'layout/layout_list.dart';
import 'layout/layout_carousel.dart';
import 'layout/layout_masonry.dart';
import 'layout/layout_slideshow.dart';
import 'layout/layout_grid.dart';
import 'layout/layout_multi.dart';

import 'template/default.dart';
import 'template/style1.dart';
import 'template/style2.dart';
import 'template/style3.dart';
import 'template/style4.dart';
import 'template/style5.dart';
import 'template/style6.dart';
import 'template/style7.dart';
import 'template/style8.dart';
import 'template/style9.dart';

class BannerWidget extends StatelessWidget with Utility, NavigationMixin {
  final WidgetConfig widgetConfig;

  BannerWidget({
    Key key,
    @required this.widgetConfig,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SettingStore settingStore = Provider.of<SettingStore>(context);
    String themeModeKey = settingStore?.themeModeKey ?? 'value';
    String language = settingStore?.locale ?? 'en';

    // Layout
    String layout = widgetConfig?.layout ?? Strings.bannerLayoutList;

    // Styles
    Map<String, dynamic> styles = widgetConfig?.styles ?? {};
    Map margin = get(styles, ['margin'], {});
    Color background = ConvertData.fromRGBA(get(styles, ['background', themeModeKey], {}), Colors.transparent);
    String backgroundImage = ConvertData.imageFromConfigs(get(styles, ['backgroundImage'], ''), language);
    double height = ConvertData.stringToDouble(get(styles, ['height'], 300));

    // General config
    Map<String, dynamic> fields = widgetConfig?.fields ?? {};
    List items = get(fields, ['items'], []);
    Size size = ConvertData.toSize(get(fields, ['size'], {'width': '375', 'height': '330'}));

    return Container(
      margin: ConvertData.space(margin, 'margin'),
      height: layout == Strings.bannerLayoutCarousel ? height : null,
      decoration: BoxDecoration(
        color: background,
        image: backgroundImage is String && backgroundImage != ''
            ? DecorationImage(image: NetworkImage(backgroundImage), fit: BoxFit.cover)
            : null,
      ),
      child: buildLayout(
        context,
        layout: layout,
        items: items,
        styles: styles,
        size: size,
        themeModeKey: themeModeKey,
      ),
    );
  }

  Widget buildLayout(
    BuildContext context, {
    String layout,
    List items,
    Size size,
    Map<String, dynamic> styles,
    String themeModeKey,
  }) {
    EdgeInsetsDirectional padding = ConvertData.space(get(styles, ['padding'], {}), 'padding');
    double pad = ConvertData.stringToDouble(get(styles, ['pad'], 12));
    Color backgroundItem =
        ConvertData.fromRGBA(get(styles, ['backgroundColorItem', themeModeKey], {}), Colors.transparent);
    double radius = ConvertData.stringToDouble(get(styles, ['radius'], 0));

    switch (layout) {
      case Strings.bannerLayoutCarousel:
        return LayoutCarousel(
          length: items.length,
          buildItem: (_, {int index, double width, double height}) {
            return buildTemplate(
              context,
              data: items[index],
              size: Size(width, height),
              background: backgroundItem,
              radius: radius,
            );
          },
          padding: padding,
          pad: pad,
          size: size,
        );
      case Strings.bannerLayoutMasonry:
        return LayoutMasonry(
          length: items.length,
          buildItem: (_, {int index, double width, double height}) {
            return buildTemplate(
              context,
              data: items[index],
              size: Size(width, height),
              background: backgroundItem,
              radius: radius,
            );
          },
          padding: padding,
          pad: pad,
          size: size,
        );
      case Strings.bannerLayoutSlideshow:
        Color indicatorColor = ConvertData.fromRGBA(get(styles, ['indicatorColor', themeModeKey], {}), Colors.black);
        Color indicatorActiveColor =
            ConvertData.fromRGBA(get(styles, ['indicatorActiveColor', themeModeKey], {}), Colors.black);

        return LayoutSlideshow(
          length: items.length,
          buildItem: (_, {int index, double width, double height}) {
            return buildTemplate(
              context,
              data: items[index],
              size: Size(width, height),
              background: backgroundItem,
              radius: radius,
            );
          },
          padding: padding,
          size: size,
          indicatorColor: indicatorColor,
          indicatorActiveColor: indicatorActiveColor,
        );
      case Strings.bannerLayoutGrid:
        int col = ConvertData.stringToInt(get(styles, ['col'], 2));
        double ratio = ConvertData.stringToDouble(get(styles, ['ratio'], 1));

        return LayoutGrid(
          length: items.length,
          buildItem: (_, {int index, double width, double height}) {
            return buildTemplate(
              context,
              data: items[index],
              size: Size(width, height),
              background: backgroundItem,
              radius: radius,
            );
          },
          padding: padding,
          size: size,
          col: col,
          ratio: ratio,
        );
      case Strings.bannerLayoutMulti:
        return LayoutMulti(
          length: items.length,
          buildItem: (_, {int index, double width, double height}) {
            return buildTemplate(
              context,
              data: items[index],
              size: Size(width, height),
              background: backgroundItem,
              radius: radius,
            );
          },
          padding: padding,
          size: size,
        );
      default:
        return LayoutList(
          length: items.length,
          buildItem: (_, {int index, double width, double height}) {
            return buildTemplate(
              context,
              data: items[index],
              size: Size(width, height),
              background: backgroundItem,
              radius: radius,
            );
          },
          padding: padding,
          pad: pad,
          size: size,
        );
    }
  }

  Widget buildTemplate(
    BuildContext context, {
    Map<String, dynamic> data,
    Size size,
    Color background = Colors.transparent,
    double radius = 0,
  }) {
    SettingStore settingStore = Provider.of<SettingStore>(context);
    String themeModeKey = settingStore?.themeModeKey ?? 'value';
    String language = settingStore?.locale ?? 'en';

    String template = get(data, ['template'], Strings.bannerItemDefault);
    Map<String, dynamic> item = get(data, ['data'], {});

    switch (template) {
      case Strings.bannerItemStyle1:
        return Style1Item(
          item: item,
          size: size,
          background: background,
          radius: radius,
          language: language,
          themeModeKey: themeModeKey,
          onClick: (Map<String, dynamic> action) => navigate(context, action),
        );
      case Strings.bannerItemStyle2:
        return Style2Item(
          item: item,
          size: size,
          background: background,
          radius: radius,
          language: language,
          themeModeKey: themeModeKey,
          onClick: (Map<String, dynamic> action) => navigate(context, action),
        );
      case Strings.bannerItemStyle3:
        return Style3Item(
          item: item,
          size: size,
          background: background,
          radius: radius,
          language: language,
          themeModeKey: themeModeKey,
          onClick: (Map<String, dynamic> action) => navigate(context, action),
        );
      case Strings.bannerItemStyle4:
        return Style4Item(
          item: item,
          size: size,
          background: background,
          radius: radius,
          language: language,
          themeModeKey: themeModeKey,
          onClick: (Map<String, dynamic> action) => navigate(context, action),
        );
      case Strings.bannerItemStyle5:
        return Style5Item(
          item: item,
          size: size,
          background: background,
          radius: radius,
          language: language,
          themeModeKey: themeModeKey,
          onClick: (Map<String, dynamic> action) => navigate(context, action),
        );
      case Strings.bannerItemStyle6:
        return Style6Item(
          item: item,
          size: size,
          background: background,
          radius: radius,
          language: language,
          themeModeKey: themeModeKey,
          onClick: (Map<String, dynamic> action) => navigate(context, action),
        );
      case Strings.bannerItemStyle7:
        return Style7Item(
          item: item,
          size: size,
          background: background,
          radius: radius,
          language: language,
          themeModeKey: themeModeKey,
          onClick: (Map<String, dynamic> action) => navigate(context, action),
        );
      case Strings.bannerItemStyle8:
        return Style8Item(
          item: item,
          size: size,
          background: background,
          radius: radius,
          language: language,
          themeModeKey: themeModeKey,
          onClick: (Map<String, dynamic> action) => navigate(context, action),
        );
      case Strings.bannerItemStyle9:
        return Style9Item(
          item: item,
          size: size,
          background: background,
          radius: radius,
          language: language,
          themeModeKey: themeModeKey,
          onClick: (Map<String, dynamic> action) => navigate(context, action),
        );
      default:
        return DefaultItem(
          item: item,
          size: size,
          background: background,
          radius: radius,
          language: language,
          themeModeKey: themeModeKey,
          onClick: (Map<String, dynamic> action) => navigate(context, action),
        );
    }
  }
}
