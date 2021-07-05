// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostCategory _$PostCategoryFromJson(Map<String, dynamic> json) {
  return PostCategory(
    id: json['id'] as int,
    name: json['name'] as String,
    count: json['count'] as int,
    parent: json['parent'] as int,
    description: json['description'] as String,
    slug: json['slug'] as String,
  )..image = PostCategory._imageFromJson(json['acf']);
}

Map<String, dynamic> _$PostCategoryToJson(PostCategory instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'count': instance.count,
      'parent': instance.parent,
      'description': instance.description,
      'slug': instance.slug,
      'acf': PostCategory._imageToJson(instance.image),
    };
