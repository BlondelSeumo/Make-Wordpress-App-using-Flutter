// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_tag.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostTag _$PostTagFromJson(Map<String, dynamic> json) {
  return PostTag(
    id: json['id'] as int,
    name: json['name'] as String,
    slug: json['slug'] as String,
    description: json['description'] as String,
    link: json['link'] as String,
    taxonomy: json['taxonomy'] as String,
    meta: json['meta'] as List,
    count: json['count'] as int,
  );
}

Map<String, dynamic> _$PostTagToJson(PostTag instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'slug': instance.slug,
      'description': instance.description,
      'link': instance.link,
      'taxonomy': instance.taxonomy,
      'meta': instance.meta,
      'count': instance.count,
    };
