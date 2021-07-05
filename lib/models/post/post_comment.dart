import 'package:json_annotation/json_annotation.dart';

import 'post_title.dart';

part 'post_comment.g.dart';

@JsonSerializable()
class PostComment {
  int id;

  int author;

  @JsonKey(name: 'author_email')
  String authorEmail;

  @JsonKey(name: 'author_name')
  String authorName;

  @JsonKey(name: 'author_url')
  String authorUrl;

  PostTitle content;

  String date;

  @JsonKey(name: 'date_gmt')
  String dateGmt;

  int parent;

  int post;

  String status;

  String type;
  @JsonKey(name: 'post_data')
  Map<String, dynamic> postData;

  @JsonKey(name: 'author_avatar_urls')
  Avatar avatar;

  @JsonKey(name: '_links', fromJson: hasChildren)
  bool children;

  PostComment({
    this.id,
    this.author,
    this.authorEmail,
    this.authorName,
    this.authorUrl,
    this.content,
    this.date,
    this.dateGmt,
    this.parent,
    this.post,
    this.postData,
    this.status,
    this.type,
    this.children,
  });

  factory PostComment.fromJson(Map<String, dynamic> json) => _$PostCommentFromJson(json);

  Map<String, dynamic> toJson() => _$PostCommentToJson(this);

  static hasChildren(Map _links) => _links['children'] != null;
}

@JsonSerializable()
class Avatar {
  @JsonKey(name: '24')
  String small;
  @JsonKey(name: '48')
  String medium;
  @JsonKey(name: '96')
  String large;

  Avatar({
    this.small,
    this.medium,
    this.large,
  });

  factory Avatar.fromJson(Map<String, dynamic> json) => _$AvatarFromJson(json);

  Map<String, dynamic> toJson() => _$AvatarToJson(this);
}
