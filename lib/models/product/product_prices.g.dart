// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_prices.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductPrices _$ProductPricesFromJson(Map<String, dynamic> json) {
  return ProductPrices(
    minPrice: ConvertData.stringToDouble(json['min_price']),
    maxPrice: ConvertData.stringToDouble(json['max_price']),
  );
}

Map<String, dynamic> _$ProductPricesToJson(ProductPrices instance) => <String, dynamic>{
      'min_price': instance.minPrice,
      'max_price': instance.maxPrice,
    };
