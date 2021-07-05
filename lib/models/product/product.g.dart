// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) {
  return Product(
    id: json['id'] as int,
    name: json['name'] as String,
    slug: json['slug'] as String,
    type: _$enumDecodeNullable(_$ProductTypeEnumMap, json['type']),
    status: json['status'] as String,
    description: json['description'] as String,
    shortDescription: json['short_description'] as String,
    images: (json['images'] as List)
        ?.map((e) => e == null ? null : ProductImage.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    price: json['price'] as String,
    regularPrice: json['regular_price'] as String,
    salePrice: json['sale_price'] as String,
    onSale: json['on_sale'] as bool,
    date: json['date_created'] as String,
    averageRating: json['average_rating'] as String,
    ratingCount: json['rating_count'] as int,
    formatPrice:
        json['format_price'] == null ? null : ProductPriceFormat.fromJson(json['format_price'] as Map<String, dynamic>),
    catalogVisibility: json['catalog_visibility'] as String,
    stockStatus: json['stock_status'] as String,
    stockQuantity: json['stock_quantity'] as int ?? 0,
    relatedIds: (json['related_ids'] as List)?.map((e) => e as int)?.toList(),
    groupedIds: (json['grouped_products'] as List)?.map((e) => e as int)?.toList(),
    categories: (json['categories'] as List)
        ?.map((e) => e == null ? null : ProductCategory.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    externalUrl: json['external_url'] as String,
    buttonText: json['button_text'] as String,
    purchasable: json['purchasable'] as bool,
    store: json['store'] as Map<String, dynamic>,
    attributes: (json['attributes'] as List)?.map((e) => e as Map<String, dynamic>)?.toList(),
  )
    ..permalink = json['permalink'] as String
    ..multiCurrencyPrices = json['multi-currency-prices'] as Map<String, dynamic>
    ..fromMultiCurrencyPrices = json['from-multi-currency-prices'] as Map<String, dynamic>;
}

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries.singleWhere((e) => e.value == source, orElse: () => null)?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$ProductTypeEnumMap = {
  ProductType.simple: 'simple',
  ProductType.grouped: 'grouped',
  ProductType.external: 'external',
  ProductType.variable: 'variable',
};
