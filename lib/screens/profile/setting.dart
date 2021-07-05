import 'package:cirilla/mixins/mixins.dart';
import 'package:cirilla/models/models.dart';
import 'package:cirilla/store/setting/setting_store.dart';
import 'package:cirilla/types/types.dart';
import 'package:cirilla/utils/app_localization.dart';
import 'package:cirilla/widgets/cirilla_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import 'widgets/modal_currency.dart';
import 'widgets/modal_language.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> with AppBarMixin {
  SettingStore _settingStore;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _settingStore = Provider.of<SettingStore>(context);
  }

  void onClickLanguage() {

    if (_settingStore.supportedLanguages.length == 1) return;

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        TranslateType translate = AppLocalizations.of(context).translate;
        return buildViewModal(
            title: translate('app_settings_language'), child: ModalLanguage(settingStore: _settingStore));
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
    );
  }

  void onClickCurrency() {
    List<Currency> currencies = _settingStore.currencies.keys
        .map(
          (key) => Currency(
            code: key,
            name: key,
            symbol: _settingStore.currencies[key]['symbol'],
          ),
        )
        .toList()
        .cast<Currency>();

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return buildViewModal(
          title: 'Select Currency',
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter stateSetter) {
              return ModalCurrency(
                currencies: currencies,
                value: _settingStore.currency,
                onChange: (String value) => _settingStore.changeCurrency(value),
              );
            },
          ),
        );
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
    );
  }

  Widget buildViewModal({@required String title, Widget child}) {
    ThemeData theme = Theme.of(context);
    double height = MediaQuery.of(context).size.height;

    return Container(
      constraints: BoxConstraints(maxHeight: height / 2),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 16, bottom: 24),
            child: Text(title, style: theme.textTheme.subtitle1),
          ),
          Flexible(child: SingleChildScrollView(child: child))
        ],
      ),
    );
  }

  String getCodeLanguage() {
    int indexSelect = _settingStore.supportedLanguages.indexWhere((element) => element.locale == _settingStore.locale);
    Language languageSelect = _settingStore.supportedLanguages[indexSelect > 0 ? indexSelect : 0];
    return languageSelect.code;
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TranslateType translate = AppLocalizations.of(context).translate;
    return Scaffold(
      appBar: AppBar(
        title: Text(translate('app_settings'), style: theme.textTheme.subtitle1),
        shadowColor: Colors.transparent,
        centerTitle: true,
        leading: leading(),
      ),
      body: Observer(
        builder: (_) => ListView(
          padding: EdgeInsets.symmetric(horizontal: 20),
          children: [
            CirillaTile(
              title: Text(translate('app_settings_language'), style: theme.textTheme.subtitle2),
              trailing: Text(getCodeLanguage(), style: theme.textTheme.bodyText1),
              onTap: () => onClickLanguage(),
            ),
            CirillaTile(
              title: Text(translate('app_settings_currency'), style: theme.textTheme.subtitle2),
              trailing: Text(_settingStore.currency, style: theme.textTheme.bodyText1),
              onTap: () => onClickCurrency(),
            ),
            CirillaTile(
              title: Text(translate('app_settings_dark_theme'), style: theme.textTheme.subtitle2),
              trailing: CupertinoSwitch(
                value: _settingStore.darkMode,
                onChanged: (value) => _settingStore.setDarkMode(value: value),
              ),
              isChevron: false,
            ),
          ],
        ),
      ),
    );
  }
}
