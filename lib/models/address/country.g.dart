// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CountryData _$CountryDataFromJson(Map<String, dynamic> json) {
  return CountryData(
    name: json['name'] as String,
    code: json['code'] as String,
    states: (json['states'] as List)?.map((e) => e as Map<String, dynamic>)?.toList(),
  );
}

Map<String, dynamic> _$CountryDataToJson(CountryData instance) => <String, dynamic>{
      'name': instance.name,
      'code': instance.code,
      'states': instance.states,
    };
