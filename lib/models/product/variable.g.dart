// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'variable.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Variable _$VariableFromJson(Map<String, dynamic> json) {
  return Variable(
    id: json['variation_id'] as int,
    attributes: json['attributes'] as Map<String, dynamic>,
    price: (json['display_price'] as num)?.toDouble(),
    regularPrice: (json['display_regular_price'] as num)?.toDouble(),
    inStock: json['is_in_stock'] as bool,
    isPurchasable: json['is_purchasable'] as bool,
  );
}

Map<String, dynamic> _$VariableToJson(Variable instance) => <String, dynamic>{
      'variation_id': instance.id,
      'attributes': instance.attributes,
      'display_price': instance.price,
      'display_regular_price': instance.regularPrice,
      'is_in_stock': instance.inStock,
      'is_purchasable': instance.isPurchasable,
    };
