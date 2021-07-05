import 'package:cirilla/utils/convert_data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_prices.g.dart';

@JsonSerializable()
class ProductPrices {
  @JsonKey(name: 'min_price', fromJson: ConvertData.stringToDouble)
  double minPrice;
  @JsonKey(name: 'max_price', fromJson: ConvertData.stringToDouble)
  double maxPrice;

  ProductPrices({
    this.minPrice,
    this.maxPrice,
  });

  factory ProductPrices.fromJson(Map<String, dynamic> json) => _$ProductPricesFromJson(json);

  Map<String, dynamic> toJson() => _$ProductPricesToJson(this);
}
