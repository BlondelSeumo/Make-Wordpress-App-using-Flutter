// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bill_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BillDetailData _$BillDetailDataFromJson(Map<String, dynamic> json) {
  return BillDetailData(
    username: json['username'] as String,
    email: json['email'] as String,
    billing: json['billing'] as Map<String, dynamic>,
    shipping: json['shipping'] as Map<String, dynamic>,
  );
}

Map<String, dynamic> _$BillDetailDataToJson(BillDetailData instance) => <String, dynamic>{
      'username': instance.username,
      'email': instance.email,
      'billing': instance.billing,
      'shipping': instance.shipping,
    };
