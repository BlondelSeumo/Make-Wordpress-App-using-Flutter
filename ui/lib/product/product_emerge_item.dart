import 'package:flutter/material.dart';

import 'product_item.dart';

/// A post widget display full width on the screen
///
class ProductEmergeItem extends ProductItem {
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

  /// Width item
  final double width;

  /// Distance to button add card emerge on image
  final double? bottom;

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

  /// Create Product Emerge Item
  const ProductEmergeItem({
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
    this.bottom,
    this.width = 300,
    this.boxShadow,
    this.border,
    this.borderRadius,
    this.color = Colors.transparent,
  }) : super(
          key: key,
          color: color,
          border: border,
          borderRadius: borderRadius,
          boxShadow: boxShadow,
        );

  @override
  Widget buildLayout(BuildContext context) {
    return SizedBox(
      width: width,
      child: InkWell(
        onTap: () => onClick(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: bottom ?? 17),
                  child: image,
                ),
                Positioned(
                  top: 8,
                  left: 8,
                  right: 8,
                  bottom: 0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      tagExtra ?? Container(),
                      Container(
                        alignment: Alignment.centerRight,
                        child: addCard,
                      )
                    ],
                  ),
                )
              ],
            ),
            rating ?? Container(),
            SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      category,
                      name,
                      SizedBox(height: 8),
                      price,
                    ],
                  ),
                ),
                if (wishlist != null) SizedBox(width: 5),
                wishlist ?? Container()
              ],
            ),
          ],
        ),
      ),
    );
  }
}
