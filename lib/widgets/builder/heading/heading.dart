import 'package:cirilla/mixins/mixins.dart';
import 'package:cirilla/models/models.dart';
import 'package:cirilla/store/setting/setting_store.dart';
import 'package:cirilla/utils/convert_data.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:ui/ui.dart';
import 'package:provider/provider.dart';

class HeadingWidget extends StatelessWidget with Utility, NavigationMixin {
  final WidgetConfig widgetConfig;

  HeadingWidget({
    Key key,
    @required this.widgetConfig,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SettingStore settingStore = Provider.of<SettingStore>(context);
    String themeModeKey = settingStore?.themeModeKey ?? 'value';
    String lang = settingStore?.locale ?? 'en';

    /// Config general
    Map<String, dynamic> headingData = widgetConfig?.fields ?? {};

    //leading
    String title = ConvertData.stringFromConfigs(get(headingData, ['title'], ''), lang);
    TextStyle titleStyle = ConvertData.toTextStyle(get(headingData, ['title'], ''), themeModeKey);
    String icons = get(headingData, ['icon', 'name'], '');
    bool enableIcon = get(headingData, ['enableIcon'], true);
    bool centerTitle = get(headingData, ['centerTitle'], false);

    //trailing
    String actionTitle = ConvertData.stringFromConfigs(get(headingData, ['actionTitle'], ''), lang);
    TextStyle actionTitleStyle = ConvertData.toTextStyle(get(headingData, ['actionTitle'], ''), themeModeKey);
    String iconAction = get(headingData, ['iconAction', 'name'], '');
    bool enableIconAction = get(headingData, ['enableIconAction'], true);
    Map<String, dynamic> action = headingData['action'] ?? {};

    /// Styles
    Map<String, dynamic> styles = widgetConfig?.styles ?? {};
    Map padding = get(styles, ['padding'], {});
    Map margin = get(styles, ['margin'], {});
    double dividerHeight = ConvertData.stringToDouble(get(styles, ['dividerHeight'], 0.0));

    Color background = ConvertData.fromRGBA(get(styles, ['background', themeModeKey], {}), Colors.transparent);
    Color secondBackground =
        ConvertData.fromRGBA(get(styles, ['secondBackground', themeModeKey], {}), Colors.transparent);
    double borderRadiusTopLeft = ConvertData.stringToDouble(get(styles, ['borderRadiusTopLeft'], 0));
    double borderRadiusTopRight = ConvertData.stringToDouble(get(styles, ['borderRadiusTopRight'], 0));
    double borderRadiusBottomLeft = ConvertData.stringToDouble(get(styles, ['borderRadiusBottomLeft'], 0));
    double borderRadiusBottomRight = ConvertData.stringToDouble(get(styles, ['borderRadiusBottomRight'], 0));
    Color underlinedColor = ConvertData.fromRGBA(get(styles, ['dividerColor', themeModeKey], {}), Colors.transparent);
    // layout
    String layout = widgetConfig?.layout ?? 'default';
    switch (layout) {
      case "divider":
        return Heading(
          centerTitle: centerTitle,
          margin: ConvertData.space(margin, 'margin'),
          padding: ConvertData.space(padding, 'padding'),
          leading: enableIcon == true
              ? Icon(
                  FeatherIconsMap[icons],
                  size: 16,
                )
              : null,
          title: buildText(context, title, titleStyle),
          dash: dividerHeight != 0 ? Divider(height: 2, thickness: dividerHeight, color: underlinedColor) : null,
          see: buildText(context, actionTitle, actionTitleStyle),
          trailing: enableIconAction == true
              ? Icon(
                  FeatherIconsMap[iconAction],
                  size: 16,
                )
              : null,
          background: background,
          onTap: () => navigate(context, action),
        );
      case "corner":
        return buildCorner(
            padding: padding,
            margin: margin,
            borderRadiusBottomLeft: borderRadiusBottomLeft,
            borderRadiusBottomRight: borderRadiusBottomRight,
            borderRadiusTopLeft: borderRadiusTopLeft,
            borderRadiusTopRight: borderRadiusTopRight,
            background: background,
            secondBackground: secondBackground,
            dividerHeight: dividerHeight,
            content: Row(
              children: [
                if (enableIcon == true) Icon(FeatherIconsMap[icons], size: 16),
                Expanded(
                    child: Text(title,
                        style: titleStyle, textAlign: centerTitle == true ? TextAlign.center : TextAlign.left)),
                InkWell(
                  onTap: () => navigate(context, action),
                  child: Row(
                    children: [
                      Text(actionTitle, style: actionTitleStyle),
                      if (enableIconAction == true) Icon(FeatherIconsMap[iconAction], size: 16)
                    ],
                  ),
                )
              ],
            ));
      case "vertical":
        return buildCorner(
            padding: padding,
            margin: margin,
            borderRadiusBottomLeft: borderRadiusBottomLeft,
            borderRadiusBottomRight: borderRadiusBottomRight,
            borderRadiusTopLeft: borderRadiusTopLeft,
            borderRadiusTopRight: borderRadiusTopRight,
            background: background,
            secondBackground: secondBackground,
            dividerHeight: dividerHeight,
            content: Container(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: centerTitle == true ? CrossAxisAlignment.center : CrossAxisAlignment.start,
                children: [
                  if (enableIcon == true)
                    Icon(
                      FeatherIconsMap[icons],
                      size: 16,
                    ),
                  Text(title, style: titleStyle),
                  InkWell(
                      onTap: () => navigate(context, action),
                      child: Column(
                        crossAxisAlignment: centerTitle == true ? CrossAxisAlignment.center : CrossAxisAlignment.start,
                        children: [
                          Text(actionTitle, style: actionTitleStyle),
                          if (enableIconAction == true)
                            Icon(
                              FeatherIconsMap[iconAction],
                              size: 16,
                            ),
                        ],
                      ))
                ],
              ),
            ));
      default:
        return Heading(
          centerTitle: centerTitle,
          margin: ConvertData.space(margin, 'margin'),
          padding: ConvertData.space(padding, 'padding'),
          leading: enableIcon == true
              ? Icon(
                  FeatherIconsMap[icons],
                  size: 16,
                )
              : null,
          title: buildText(context, title, titleStyle),
          underlined: dividerHeight != 0 ? Divider(height: 2, thickness: dividerHeight, color: underlinedColor) : null,
          see: buildText(context, actionTitle, actionTitleStyle),
          trailing: enableIconAction == true
              ? Icon(
                  FeatherIconsMap[iconAction],
                  size: 16,
                )
              : null,
          background: background,
          onTap: () => navigate(context, action),
        );
    }
  }

  Widget buildText(BuildContext context, String text, TextStyle style, {TextAlign textAlign}) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.42),
      child: Text(
        text,
        textAlign: textAlign,
        style: Theme.of(context).textTheme.caption.merge(style),
      ),
    );
  }

  Widget buildCorner(
      {Map padding,
      Map margin,
      Color background,
      double borderRadiusTopLeft,
      double borderRadiusTopRight,
      double borderRadiusBottomLeft,
      double borderRadiusBottomRight,
      Widget content,
      double dividerHeight,
      Color secondBackground}) {
    return Stack(
      children: [
        Container(
          padding: ConvertData.space(padding, 'padding'),
          margin: ConvertData.space(margin, 'margin'),
          decoration: BoxDecoration(
            color: background,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(borderRadiusTopLeft),
              topRight: Radius.circular(borderRadiusTopRight),
              bottomLeft: Radius.circular(borderRadiusBottomLeft),
              bottomRight: Radius.circular(borderRadiusBottomRight),
            ),
          ),
          child: content,
        ),
        Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              margin: ConvertData.space(margin, 'margin'),
              height: dividerHeight,
              decoration: BoxDecoration(
                  color: secondBackground,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(borderRadiusTopLeft),
                    topRight: Radius.circular(borderRadiusTopRight),
                    bottomLeft: Radius.circular(borderRadiusBottomLeft),
                    bottomRight: Radius.circular(borderRadiusBottomRight),
                  )),
            ))
      ],
    );
  }
}
