// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductCategory _$ProductCategoryFromJson(Map<String, dynamic> json) {
  return ProductCategory(
    id: json['id'] as int,
    slug: json['slug'] as String,
    name: json['name'] as String,
  );
}

Map<String, dynamic> _$ProductCategoryToJson(ProductCategory instance) => <String, dynamic>{
      'id': instance.id,
      'slug': instance.slug,
      'name': instance.name,
    };
