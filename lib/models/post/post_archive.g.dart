// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_archive.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostArchive _$PostArchiveFromJson(Map<String, dynamic> json) {
  return PostArchive(
    year: json['year'] as String,
    month: json['month'] as String,
    posts: json['posts'] as String,
  );
}

Map<String, dynamic> _$PostArchiveToJson(PostArchive instance) => <String, dynamic>{
      'year': instance.year,
      'month': instance.month,
      'posts': instance.posts,
    };
