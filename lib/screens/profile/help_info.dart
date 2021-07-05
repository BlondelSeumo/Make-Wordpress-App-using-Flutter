import 'package:cirilla/mixins/app_bar_mixin.dart';
import 'package:cirilla/mixins/navigation_mixin.dart';
import 'package:cirilla/mixins/utility_mixin.dart';
import 'package:cirilla/models/setting/setting.dart';
import 'package:cirilla/store/setting/setting_store.dart';
import 'package:cirilla/types/types.dart';
import 'package:cirilla/utils/app_localization.dart';
import 'package:cirilla/widgets/cirilla_tile.dart';
import 'package:flutter/material.dart';

class HelpInfoScreen extends StatelessWidget with Utility, NavigationMixin, AppBarMixin {
  final SettingStore store;

  HelpInfoScreen({
    Key key,
    this.store,
  }) : super(key: key);

  Widget buildItem(BuildContext context, {Map item}) {
    ThemeData theme = Theme.of(context);

    String title = get(item, ['data', 'title', 'text'], '');
    Map<String, dynamic> action = get(item, ['data', 'action'], {});

    return CirillaTile(
      title: Text(title, style: theme.textTheme.subtitle2),
      onTap: () => navigate(context, action),
    );
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TranslateType translate = AppLocalizations.of(context).translate;
    WidgetConfig widgetConfig = store.data.screens['profile'].widgets['profilePage'];
    Map<String, dynamic> fields = widgetConfig.fields;

    List items = get(fields, ['itemInfo'], []);

    return Scaffold(
      appBar: AppBar(
        title: Text(translate('help_info'), style: theme.textTheme.subtitle1),
        shadowColor: Colors.transparent,
        centerTitle: true,
        leading: leading(),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: List.generate(items.length, (index) => buildItem(context, item: items[index])),
        ),
      ),
    );
  }
}
