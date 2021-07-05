import 'package:json_annotation/json_annotation.dart';

part 'country.g.dart';

@JsonSerializable()
class CountryData {
  String name;
  String code;
  List<Map<String, dynamic>> states;

  CountryData({this.name, this.code, this.states});
  factory CountryData.fromJson(Map<String, dynamic> json) => _$CountryDataFromJson(json);

  Map<String, dynamic> toJson() => _$CountryDataToJson(this);
}
