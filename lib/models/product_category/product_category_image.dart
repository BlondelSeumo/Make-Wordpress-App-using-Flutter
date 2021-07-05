import 'package:json_annotation/json_annotation.dart';

part 'product_category_image.g.dart';

@JsonSerializable()
class ProductCategoryImage {
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

  ProductCategoryImage({
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

  factory ProductCategoryImage.fromJson(Map<String, dynamic> json) => _$ProductCategoryImageFromJson(json);

  Map<String, dynamic> toJson() => _$ProductCategoryImageToJson(this);

  String values(String key) {
    if (key == 'woocommerceThumbnail') {
      return woocommerceThumbnail;
    }

    if (key == 'woocommerceSingle') {
      return woocommerceSingle;
    }

    if (key == 'woocommerceGalleryThumbnail') {
      return woocommerceGalleryThumbnail;
    }

    if (key == 'shopCatalog') {
      return shopCatalog;
    }

    if (key == 'shopSingle') {
      return shopSingle;
    }

    if (key == 'shopThumbnail') {
      return shopThumbnail;
    }

    return src;
  }
}
