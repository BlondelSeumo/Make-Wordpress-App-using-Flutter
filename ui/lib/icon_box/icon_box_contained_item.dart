import 'package:flutter/material.dart';
import 'icon_box_item.dart';

class IconBoxContainedItem extends IconBoxItem {
  /// Widget image
  final Widget icon;

  /// Widget title
  final Widget title;

  /// Widget description
  final Widget description;

  /// Width item
  final double? width;

  /// max Width item
  final double? maxWidth;

  /// height item
  final double? height;

  /// Padding item
  final EdgeInsets paddingContent;

  /// Alignment in horizontal in icon
  final CrossAxisAlignment alignment;

  /// Border Radius Item
  final BorderRadius? borderRadius;

  /// Border Item
  final Border? border;

  /// Border Radius Item
  final List<BoxShadow>? boxShadow;

  /// Color Card of item post
  final Color? color;

  /// Function click item
  final Function? onClick;

  IconBoxContainedItem({
    Key? key,
    required this.icon,
    required this.title,
    required this.description,
    this.width,
    this.maxWidth,
    this.height,
    this.paddingContent = const EdgeInsets.all(24),
    this.alignment = CrossAxisAlignment.start,
    this.onClick,
    this.border,
    this.borderRadius,
    this.boxShadow,
    this.color,
  }) : super(
          key: key,
          color: color,
          border: border,
          borderRadius: borderRadius,
          boxShadow: boxShadow,
        );
  @override
  Widget buildLayout(BuildContext context) {
    Widget itemWidget = Container(
      width: width,
      height: height,
      constraints: !(width is double)
          ? BoxConstraints(
              maxWidth: maxWidth ?? 280,
            )
          : null,
      child: Padding(
        padding: paddingContent,
        child: Column(
          crossAxisAlignment: alignment,
          children: [icon, SizedBox(height: 24), title, SizedBox(height: 16), description],
        ),
      ),
    );
    return onClick != null
        ? InkWell(
            onTap: () => onClick?.call() ?? print('click'),
            child: itemWidget,
          )
        : itemWidget;
  }
}
