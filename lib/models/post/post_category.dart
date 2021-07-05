import 'package:json_annotation/json_annotation.dart';

part 'post_category.g.dart';

@JsonSerializable()
class PostCategory {
  int id;

  String name;

  int count;

  int parent;

  String description;

  String slug;

  @JsonKey(name: 'acf', fromJson: _imageFromJson, toJson: _imageToJson)
  String image;

  static String _imageFromJson(dynamic value) => value is Map && value['image'] is String ? value['image'] : '';

  static dynamic _imageToJson(String data) {
    if (data == '') {
      return [];
    }
    return {
      'image': data,
    };
  }

  PostCategory({this.id, this.name, this.count, this.parent, this.description, this.slug});

  factory PostCategory.fromJson(Map<String, dynamic> json) => _$PostCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$PostCategoryToJson(this);
}
