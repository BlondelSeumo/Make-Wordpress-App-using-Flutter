// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_search.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostSearch _$PostSearchFromJson(Map<String, dynamic> json) {
  return PostSearch(
    id: json['id'] as int,
    title: json['title'] as String,
    url: json['url'] as String,
    type: json['type'] as String,
    subtype: json['subtype'] as String,
  );
}

Map<String, dynamic> _$PostSearchToJson(PostSearch instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'url': instance.url,
      'type': instance.type,
      'subtype': instance.subtype,
    };
