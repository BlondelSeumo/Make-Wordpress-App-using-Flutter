import 'package:json_annotation/json_annotation.dart';

import 'product_image.dart';
import 'product_category.dart';
import 'product_price_format.dart';
import 'product_type.dart';

part 'product.g.dart';

@JsonSerializable(createToJson: false)
class Product {
  int id;

  String name;

  String slug;

  ProductType type;

  String status;

  String description;

  @JsonKey(name: 'short_description')
  String shortDescription;

  List<ProductImage> images;

  List<ProductCategory> categories;

  String price;

  @JsonKey(name: 'regular_price')
  String regularPrice;

  @JsonKey(name: 'sale_price')
  String salePrice;

  @JsonKey(name: 'on_sale')
  bool onSale;

  @JsonKey(name: 'date_created')
  String date;

  @JsonKey(name: 'average_rating')
  String averageRating;

  @JsonKey(name: 'rating_count')
  int ratingCount;

  @JsonKey(name: 'format_price')
  ProductPriceFormat formatPrice;

  @JsonKey(name: 'catalog_visibility')
  String catalogVisibility;

  @JsonKey(name: 'stock_status')
  String stockStatus;

  @JsonKey(name: 'stock_quantity', defaultValue: 0)
  int stockQuantity;

  @JsonKey(name: 'related_ids')
  List<int> relatedIds;

  @JsonKey(name: 'grouped_products')
  List<int> groupedIds;

  @JsonKey(name: 'external_url')
  String externalUrl;

  @JsonKey(name: 'permalink')
  String permalink;

  @JsonKey(name: 'button_text')
  String buttonText;

  bool purchasable;

  List<Map<String, dynamic>> attributes;

  @JsonKey(nullable: true)
  Map<String, dynamic> store;

  @JsonKey(name: 'multi-currency-prices')
  Map<String, dynamic> multiCurrencyPrices;

  @JsonKey(name: 'from-multi-currency-prices')
  Map<String, dynamic> fromMultiCurrencyPrices;

  Product({
    this.id,
    this.name,
    this.slug,
    this.type,
    this.status,
    this.description,
    this.shortDescription,
    this.images,
    this.price,
    this.regularPrice,
    this.salePrice,
    this.onSale,
    this.date,
    this.averageRating,
    this.ratingCount,
    this.formatPrice,
    this.catalogVisibility,
    this.stockStatus,
    this.stockQuantity,
    this.relatedIds,
    this.groupedIds,
    this.categories,
    this.externalUrl,
    this.buttonText,
    this.purchasable,
    this.store,
    this.attributes,
  });

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);

  factory Product.fromVariation(Map<String, dynamic> json) => _$ProductFromVariation(json);
}

Product _$ProductFromVariation(Map<String, dynamic> json) {
  return Product(
    id: json['variation_id'] as int,
    regularPrice: json['display_regular_price'].toString(),
    salePrice: json['display_price'].toString(),
    onSale: json['display_regular_price'] != json['display_price'],
    images: List.generate(
      1,
      (index) => json['image'] != null
          ? ProductImage(
              id: json['image_id'],
              name: json['image']['title'],
              src: json['image']['src'],
              shopCatalog: json['image']['thumb_src'],
              shopSingle: json['image']['src'],
              shopThumbnail: json['image']['thumb_src'],
              woocommerceGalleryThumbnail: json['image']['gallery_thumbnail_src'],
              woocommerceSingle: json['image']['src'],
              woocommerceThumbnail: json['image']['thumb_src'],
            )
          : [],
    ),
  );
}

class ProductBlocks {
  ProductBlocks._();

  static const String Category = 'Category';
  static const String Name = 'Name';
  static const String Rating = 'Rating';
  static const String Price = 'Price';
  static const String Status = 'Status';
  static const String Type = 'Type';
  static const String Quantity = 'Quantity';
  static const String SortDescription = 'SortDescription';
  static const String Description = 'Description';
  static const String AdditionInformation = 'AdditionInformation';
  static const String Review = 'Review';
  static const String RelatedProduct = 'RelatedProduct';
  static const String AddToCart = 'AddToCart';
  static const String Action = 'Action';
  static const String Custom = 'Custom';
}
