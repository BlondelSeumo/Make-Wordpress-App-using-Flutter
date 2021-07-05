import 'package:cirilla/mixins/utility_mixin.dart';
import 'package:cirilla/models/setting/setting.dart';
import 'package:cirilla/utils/convert_data.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';

class Tabs extends StatelessWidget with Utility {
  final String selected;
  final Function onItemTapped;
  final Data data;
  final String isDivider;

  const Tabs({
    Key key,
    this.selected,
    this.onItemTapped,
    this.data,
    this.isDivider = 'border_top',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetConfig widgetConfig = data.widgets['tabs'];

    List items = get(widgetConfig.fields, ['items'], []);

    String layoutData = widgetConfig.layout ?? 'default';

    double radius = ConvertData.stringToDouble(get(widgetConfig.styles, ['radius'], 0));

    bool enableShadow = get(widgetConfig.styles, ['enableShadow'], true);

    double pad = ConvertData.stringToDouble(get(widgetConfig.styles, ['pad'], 0));

    ThemeData theme = Theme.of(context);
    TextStyle nameDefault = theme.textTheme.overline;
    TextStyle nameActive = nameDefault.copyWith(
      color: theme.primaryColor,
    );

    return BottomAppBar(
      elevation: enableShadow == true ? 20 : 0,
      shape: AutomaticNotchedShape(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: isDivider == '$layoutData' ? Radius.circular(0) : Radius.circular(radius),
            topRight: isDivider == '$layoutData' ? Radius.circular(0) : Radius.circular(radius),
          ),
        ),
      ),
      child: Row(
        children: List.generate(
          items.length,
          (index) {
            final item = items.elementAt(index);
            String key = get(item, ['data', 'action', 'args', 'key'], '');
            String icon = get(item, ['data', 'icon', 'name'], 'home');
            String name = get(item, ['data', 'title', 'text'], '');

            return Flexible(
              flex: 1,
              child: InkResponse(
                onTap: () => onItemTapped(key),
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (isDivider == '$layoutData')
                        Container(
                          width: double.infinity,
                          height: 4,
                          color: key == selected ? theme.primaryColor : null,
                        ),
                      SizedBox(
                        height: pad,
                      ),
                      Icon(
                        FeatherIconsMap[icon],
                        color: key == selected ? theme.primaryColor : null,
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        name,
                        style: key == selected ? nameActive : nameDefault,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(
                        height: pad,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
