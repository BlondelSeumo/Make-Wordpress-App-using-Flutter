import 'dart:math';

import 'package:cirilla/store/setting/setting_store.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'convert_data.dart';
import 'package:cirilla/models/currency/currency.dart' show getCurrencies;

///
/// Format currency
///
String formatCurrency(BuildContext context, {String price, String currency, String symbol, String pattern}) {
  // Return empty price
  if (price == null || price.isEmpty || price == "") {
    return "";
  }

  SettingStore settingStore = Provider.of<SettingStore>(context);
  String _currency = currency ?? settingStore.currency;

  Map<String, dynamic> _currencyInfo;
  if (settingStore.currencies.containsKey(_currency)) {
    _currencyInfo = settingStore.currencies[settingStore.currency];
  } else {
    _currencyInfo = getCurrencies[currency];
  }

  int numDecimals = _currencyInfo['num_decimals'] != null ? ConvertData.stringToInt(_currencyInfo['num_decimals']) : 2;
  String _symbol = symbol ?? _currencyInfo['symbol'];

  NumberFormat f = NumberFormat.currency(
    locale: settingStore.locale,
    symbol: _symbol,
    decimalDigits: numDecimals,
  );
  return f.format(ConvertData.stringToDouble(price));
}

///
/// Convert currency
///
String convertCurrency(BuildContext context, {String price, String currency, int unit}) {
  if (currency == null) {
    return price;
  }

  int u = unit > 1 ? pow(10, unit) : 1;
  double currencyPrice = ConvertData.stringToDouble(price) / u;

  // Get currency info
  SettingStore settingStore = Provider.of<SettingStore>(context);

  print(settingStore.currency);

  // Format if it is default currency
  if (settingStore.currency == currency) {
    return formatCurrency(context, price: currencyPrice.toString());
  }

  Map<String, dynamic> _currencyInfo = settingStore.currencies[settingStore.currency];

  // Calc rate currency
  double priceRate = ConvertData.stringToDouble(_currencyInfo['rate']) * currencyPrice;

  return formatCurrency(context, price: priceRate.toString());
}
