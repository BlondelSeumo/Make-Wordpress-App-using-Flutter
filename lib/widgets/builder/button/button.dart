import 'package:cirilla/mixins/mixins.dart';
import 'package:cirilla/models/models.dart';
import 'package:cirilla/store/store.dart';
import 'package:cirilla/utils/utils.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ButtonWidget extends StatelessWidget with Utility, NavigationMixin {
  final WidgetConfig widgetConfig;

  ButtonWidget({
    Key key,
    @required this.widgetConfig,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    SettingStore settingStore = Provider.of<SettingStore>(context);
    String themeModeKey = settingStore?.themeModeKey ?? 'value';
    String language = settingStore?.locale ?? 'en';

    // Styles
    Map<String, dynamic> styles = widgetConfig?.styles ?? {};
    Map<String, dynamic> margin = get(styles, ['margin'], {});
    Map<String, dynamic> padding = get(styles, ['padding'], {});
    dynamic radius = get(styles, ['radius'], '0');
    Map background = get(styles, ['background', themeModeKey], {});
    double height = ConvertData.stringToDouble(get(styles, ['height'], 48));

    // General config
    Map<String, dynamic> fields = widgetConfig?.fields ?? {};
    dynamic title = get(fields, ['title'], {});
    Map<String, dynamic> action = get(fields, ['action'], {});
    String icon = get(fields, ['icon', 'name'], 'settings');
    bool enableIcon = get(fields, ['enableIcon'], true);
    bool enableIconLeft = get(fields, ['enableIconLeft'], true);
    bool enableFullWidth = get(fields, ['enableFullWidth'], true);

    Color backgroundColor = ConvertData.fromRGBA(background, Colors.transparent);
    double radiusSize = ConvertData.stringToDouble(radius);
    String textTitle = ConvertData.stringFromConfigs(title, language);
    TextStyle styleTitle = ConvertData.toTextStyle(title, themeModeKey);
    TextStyle styleTextButton = theme.textTheme.bodyText1.merge(styleTitle);

    String typeAction = get(action, ['type'], 'none');

    return Container(
      margin: ConvertData.space(margin, 'margin'),
      padding: ConvertData.space(padding, 'padding'),
      color: backgroundColor,
      child: buildFullButton(
        isFull: enableFullWidth,
        child: SizedBox(
          height: height,
          child: ElevatedButton(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (enableIcon && enableIconLeft)
                  Icon(
                    FeatherIconsMap[icon],
                    size: styleTextButton.fontSize,
                    color: styleTextButton.color,
                  ),
                if (enableIcon && enableIconLeft) SizedBox(width: 8),
                Text(textTitle),
                if (enableIcon && !enableIconLeft) SizedBox(width: 8),
                if (enableIcon && !enableIconLeft)
                  Icon(
                    FeatherIconsMap[icon],
                    size: styleTextButton.fontSize,
                    color: styleTextButton.color,
                  ),
              ],
            ),
            onPressed: () => typeAction != 'none' ? navigate(context, action) : null,
            style: ElevatedButton.styleFrom(
              primary: styleTitle.backgroundColor,
              onPrimary: styleTitle.color,
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radiusSize)),
              textStyle: styleTextButton.copyWith(backgroundColor: Colors.transparent),
              shadowColor: Colors.transparent,
              elevation: 0,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildFullButton({Widget child, bool isFull}) {
    if (isFull) {
      return child;
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        child,
      ],
    );
  }
}
