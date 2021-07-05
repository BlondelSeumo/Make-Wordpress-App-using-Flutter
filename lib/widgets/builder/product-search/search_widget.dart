import 'package:cirilla/mixins/mixins.dart';
import 'package:cirilla/models/models.dart';
import 'package:cirilla/store/store.dart';
import 'package:cirilla/utils/utils.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ui/ui.dart';

abstract class SearchWidget extends StatefulWidget {
  final WidgetConfig widgetConfig;

  SearchWidget({
    Key key,
    this.widgetConfig,
  }) : super(key: key);

  @override
  _SearchWidgetState createState() => _SearchWidgetState();

  void onPressed(BuildContext context);
}

class _SearchWidgetState extends State<SearchWidget> with Utility {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    SettingStore settingStore = Provider.of<SettingStore>(context);
    String themeModeKey = settingStore?.themeModeKey ?? 'value';
    String language = settingStore?.locale ?? 'en';

    // Styles
    Map<String, dynamic> styles = widget?.widgetConfig?.styles ?? {};
    Map<String, dynamic> margin = get(styles, ['margin'], {});
    Map<String, dynamic> padding = get(styles, ['padding'], {});
    Color background = ConvertData.fromRGBA(get(styles, ['background', themeModeKey], {}), Colors.transparent);
    Color backgroundInput =
        ConvertData.fromRGBA(get(styles, ['backgroundColorInput', themeModeKey], {}), theme.cardColor);
    Color borderColor = ConvertData.fromRGBA(get(styles, ['borderColorInput', themeModeKey], {}), theme.dividerColor);
    Color iconColor = ConvertData.fromRGBA(get(styles, ['iconColorInput', themeModeKey], {}), Colors.black);

    // General config
    Map<String, dynamic> fields = widget?.widgetConfig?.fields ?? {};
    bool enableIcon = get(fields, ['enableIcon'], true);
    bool enableIconLeft = get(fields, ['enableIconLeft'], true);
    dynamic placeholder = get(fields, ['placeholder'], {});

    String textPlaceholder = ConvertData.stringFromConfigs(placeholder, language);
    TextStyle textStyle = ConvertData.toTextStyle(placeholder, themeModeKey);

    return Container(
      margin: ConvertData.space(margin, 'margin'),
      padding: ConvertData.space(padding, 'padding'),
      color: background,
      child: InkWell(
        onTap: () => widget.onPressed(context),
        borderRadius: BorderRadius.circular(8),
        child: Search(
          icon: enableIcon
              ? Icon(
                  FeatherIcons.search,
                  size: 16,
                  color: iconColor,
                )
              : null,
          label: Text(
            textPlaceholder,
            style: theme.textTheme.bodyText1.merge(textStyle),
          ),
          // color: ConvertData.darkModeToColor(background, darkMode),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(width: 1, color: borderColor),
          ),
          color: backgroundInput,
          enableIconLeft: enableIconLeft,
        ),
      ),
      // child: widget.buildSearch(context),
    );
  }
}
