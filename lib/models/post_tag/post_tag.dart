import 'package:json_annotation/json_annotation.dart';

part 'post_tag.g.dart';

@JsonSerializable()
class PostTag {
  int id;
  String name;
  String slug;
  String description;
  String link;
  String taxonomy;
  List meta;
  int count;

  PostTag({
    this.id,
    this.name,
    this.slug,
    this.description,
    this.link,
    this.taxonomy,
    this.meta,
    this.count,
  });

  factory PostTag.fromJson(Map<String, dynamic> json) => _$PostTagFromJson(json);
  Map<String, dynamic> toJson() => _$PostTagToJson(this);
}
