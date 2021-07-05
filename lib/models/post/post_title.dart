import 'package:json_annotation/json_annotation.dart';

part 'post_title.g.dart';

@JsonSerializable()
class PostTitle {
  String rendered;

  @JsonKey(defaultValue: false)
  bool protected;

  PostTitle({
    this.rendered,
    this.protected,
  });

  factory PostTitle.fromJson(Map<String, dynamic> json) => _$PostTitleFromJson(json);

  Map<String, dynamic> toJson() => _$PostTitleToJson(this);
}
