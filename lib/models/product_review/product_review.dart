import 'package:json_annotation/json_annotation.dart';

part 'product_review.g.dart';

@JsonSerializable()
class ProductReview {
  int id;

  @JsonKey(name: 'date_created')
  String dateCreated;

  @JsonKey(name: 'date_created_gmt')
  String dateCreatedGmt;

  @JsonKey(name: 'product_id')
  int productId;

  ProductReviewStatus status;

  String reviewer;

  @JsonKey(name: 'reviewer_email')
  String reviewerEmail;

  String review;

  int rating;

  bool verified;

  @JsonKey(name: 'reviewer_avatar_urls')
  Map<String, String> reviewerAvatarUrls;

  ProductReview({
    this.id,
    this.dateCreated,
    this.dateCreatedGmt,
    this.productId,
    this.status,
    this.reviewer,
    this.reviewerEmail,
    this.review,
    this.rating,
    this.verified,
  });

  factory ProductReview.fromJson(Map<String, dynamic> json) => _$ProductReviewFromJson(json);

  Map<String, dynamic> toJson() => _$ProductReviewToJson(this);
}

enum ProductReviewStatus {
  all,
  hold,
  approved,
  spam,
  trash,
}

@JsonSerializable()
class RatingCount {
  @JsonKey(name: '1')
  int r1;

  @JsonKey(name: '2')
  int r2;

  @JsonKey(name: '3')
  int r3;

  @JsonKey(name: '4')
  int r4;

  @JsonKey(name: '5')
  int r5;

  RatingCount({
    this.r1,
    this.r2,
    this.r3,
    this.r4,
    this.r5,
  });

  factory RatingCount.fromJson(Map<String, dynamic> json) => _$RatingCountFromJson(json);

  Map<String, dynamic> toJson() => _$RatingCountToJson(this);
}
