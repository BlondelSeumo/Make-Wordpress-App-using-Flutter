import 'package:json_annotation/json_annotation.dart';

part 'post_archive.g.dart';

@JsonSerializable()
class PostArchive {
  String year;

  String month;

  String posts;

  PostArchive({
    this.year,
    this.month,
    this.posts,
  });

  factory PostArchive.fromJson(Map<String, dynamic> json) => _$PostArchiveFromJson(json);

  Map<String, dynamic> toJson() => _$PostArchiveToJson(this);
}
