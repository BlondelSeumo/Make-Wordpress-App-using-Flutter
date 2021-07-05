import 'package:json_annotation/json_annotation.dart';

part 'cart.g.dart';

@JsonSerializable()
class CartData {
  @JsonKey(name: 'items_count')
  int itemsCount;

  @JsonKey(name: 'items_weight')
  double itemsWeight;

  @JsonKey(name: 'needs_payment')
  bool needsPayment;

  @JsonKey(name: 'needs_shipping')
  bool needsShipping;

  @JsonKey(name: 'has_calculated_shipping')
  bool hasCalculatedShipping;

  @JsonKey(fromJson: toList)
  List<CartItem> items;

  List coupons;

  Map<String, dynamic> totals;

  CartData({
    this.hasCalculatedShipping,
    this.itemsCount,
    this.itemsWeight,
    this.needsPayment,
    this.needsShipping,
  });

  factory CartData.fromJson(Map<String, dynamic> json) => _$CartDataFromJson(json);

  Map<String, dynamic> toJson() => _$CartDataToJson(this);

  static List<CartItem> toList(List<dynamic> data) {
    List<CartItem> _items = <CartItem>[];

    if (data == null) return _items;

    _items = data.map((d) => CartItem.fromJson(d)).toList().cast<CartItem>();

    return _items;
  }
}

@JsonSerializable()
class CartItem {
  String key;

  int id;

  int quantity;

  @JsonKey(name: 'quantity_limit')
  int quantityLimit;

  String name;

  List<Map<String, dynamic>> images;

  List<Map<String, dynamic>> variation;

  Map<String, dynamic> prices;

  CartItem({
    this.key,
    this.id,
    this.quantity,
    this.quantityLimit,
    this.name,
    this.images,
    this.prices,
    this.variation,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) => _$CartItemFromJson(json);

  Map<String, dynamic> toJson() => _$CartItemToJson(this);
}
