// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_author.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostAuthor _$PostAuthorFromJson(Map<String, dynamic> json) {
  return PostAuthor(
    id: json['id'] as int,
    name: json['name'] as String,
    url: json['url'] as String,
    description: json['description'] as String,
    link: json['link'] as String,
    slug: json['slug'] as String,
    avatar: json['avatar_urls'] == null ? null : Avatar.fromJson(json['avatar_urls'] as Map<String, dynamic>),
    meta: json['meta'] as List,
    count: json['count_posts'] as int,
  );
}

Map<String, dynamic> _$PostAuthorToJson(PostAuthor instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'url': instance.url,
      'description': instance.description,
      'link': instance.link,
      'slug': instance.slug,
      'avatar_urls': instance.avatar,
      'meta': instance.meta,
      'count_posts': instance.count,
    };

Avatar _$AvatarFromJson(Map<String, dynamic> json) {
  return Avatar(
    small: json['24'] as String,
    medium: json['48'] as String,
    large: json['96'] as String,
  );
}

Map<String, dynamic> _$AvatarToJson(Avatar instance) => <String, dynamic>{
      '24': instance.small,
      '48': instance.medium,
      '96': instance.large,
    };
