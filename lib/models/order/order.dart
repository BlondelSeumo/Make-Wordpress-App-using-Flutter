import 'package:json_annotation/json_annotation.dart';

part 'order.g.dart';

@JsonSerializable()
class OrderData {
  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'parent_id')
  int parentId;

  @JsonKey(name: 'shipping_total')
  String shippingTotal;

  @JsonKey(name: 'shipping_tax')
  String shippingTax;

  @JsonKey(name: 'discount_total')
  String discountTotal;

  @JsonKey(name: 'discount_tax')
  String discountTax;

  @JsonKey(name: 'currency_symbol')
  String currencySymbol;

  @JsonKey(name: 'payment_method')
  String paymentMethod;

  @JsonKey(name: 'date_created')
  String dateCreated;

  @JsonKey(name: 'line_items')
  List<LineItems> lineItems;

  Map<String, dynamic> billing;

  String total;

  String status;

  String currency;

  OrderData(
      {this.id,
      this.parentId,
      this.status,
      this.dateCreated,
      this.shippingTotal,
      this.shippingTax,
      this.discountTax,
      this.discountTotal,
      this.total,
      this.currencySymbol,
      this.currency,
      this.paymentMethod});

  factory OrderData.fromJson(Map<String, dynamic> json) => _$OrderDataFromJson(json);

  Map<String, dynamic> toJson() => _$OrderDataToJson(this);

  static List<LineItems> toList(List<dynamic> data) {
    List<LineItems> _lineItems = <LineItems>[];

    if (data == null) return _lineItems;

    _lineItems = data.map((d) => LineItems.fromJson(d)).toList().cast<LineItems>();
    return _lineItems;
  }
}

@JsonSerializable()
class LineItems {
  @JsonKey(name: 'meta_data')
  List<Map<String, dynamic>> metaData;

  String name;

  int quantity;

  int price;

  String subtotal;

  String sku;
  LineItems({
    this.name,
    this.quantity,
    this.price,
    this.subtotal,
    this.metaData,
    this.sku,
  });

  factory LineItems.fromJson(Map<String, dynamic> json) => _$LineItemsFromJson(json);

  Map<String, dynamic> toJson() => _$LineItemsToJson(this);
}
