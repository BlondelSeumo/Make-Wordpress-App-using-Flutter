import 'package:cirilla/constants/assets.dart';
import 'package:cirilla/models/models.dart';
import 'package:json_annotation/json_annotation.dart';

import 'post_category.dart';
import 'post_title.dart';

part 'post.g.dart';

@JsonSerializable()
class Post {
  int id;

  int author;

  @JsonKey(name: 'post_title')
  String postTitle;

  PostTitle title;

  PostTitle excerpt;

  PostTitle content;

  String date;

  String link;

  String format;

  @JsonKey(fromJson: _imageFromJson)
  String image;

  @JsonKey(fromJson: _imageFromJson)
  String thumb;

  @JsonKey(name: 'thumb_medium', fromJson: _imageFromJson)
  String thumbMedium;

  List<int> tags;

  @JsonKey(name: 'post_categories', fromJson: _toList)
  List<PostCategory> postCategories;

  @JsonKey(name: 'post_tags')
  List<PostTag> postTags;

  @JsonKey(name: 'post_comment_count')
  int postCommentCount;

  @JsonKey(name: 'post_author')
  String postAuthor;

  List<dynamic> blocks;

  Post(
      {this.id,
      this.author,
      this.title,
      this.excerpt,
      this.content,
      this.date,
      this.link,
      this.format,
      this.image,
      this.thumb,
      this.tags,
      this.postCategories,
      this.postTags,
      this.postCommentCount,
      this.postAuthor,
      this.blocks});

  static String _imageFromJson(dynamic value) =>
      value == null || value == false || value == "" ? Assets.noImageUrl : value as String;

  static List<PostCategory> _toList(List<dynamic> data) {
    List<PostCategory> _categories = <PostCategory>[];

    if (data == null) return _categories;

    _categories = data.map((d) => PostCategory.fromJson(d)).toList().cast<PostCategory>();

    return _categories;
  }

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  Map<String, dynamic> toJson() => _$PostToJson(this);
}
