import 'package:flutter/material.dart';
import 'product_item.dart';

/// A post widget display full width on the screen
///
class ProductCardItem extends ProductItem {
  /// Widget image
  final Widget image;

  /// Widget name. It must required
  final Widget name;

  /// Widget price
  final Widget price;

  /// Widget attributes
  final Widget? attribute;

  /// Widget button quantity
  final Widget? quantity;

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

  /// delete
  final Widget? remove;

  /// Create Product Card Item
  const ProductCardItem({
    Key? key,
    required this.image,
    required this.name,
    required this.onClick,
    required this.price,
    this.quantity,
    this.attribute,
    this.boxShadow,
    this.border,
    this.color = Colors.transparent,
    this.borderRadius,
    this.remove,
    this.padding = EdgeInsets.zero,
  }) : super(
          key: key,
          color: color,
          border: border,
          borderRadius: borderRadius,
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
                        child: name,
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      price,
                    ],
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: attribute ?? Container(),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          quantity ?? Container(),
                          SizedBox(
                            height: 16,
                          ),
                          remove ?? Container(),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
