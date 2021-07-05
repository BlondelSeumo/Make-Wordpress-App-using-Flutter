import 'package:json_annotation/json_annotation.dart';

import 'product_category_image.dart';

part 'product_category.g.dart';

@JsonSerializable()
class ProductCategory {
  int id;

  String name;

  int parent;

  @JsonKey(fromJson: toList)
  List<ProductCategory> categories;

  String description;

  String display;

  ProductCategoryImage image;

  @JsonKey(name: 'menu_order')
  int menuOrder;

  int count;

  ProductCategory({
    this.id,
    this.name,
    this.parent,
    this.categories,
    this.description,
    this.count,
    this.image,
  });

  factory ProductCategory.fromJson(Map<String, dynamic> json) => _$ProductCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$ProductCategoryToJson(this);

  static List<ProductCategory> toList(List<dynamic> data) {
    List<ProductCategory> _categories = <ProductCategory>[];

    if (data == null) return _categories;

    _categories = data.map((d) => ProductCategory.fromJson(d)).toList().cast<ProductCategory>();

    return _categories;
  }
}
