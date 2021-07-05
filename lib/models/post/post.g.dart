// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) {
  return Post(
    id: json['id'] as int,
    author: json['author'] as int,
    title: json['title'] == null ? null : PostTitle.fromJson(json['title'] as Map<String, dynamic>),
    excerpt: json['excerpt'] == null ? null : PostTitle.fromJson(json['excerpt'] as Map<String, dynamic>),
    content: json['content'] == null ? null : PostTitle.fromJson(json['content'] as Map<String, dynamic>),
    date: json['date'] as String,
    link: json['link'] as String,
    format: json['format'] as String,
    image: Post._imageFromJson(json['image']),
    thumb: Post._imageFromJson(json['thumb']),
    tags: (json['tags'] as List)?.map((e) => e as int)?.toList(),
    postCategories: Post._toList(json['post_categories'] as List),
    postTags: (json['post_tags'] as List)
        ?.map((e) => e == null ? null : PostTag.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    postCommentCount: json['post_comment_count'] as int,
    postAuthor: json['post_author'] as String,
    blocks: json['blocks'] as List,
  )
    ..postTitle = json['post_title'] as String
    ..thumbMedium = Post._imageFromJson(json['thumb_medium']);
}

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'id': instance.id,
      'author': instance.author,
      'post_title': instance.postTitle,
      'title': instance.title,
      'excerpt': instance.excerpt,
      'content': instance.content,
      'date': instance.date,
      'link': instance.link,
      'format': instance.format,
      'image': instance.image,
      'thumb': instance.thumb,
      'thumb_medium': instance.thumbMedium,
      'tags': instance.tags,
      'post_categories': instance.postCategories,
      'post_tags': instance.postTags,
      'post_comment_count': instance.postCommentCount,
      'post_author': instance.postAuthor,
      'blocks': instance.blocks,
    };
