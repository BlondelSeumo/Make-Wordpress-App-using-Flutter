// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_node.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderNode _$OrderNodeFromJson(Map<String, dynamic> json) {
  return OrderNode(
    id: json['id'] as int,
    dateCreated: json['date_created'] as String,
    author: json['author'] as String,
    note: json['note'] as String,
  );
}

Map<String, dynamic> _$OrderNodeToJson(OrderNode instance) => <String, dynamic>{
      'id': instance.id,
      'author': instance.author,
      'note': instance.note,
      'date_created': instance.dateCreated,
    };
