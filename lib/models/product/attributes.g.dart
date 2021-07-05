// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attributes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Option _$OptionFromJson(Map<String, dynamic> json) {
  return Option(
    termId: json['term_id'] as int,
    taxonomy: json['taxonomy'] as String,
    name: json['name'] as String,
    slug: json['slug'] as String,
    count: json['count'] as int,
    value: json['value'] as String,
  );
}

Attribute _$AttributeFromJson(Map<String, dynamic> json) {
  return Attribute(
    id: json['id'] as int,
    name: json['name'] as String,
    slug: json['slug'] as String,
    type: json['type'] as String,
    hasArchives: json['has_archives'] as bool,
    options: json['options'] == null ? null : AttributeOptions.fromJson(json['options'] as List),
  )..terms = json['terms'] == null ? null : AttributeOptions.fromJson(json['terms'] as List);
}
