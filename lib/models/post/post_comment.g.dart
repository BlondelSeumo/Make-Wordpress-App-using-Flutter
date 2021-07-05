// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostComment _$PostCommentFromJson(Map<String, dynamic> json) {
  return PostComment(
    id: json['id'] as int,
    author: json['author'] as int,
    authorEmail: json['author_email'] as String,
    authorName: json['author_name'] as String,
    authorUrl: json['author_url'] as String,
    content: json['content'] == null ? null : PostTitle.fromJson(json['content'] as Map<String, dynamic>),
    date: json['date'] as String,
    dateGmt: json['date_gmt'] as String,
    parent: json['parent'] as int,
    post: json['post'] as int,
    postData: json['post_data'] as Map<String, dynamic>,
    status: json['status'] as String,
    type: json['type'] as String,
    children: PostComment.hasChildren(json['_links'] as Map),
  )..avatar =
      json['author_avatar_urls'] == null ? null : Avatar.fromJson(json['author_avatar_urls'] as Map<String, dynamic>);
}

Map<String, dynamic> _$PostCommentToJson(PostComment instance) => <String, dynamic>{
      'id': instance.id,
      'author': instance.author,
      'author_email': instance.authorEmail,
      'author_name': instance.authorName,
      'author_url': instance.authorUrl,
      'content': instance.content,
      'date': instance.date,
      'date_gmt': instance.dateGmt,
      'parent': instance.parent,
      'post': instance.post,
      'status': instance.status,
      'type': instance.type,
      'post_data': instance.postData,
      'author_avatar_urls': instance.avatar,
      '_links': instance.children,
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
