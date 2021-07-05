import 'package:json_annotation/json_annotation.dart';

part 'currency.g.dart';

class Currency {
  String code;

  String name;

  String symbol;

  Currency({this.code, this.name, this.symbol});
}

@JsonLiteral('data.json')
Map get getCurrencies => _$getCurrenciesJsonLiteral;
