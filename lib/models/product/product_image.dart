import 'package:json_annotation/json_annotation.dart';

part 'product_image.g.dart';

@JsonSerializable()
class ProductImage {
  int id;

  String src;

  String name;

  @JsonKey(name: 'woocommerce_thumbnail')
  String woocommerceThumbnail;

  @JsonKey(name: 'woocommerce_single')
  String woocommerceSingle;

  @JsonKey(name: 'woocommerce_gallery_thumbnail')
  String woocommerceGalleryThumbnail;

  @JsonKey(name: 'shop_catalog')
  String shopCatalog;

  @JsonKey(name: 'shop_single')
  String shopSingle;

  @JsonKey(name: 'shop_thumbnail')
  String shopThumbnail;

  ProductImage({
    this.id,
    this.src,
    this.name,
    this.woocommerceThumbnail,
    this.woocommerceSingle,
    this.woocommerceGalleryThumbnail,
    this.shopCatalog,
    this.shopSingle,
    this.shopThumbnail,
  });

  factory ProductImage.fromJson(Map<String, dynamic> json) => _$ProductImageFromJson(json);

  Map<String, dynamic> toJson() => _$ProductImageToJson(this);
}
