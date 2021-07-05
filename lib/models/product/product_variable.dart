import 'package:json_annotation/json_annotation.dart';

part 'product_variable.g.dart';

@JsonSerializable()
class ProductVariable {
  @JsonKey(name: 'attribute_ids')
  Map<String, int> ids;

  @JsonKey(name: 'attribute_labels')
  Map<String, String> labels;

  @JsonKey(name: 'attribute_terms')
  Map<String, List<String>> terms;

  @JsonKey(name: 'attribute_terms_labels')
  Map<String, String> termsLabels;

  @JsonKey(name: 'variations')
  List<Map<String, dynamic>> variations;

  ProductVariable({
    this.ids,
    this.labels,
    this.terms,
    this.variations,
  });

  factory ProductVariable.fromJson(Map<String, dynamic> json) => _$ProductVariableFromJson(json);

  Map<String, dynamic> toJson() => _$ProductVariableToJson(this);
}
