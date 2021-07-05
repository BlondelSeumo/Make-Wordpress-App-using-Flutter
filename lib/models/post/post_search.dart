import 'package:json_annotation/json_annotation.dart';

part 'post_search.g.dart';

@JsonSerializable()
class PostSearch {
  int id;

  String title;

  String url;

  String type;

  String subtype;

  PostSearch({
    this.id,
    this.title,
    this.url,
    this.type,
    this.subtype,
  });

  factory PostSearch.fromJson(Map<String, dynamic> json) => _$PostSearchFromJson(json);

  Map<String, dynamic> toJson() => _$PostSearchToJson(this);
}
