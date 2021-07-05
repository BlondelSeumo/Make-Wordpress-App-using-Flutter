import 'package:json_annotation/json_annotation.dart';

part 'post_author.g.dart';

@JsonSerializable()
class PostAuthor {
  int id;
  String name;
  String url;
  String description;
  String link;
  String slug;
  @JsonKey(name: 'avatar_urls')
  Avatar avatar;
  List meta;
  @JsonKey(name: 'count_posts')
  int count;

  PostAuthor({
    this.id,
    this.name,
    this.url,
    this.description,
    this.link,
    this.slug,
    this.avatar,
    this.meta,
    this.count,
  });

  factory PostAuthor.fromJson(Map<String, dynamic> json) => _$PostAuthorFromJson(json);
  Map<String, dynamic> toJson() => _$PostAuthorToJson(this);
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
