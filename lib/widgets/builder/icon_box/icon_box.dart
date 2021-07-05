import 'package:cirilla/mixins/mixins.dart';
import 'package:cirilla/models/models.dart';
import 'package:cirilla/store/store.dart';
import 'package:cirilla/utils/utils.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ui/ui.dart';

import 'layout/layout_list.dart';
import 'layout/layout_carousel.dart';
import 'layout/layout_grid.dart';
import 'layout/layout_masonry.dart';
import 'layout/layout_slideshow.dart';

class IconBoxWidget extends StatelessWidget with Utility {
  final WidgetConfig widgetConfig;

  IconBoxWidget({
    Key key,
    @required this.widgetConfig,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SettingStore settingStore = Provider.of<SettingStore>(context);
    String themeModeKey = settingStore?.themeModeKey ?? 'value';

    // layout
    String layout = widgetConfig.layout ?? 'list';

    // Styles
    Map<String, dynamic> styles = widgetConfig?.styles ?? {};
    Map<String, dynamic> margin = get(styles, ['margin'], {});
    Map<String, dynamic> padding = get(styles, ['padding'], {});
    Color background = ConvertData.fromRGBA(get(styles, ['background', themeModeKey], {}), Colors.transparent);
    double height = ConvertData.stringToDouble(get(styles, ['height'], 300));

    // General config
    Map<String, dynamic> fields = widgetConfig?.fields ?? {};
    List items = get(fields, ['items'], []);

    return Container(
      margin: ConvertData.space(margin, 'margin'),
      color: background,
      height: layout == 'carousel' ? height : null,
      child: buildLayout(
        layout,
        items: items,
        height: height,
        padding: ConvertData.space(padding, 'padding'),
        styles: styles,
        themeModeKey: themeModeKey,
      ),
    );
  }

  Widget buildLayout(
    String layout, {
    List items,
    double height,
    EdgeInsetsDirectional padding,
    Map<String, dynamic> styles,
    String themeModeKey,
  }) {
    if (items.isEmpty) {
      return null;
    }
    double pad = ConvertData.stringToDouble(get(styles, ['pad'], 12));

    switch (layout) {
      case 'carousel':
        return LayoutCarousel(
          items: items,
          padding: padding,
          pad: pad,
          buildItem: (BuildContext context, {dynamic item, int index, double width, double height}) {
            return buildItem(
              context,
              item: item,
              styles: styles,
              width: width,
              height: height,
            );
          },
          height: height,
        );
        break;
      case 'grid':
        int column = ConvertData.stringToInt(get(styles, ['col'], 2), 2);
        double ratio = ConvertData.stringToDouble(get(styles, ['ratio'], 1), 1);
        return LayoutGrid(
          items: items,
          padding: padding,
          pad: pad,
          column: column,
          ratio: ratio,
          buildItem: (BuildContext context, {dynamic item, int index, double width, double height}) {
            return buildItem(
              context,
              item: item,
              styles: styles,
              width: width,
              height: height,
            );
          },
        );
        break;
      case 'masonry':
        return LayoutMasonry(
          items: items,
          padding: padding,
          pad: pad,
          buildItem: (BuildContext context, {dynamic item, int index, double width, double height}) {
            return buildItem(
              context,
              item: item,
              styles: styles,
              width: width,
              height: height,
            );
          },
        );
        break;
      case 'slideshow':
        double maxWidth = ConvertData.stringToDouble(get(styles, ['maxWidth']), 300);
        Color indicatorColor = ConvertData.fromRGBA(get(styles, ['indicatorColor', themeModeKey], {}), Colors.black);
        Color indicatorActiveColor =
            ConvertData.fromRGBA(get(styles, ['indicatorActiveColor', themeModeKey], {}), Colors.black);
        return LayoutSlideshow(
          items: items,
          padding: padding,
          indicatorColor: indicatorColor,
          indicatorActiveColor: indicatorActiveColor,
          buildItem: (BuildContext context, {dynamic item, int index, double width, double height}) {
            return buildItem(
              context,
              item: item,
              styles: styles,
              width: width,
              maxWidth: maxWidth,
              height: height,
            );
          },
        );
        break;
      default:
        return LayoutList(
          items: items,
          padding: padding,
          pad: pad,
          buildItem: (BuildContext context, {dynamic item, int index, double width, double height}) {
            return buildItem(
              context,
              item: item,
              styles: styles,
              width: width,
              height: height,
            );
          },
        );
    }
  }

  Widget buildItem(
    BuildContext context, {
    dynamic item,
    Map<String, dynamic> styles,
    double width,
    double height,
    double maxWidth,
  }) {
    ThemeData theme = Theme.of(context);

    SettingStore settingStore = Provider.of<SettingStore>(context);
    String themeModeKey = settingStore?.themeModeKey ?? 'value';
    String languageKey = settingStore?.languageKey ?? 'text';

    String typeTemplate = get(item, ['template'], 'default');
    Map<String, dynamic> dataTemplate = get(item, ['data'], {});

    String title = get(dataTemplate, ['title', languageKey], '');
    String description = get(dataTemplate, ['description', languageKey], '');

    TextStyle titleStyle = ConvertData.toTextStyle(get(dataTemplate, ['title'], {}), themeModeKey);
    TextStyle descriptionStyle = ConvertData.toTextStyle(get(dataTemplate, ['description'], {}), themeModeKey);

    String icon = get(dataTemplate, ['icon', 'name'], 'settings');
    String alignment = get(dataTemplate, ['alignment'], 'left');

    TextAlign textAlign = ConvertData.toTextAlign(get(dataTemplate, ['alignment'], 'left'));

    // Config
    Color background = ConvertData.fromRGBA(get(styles, ['backgroundColorItem', themeModeKey], {}), theme.cardColor);
    Color borderColor = ConvertData.fromRGBA(get(styles, ['borderColor', themeModeKey], {}), theme.dividerColor);
    double radius = ConvertData.stringToDouble(get(styles, ['radius'], 0));

    // box shadow
    Color shadowColor = ConvertData.fromRGBA(get(styles, ['shadowColor', themeModeKey], {}), Colors.black);
    double offsetX = ConvertData.stringToDouble(get(styles, ['offsetX'], 0));
    double offsetY = ConvertData.stringToDouble(get(styles, ['offsetY'], 4));
    double blurRadius = ConvertData.stringToDouble(get(styles, ['blurRadius'], 24));
    double spreadRadius = ConvertData.stringToDouble(get(styles, ['spreadRadius'], 0));
    List<BoxShadow> boxShadow = [
      BoxShadow(
        color: shadowColor,
        offset: Offset(offsetX, offsetY),
        blurRadius: blurRadius,
        spreadRadius: spreadRadius,
      )
    ];

    TextStyle titleStyleItem = theme.textTheme.subtitle1.merge(titleStyle);
    TextStyle descriptionStyleItem = theme.textTheme.bodyText2.merge(descriptionStyle);

    switch (typeTemplate) {
      case 'contained':
        return IconBoxHorizontalItem(
          icon: buildIcon(
            iconName: icon,
            styles: styles,
            themeModeKey: themeModeKey,
          ),
          title: Text(title, style: titleStyleItem, textAlign: textAlign),
          description: Text(description, style: descriptionStyleItem, textAlign: textAlign),
          width: width,
          height: height,
          maxWidth: width ?? 340,
          color: background,
          border: Border.all(width: 1, color: borderColor),
          borderRadius: BorderRadius.circular(radius),
          boxShadow: boxShadow,
        );
        break;
      case 'group':
        return IconBoxHorizontalItem(
          icon: buildIcon(
            iconName: icon,
            styles: styles,
            themeModeKey: themeModeKey,
          ),
          title: Text(title, style: titleStyleItem, textAlign: textAlign),
          description: Text(description, style: descriptionStyleItem, textAlign: textAlign),
          width: width,
          height: height,
          maxWidth: width ?? 340,
          color: background,
          border: Border.all(width: 1, color: borderColor),
          borderRadius: BorderRadius.circular(radius),
          boxShadow: boxShadow,
          type: IconBoxHorizontalItemType.style2,
        );
        break;
      default:
        CrossAxisAlignment crossAxisAlignment = alignment == 'left'
            ? CrossAxisAlignment.start
            : alignment == 'right'
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.center;
        return IconBoxContainedItem(
          icon: buildIcon(
            iconName: icon,
            styles: styles,
            themeModeKey: themeModeKey,
          ),
          title: Text(title, style: titleStyleItem, textAlign: textAlign),
          description: Text(description, style: descriptionStyleItem, textAlign: textAlign),
          width: width,
          height: height,
          maxWidth: width ?? 280,
          alignment: crossAxisAlignment,
          color: background,
          border: Border.all(width: 1, color: borderColor),
          borderRadius: BorderRadius.circular(radius),
          boxShadow: boxShadow,
        );
    }
  }

  Widget buildIcon({String iconName, Map<String, dynamic> styles, String themeModeKey}) {
    bool enableBoxIcon = get(styles, ['enableBoxIcon'], false);

    double sizeIcon = ConvertData.stringToDouble(get(styles, ['sizeIcon'], 36));
    double sizeBoxIcon = ConvertData.stringToDouble(get(styles, ['sizeBoxIcon'], 54));

    Color iconColor = ConvertData.fromRGBA(get(styles, ['iconColor', themeModeKey], {}), Colors.white);
    Color iconBoxColor = ConvertData.fromRGBA(get(styles, ['iconBoxColor', themeModeKey], {}), Colors.black);
    Color iconBorder = ConvertData.fromRGBA(get(styles, ['iconBorder', themeModeKey], {}), Colors.black);

    Widget icon = Icon(FeatherIconsMap[iconName], size: sizeIcon, color: iconColor);

    return enableBoxIcon
        ? Container(
            width: sizeBoxIcon,
            height: sizeBoxIcon,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: iconBoxColor,
              border: Border.all(width: 1, color: iconBorder),
              shape: BoxShape.circle,
            ),
            child: icon,
          )
        : icon;
  }
}
