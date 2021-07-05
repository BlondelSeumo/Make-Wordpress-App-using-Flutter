import 'package:cirilla/constants/strings.dart';
import 'package:cirilla/models/models.dart';
import 'package:cirilla/service/helpers/persist_helper.dart';
import 'package:cirilla/service/helpers/request_helper.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:mobx/mobx.dart';

part 'setting_store.g.dart';

class SettingStore = _SettingStore with _$SettingStore;

abstract class _SettingStore with Store {
  final PersistHelper _persistHelper;
  final RequestHelper _requestHelper;

  _SettingStore(this._persistHelper, this._requestHelper) {
    init();
  }

  void init() async {
    await restore();
    getSetting();
  }

  Future<void> restore() async {
    _darkMode = await _persistHelper.getDarkMode();

    String lang = await _persistHelper.getLanguage();
    if (lang != "" && lang.runtimeType == String) {
      _locale = lang;
    }

    String currency = await _persistHelper.getCurrency();
    if (currency != "" && currency.runtimeType == String) {
      _currency = currency;
    }
  }

  // Store variables: --------------------------------------------------------------------------------------------------
  @observable
  ObservableList<Language> _supportedLanguages = ObservableList<Language>.of([
    Language(code: 'US', locale: 'en', language: 'English'),
    Language(code: 'AR', locale: 'ar', language: 'Arabic'),
  ]);

  // Default language
  @observable
  String _lang = "en";

  @observable
  String _locale = "en";

  @observable
  bool _darkMode = false;

  @observable
  bool _loading = true;

  @observable
  String _tab = Strings.tabActive;

  @observable
  DataScreen _data;

  // Currency
  @observable
  ObservableMap<String, dynamic> _currencies = ObservableMap<String, dynamic>.of({});

  // Default currency
  @observable
  String _defaultCurrency;

  @observable
  String _currency;

  @observable
  String _checkoutUrl = '';

  // Computed: ---------------------------------------------------------------------------------------------------------
  @computed
  bool get darkMode => _darkMode;

  @computed
  String get themeModeKey => _darkMode ? 'dark' : 'value';

  @computed
  String get languageKey => _lang == _locale ? 'text' : _locale;

  @computed
  String get locale => _locale;

  @computed
  ObservableList<Language> get supportedLanguages => _supportedLanguages;

  @computed
  bool get loading => _loading;

  @computed
  PersistHelper get persistHelper => _persistHelper;

  @computed
  RequestHelper get requestHelper => _requestHelper;

  @computed
  String get defaultCurrency => _defaultCurrency;

  @computed
  String get currency => _currency;

  @computed
  bool get isCurrencyChanged => _currency != _defaultCurrency;

  @computed
  ObservableMap<String, dynamic> get currencies => _currencies;

  @computed
  String get checkoutUrl => _checkoutUrl;

  // Get data screen
  @computed
  DataScreen get data => _data;

  @computed
  String get tab => _tab;

  // Actions: ----------------------------------------------------------------------------------------------------------
  @action
  void setTab(String tab) {
    _tab = tab;
  }

  @action
  Future<void> changeLanguage(String value) async {
    _locale = value;
    await _persistHelper.saveLanguage(value);
  }

  @action
  Future<void> changeCurrency(String value) async {
    _currency = value;
    await _persistHelper.saveCurrency(value);
  }

  @action
  Future<void> setDarkMode({@required bool value}) async {
    await _persistHelper.saveDarkMode(value);
    _darkMode = value;
  }

  @action
  Future<void> getSetting() async {
    try {
      Map<String, dynamic> json = await _requestHelper.getSettings();
      setSetting(json);
    } on DioError catch (e) {
      print(e);
    }
  }

  @action
  void setSetting(json) {
    // Screens setting
    if (json['data'] != null) _data = DataScreen.fromJson(json['data']);

    // Languages setting
    _lang = json['language'];
    if (json['languages'] != null && json['languages'].length > 0) {
      List<Language> languages = json['languages']
          .keys
          .map((key) {
            return Language(
                code: json['languages'][key]['code'].toUpperCase(),
                locale: json['languages'][key]['code'],
                language: json['languages'][key]['native_name']);
          })
          .toList()
          .cast<Language>();
      _supportedLanguages = ObservableList<Language>.of(languages);
    }

    // Currency setting
    _defaultCurrency = json['currency'];
    _currency ??= json['currency'];
    if (json['currencies'] != null) _currencies = ObservableMap<String, dynamic>.of(json['currencies']);

    // Checkout url
    if (json['checkout_url'] != null) _checkoutUrl = json['checkout_url'];

    _loading = false;
  }
}
