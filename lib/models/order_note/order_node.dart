import 'package:json_annotation/json_annotation.dart';

part 'order_node.g.dart';

@JsonSerializable()
class OrderNode {
  int id;
  String author;
  String note;

  @JsonKey(name: 'date_created')
  String dateCreated;
  OrderNode({
    this.id,
    this.dateCreated,
    this.author,
    this.note,
  });

  factory OrderNode.fromJson(Map<String, dynamic> json) => _$OrderNodeFromJson(json);

  Map<String, dynamic> toJson() => _$OrderNodeToJson(this);
}
