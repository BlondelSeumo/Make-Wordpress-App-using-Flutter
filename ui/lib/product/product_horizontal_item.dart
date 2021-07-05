import 'package:flutter/material.dart';
import 'product_item.dart';

/// A post widget display full width on the screen
///
class ProductHorizontalItem extends ProductItem {
  /// Widget image
  final Widget image;

  /// Widget name. It must required
  final Widget name;

  /// Widget price
  final Widget price;

  /// Widget rating
  final Widget? rating;

  /// Widget button Add card
  final Widget? addCard;

  /// Widget extra tags in information
  final Widget? tagExtra;

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

  /// Padding item
  final EdgeInsets padding;

  /// Create Product Horizontal Item
  const ProductHorizontalItem({
    Key? key,
    required this.image,
    required this.name,
    required this.onClick,
    required this.price,
    this.rating,
    this.addCard,
    this.tagExtra,
    this.borderRadius,
    this.border,
    this.color = Colors.transparent,
    this.boxShadow,
    this.padding = EdgeInsets.zero,
  }) : super(
          key: key,
          color: color,
          borderRadius: borderRadius,
          border: border,
          boxShadow: boxShadow,
        );

  @override
  Widget buildLayout(BuildContext context) {
    return InkWell(
      onTap: () => onClick(),
      child: Padding(
        padding: padding,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            image,
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            tagExtra ?? Container(),
                            if (tagExtra != null) SizedBox(height: 12),
                            name,
                            price,
                          ],
                        ),
                      ),
                      if (addCard != null)
                        SizedBox(
                          width: 10,
                        ),
                      addCard ?? Container(),
                    ],
                  ),
                  if (rating != null) SizedBox(height: 8),
                  rating ?? Container(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
