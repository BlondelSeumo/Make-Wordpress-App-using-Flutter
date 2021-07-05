import 'package:flutter/material.dart';
import 'icon_box_item.dart';

enum IconBoxHorizontalItemType { style1, style2 }

class IconBoxHorizontalItem extends IconBoxItem {
  /// Widget image
  final Widget icon;

  /// Widget title
  final Widget title;

  /// Widget description
  final Widget description;

  /// type item{style1, style2}
  final IconBoxHorizontalItemType type;

  /// Width item
  final double? width;

  /// max Width item
  final double? maxWidth;

  /// height item
  final double? height;

  /// Padding item
  final EdgeInsets paddingContent;

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

  IconBoxHorizontalItem({
    Key? key,
    required this.icon,
    required this.title,
    required this.description,
    this.type = IconBoxHorizontalItemType.style1,
    this.width,
    this.height,
    this.maxWidth,
    this.paddingContent = const EdgeInsets.all(24),
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
    return onClick != null
        ? InkWell(
            onTap: () => onClick?.call() ?? print('click'),
            child: buildItem(),
          )
        : buildItem();
  }

  Widget buildItem() {
    if (type == IconBoxHorizontalItemType.style2) {
      return Container(
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  icon,
                  SizedBox(width: 24),
                  Flexible(
                    child: title,
                  ),
                ],
              ),
              SizedBox(height: 16),
              description,
            ],
          ),
        ),
      );
    }
    return Container(
      width: width,
      height: height,
      constraints: !(width is double)
          ? BoxConstraints(
              maxWidth: maxWidth ?? 280,
            )
          : null,
      child: Padding(
        padding: paddingContent,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            icon,
            SizedBox(width: 24),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  title,
                  SizedBox(height: 16),
                  description,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
