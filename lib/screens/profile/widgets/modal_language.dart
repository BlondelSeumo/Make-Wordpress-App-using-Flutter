import 'package:cirilla/store/setting/setting_store.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:cirilla/widgets/cirilla_tile.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class ModalLanguage extends StatelessWidget {
  final SettingStore settingStore;

  ModalLanguage({
    Key key,
    @required this.settingStore,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    String locale = settingStore?.locale ?? 'en';

    return Observer(
      builder: (_) => Column(
        children: settingStore.supportedLanguages.map((item) {
          TextStyle titleStyle = theme.textTheme.subtitle2;
          TextStyle activeTitleStyle = titleStyle.copyWith(color: theme.primaryColor);

          return CirillaTile(
            title: Text(item.language, style: item.locale == locale ? activeTitleStyle : titleStyle),
            trailing: item.locale == locale ? Icon(FeatherIcons.check, size: 20, color: theme.primaryColor) : null,
            isChevron: false,
            onTap: () {
              settingStore.changeLanguage(item.locale);
              Navigator.pop(context);
            },
          );
        }).toList(),
      ),
    );
  }
}
