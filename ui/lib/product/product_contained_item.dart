import 'package:flutter/material.dart';
import 'product_item.dart';

/// A post widget display full width on the screen
///
class ProductContainedItem extends ProductItem {
  /// Widget image
  final Widget image;

  /// Widget name. It must required
  final Widget name;

  /// Widget price
  final Widget price;

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

  /// shadow card
  final List<BoxShadow>? boxShadow;

  /// Border of item post
  final Border? border;

  /// Color Card of item post
  final Color? color;

  /// Border of item post
  final BorderRadius? borderRadius;

  /// Function click item
  final Function onClick;

  /// Create Product Contained Item
  const ProductContainedItem({
    Key? key,
    required this.image,
    required this.name,
    required this.onClick,
    required this.price,
    this.rating,
    this.wishlist,
    this.addCard,
    this.tagExtra,
    this.width = 300,
    this.boxShadow,
    this.border,
    this.color = Colors.transparent,
    this.borderRadius,
  }) : super(
          key: key,
          color: color,
          boxShadow: boxShadow,
          border: border,
          borderRadius: borderRadius,
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
                image,
                Positioned(
                  top: 8,
                  left: 8,
                  right: 8,
                  bottom: 8,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: tagExtra ?? Container()),
                          wishlist ?? Container(),
                        ],
                      ),
                      Container(
                        width: double.infinity,
                        alignment: Alignment.centerRight,
                        child: addCard,
                      )
                    ],
                  ),
                )
              ],
            ),
            SizedBox(height: 8),
            name,
            price,
            if (rating != null)
              SizedBox(
                height: 8,
              ),
            rating ?? Container(),
          ],
        ),
      ),
    );
  }
}
