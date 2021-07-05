import 'package:json_annotation/json_annotation.dart';

part 'variable.g.dart';

@JsonSerializable()
class Variable {
  @JsonKey(name: 'variation_id')
  int id;
  Map<String, dynamic> attributes;
  @JsonKey(name: 'display_price')
  double price;
  @JsonKey(name: 'display_regular_price')
  double regularPrice;
  @JsonKey(name: 'is_in_stock')
  bool inStock;
  @JsonKey(name: 'is_purchasable')
  bool isPurchasable;

  Variable({
    this.id,
    this.attributes,
    this.price,
    this.regularPrice,
    this.inStock,
    this.isPurchasable,
  });

  factory Variable.fromJson(Map<String, dynamic> json) => _$VariableFromJson(json);
  Map<String, dynamic> toJson() => _$VariableToJson(this);
}
