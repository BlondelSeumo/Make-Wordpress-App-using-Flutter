// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartData _$CartDataFromJson(Map<String, dynamic> json) {
  return CartData(
    hasCalculatedShipping: json['has_calculated_shipping'] as bool,
    itemsCount: json['items_count'] as int,
    itemsWeight: (json['items_weight'] as num)?.toDouble(),
    needsPayment: json['needs_payment'] as bool,
    needsShipping: json['needs_shipping'] as bool,
  )
    ..items = CartData.toList(json['items'] as List)
    ..coupons = json['coupons'] as List
    ..totals = json['totals'] as Map<String, dynamic>;
}

Map<String, dynamic> _$CartDataToJson(CartData instance) => <String, dynamic>{
      'items_count': instance.itemsCount,
      'items_weight': instance.itemsWeight,
      'needs_payment': instance.needsPayment,
      'needs_shipping': instance.needsShipping,
      'has_calculated_shipping': instance.hasCalculatedShipping,
      'items': instance.items,
      'coupons': instance.coupons,
      'totals': instance.totals,
    };

CartItem _$CartItemFromJson(Map<String, dynamic> json) {
  return CartItem(
    key: json['key'] as String,
    id: json['id'] as int,
    quantity: json['quantity'] as int,
    quantityLimit: json['quantity_limit'] as int,
    name: json['name'] as String,
    images: (json['images'] as List)?.map((e) => e as Map<String, dynamic>)?.toList(),
    prices: json['prices'] as Map<String, dynamic>,
    variation: (json['variation'] as List)?.map((e) => e as Map<String, dynamic>)?.toList(),
  );
}

Map<String, dynamic> _$CartItemToJson(CartItem instance) => <String, dynamic>{
      'key': instance.key,
      'id': instance.id,
      'quantity': instance.quantity,
      'quantity_limit': instance.quantityLimit,
      'name': instance.name,
      'images': instance.images,
      'variation': instance.variation,
      'prices': instance.prices,
    };
