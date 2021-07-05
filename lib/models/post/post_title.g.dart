// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_title.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostTitle _$PostTitleFromJson(Map<String, dynamic> json) {
  return PostTitle(
    rendered: json['rendered'] as String,
    protected: json['protected'] as bool ?? false,
  );
}

Map<String, dynamic> _$PostTitleToJson(PostTitle instance) => <String, dynamic>{
      'rendered': instance.rendered,
      'protected': instance.protected,
    };
