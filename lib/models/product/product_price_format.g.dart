// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_price_format.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductPriceFormat _$ProductPriceFormatFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const ['regular_price']);
  return ProductPriceFormat(
    regularPrice: json['regular_price'] as String ?? '0.0',
    salePrice: json['sale_price'] as String,
    percent: json['percent'] as int,
  );
}
