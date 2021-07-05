import 'package:flutter/material.dart';
import 'product_item.dart';

enum ProductVerticalItemType { auto, center }

/// A post widget display full width on the screen
///
class ProductVerticalItem extends ProductItem {
  /// Widget image
  final Widget image;

  /// Widget name. It must required
  final Widget name;

  /// Widget price
  final Widget price;

  /// Widget category
  final Widget category;

  /// Widget rating
  final Widget? rating;

  /// Widget wishlist
  final Widget? wishlist;

  /// Widget button Add card
  final Widget? addCard;

  /// Widget extra tags in information
  final Widget? tagExtra;

  /// Widget dots
  final Widget? dots;

  /// Width item
  final double width;

  /// Type of item
  final ProductVerticalItemType type;

  /// Function click item
  final Function onClick;

  /// shadow card
  final List<BoxShadow>? boxShadow;

  /// Border of item post
  final Border? border;

  /// Color Card of item post
  final Color? color;

  /// Border of item post
  final BorderRadius? borderRadius;

  /// Create Product Vertical Item
  const ProductVerticalItem({
    Key? key,
    required this.image,
    required this.name,
    required this.onClick,
    required this.price,
    required this.category,
    this.rating,
    this.wishlist,
    this.addCard,
    this.tagExtra,
    this.dots,
    this.type = ProductVerticalItemType.auto,
    this.width = 300,
    this.boxShadow,
    this.borderRadius,
    this.border,
    this.color = Colors.transparent,
  }) : super(
          key: key,
          border: border,
          borderRadius: borderRadius,
          boxShadow: boxShadow,
          color: color,
        );

  @override
  Widget buildLayout(BuildContext context) {
    if (type == ProductVerticalItemType.center) {
      return SizedBox(
        width: width,
        child: InkWell(
          onTap: () => onClick(),
          child: Column(
            children: [
              Stack(
                children: [
                  image,
                  Positioned(
                    top: 8,
                    left: 8,
                    right: 8,
                    bottom: 8,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: tagExtra ?? Container(),
                        ),
                        if (wishlist != null) SizedBox(width: 12),
                        wishlist ?? Container(),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: 16),
              rating ?? Container(),
              if (rating != null) SizedBox(height: 8),
              category,
              name,
              SizedBox(height: 8),
              price,
              SizedBox(height: 8),
              dots ?? buildListDot(),
              if (addCard != null) SizedBox(height: 24),
              addCard ?? Container(),
            ],
          ),
        ),
      );
    }
    return SizedBox(
      width: width,
      child: InkWell(
        onTap: () => onClick(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                image,
                Positioned(
                  top: 8,
                  left: 8,
                  right: 8,
                  bottom: 8,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: tagExtra ?? Container(),
                      ),
                      if (addCard != null) SizedBox(width: 12),
                      addCard ?? Container(),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: rating ?? Container()),
                if (wishlist != null) SizedBox(width: 12),
                wishlist ?? Container(),
              ],
            ),
            SizedBox(height: 5),
            category,
            name,
            SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: price,
                ),
                SizedBox(width: 12),
                dots ?? buildListDot(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildListDot() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        buildDot(color: Color(0xFF20C997)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: buildDot(color: Color(0xFFDD4B39)),
        ),
        buildDot(color: Color(0xFFFFA200)),
      ],
    );
  }

  Widget buildDot({Color color = Colors.black}) {
    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}
