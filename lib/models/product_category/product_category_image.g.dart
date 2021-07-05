// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_category_image.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductCategoryImage _$ProductCategoryImageFromJson(Map<String, dynamic> json) {
  return ProductCategoryImage(
    id: json['id'] as int,
    src: json['src'] as String,
    name: json['name'] as String,
    woocommerceThumbnail: json['woocommerce_thumbnail'] as String,
    woocommerceSingle: json['woocommerce_single'] as String,
    woocommerceGalleryThumbnail: json['woocommerce_gallery_thumbnail'] as String,
    shopCatalog: json['shop_catalog'] as String,
    shopSingle: json['shop_single'] as String,
    shopThumbnail: json['shop_thumbnail'] as String,
  );
}

Map<String, dynamic> _$ProductCategoryImageToJson(ProductCategoryImage instance) => <String, dynamic>{
      'id': instance.id,
      'src': instance.src,
      'name': instance.name,
      'woocommerce_thumbnail': instance.woocommerceThumbnail,
      'woocommerce_single': instance.woocommerceSingle,
      'woocommerce_gallery_thumbnail': instance.woocommerceGalleryThumbnail,
      'shop_catalog': instance.shopCatalog,
      'shop_single': instance.shopSingle,
      'shop_thumbnail': instance.shopThumbnail,
    };
