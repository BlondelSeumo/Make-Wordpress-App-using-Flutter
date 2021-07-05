import 'package:flutter/material.dart';
import 'product_item.dart';

/// A post widget display full width on the screen
///
class ProductGroupedItem extends ProductItem {
  /// Widget name. It must required
  final Widget name;

  /// Widget price
  final Widget price;

  /// Widget quantity
  final Widget quantity;

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
  const ProductGroupedItem({
    Key? key,
    required this.name,
    required this.onClick,
    required this.price,
    required this.quantity,
    this.borderRadius,
    this.border,
    this.color,
    this.boxShadow,
    this.padding = const EdgeInsets.all(16),
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
          children: [
            quantity,
            SizedBox(width: 16),
            Expanded(
              child: name,
            ),
            SizedBox(width: 16),
            price,
          ],
        ),
      ),
    );
  }
}
