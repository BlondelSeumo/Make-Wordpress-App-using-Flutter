import 'package:flutter/material.dart';

class Badge extends StatelessWidget {
  final Text text;
  final Color? color;
  final double size;
  final Icon? icon;
  final Icon? rightIcon;
  final TextStyle? textStyle;
  final EdgeInsets padding;
  final GestureTapCallback? onTap;
  final double? radius;

  Badge({
    Key? key,
    required this.text,
    this.color,
    this.size = 19,
    this.radius,
    this.icon,
    this.rightIcon,
    this.textStyle,
    this.padding = const EdgeInsets.symmetric(horizontal: 8),
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String textTitle = text.data ?? '';
    EdgeInsets paddingContent = icon != null || rightIcon != null || textTitle.length > 1 ? padding : EdgeInsets.zero;

    Widget renderContainer = Container(
      height: size,
      decoration: BoxDecoration(
        color: color ?? Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(radius ?? size / 2),
      ),
      constraints: BoxConstraints(minWidth: size),
      padding: paddingContent,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) ...[
            buildIcon(icon: icon ?? Icon(Icons.description), color: textStyle?.color),
            SizedBox(width: 4),
          ],
          text,
          if (rightIcon != null) ...[
            SizedBox(width: 4),
            buildIcon(icon: rightIcon ?? Icon(Icons.description), color: textStyle?.color),
          ],
        ],
      ),
    );
    if (onTap != null) {
      return GestureDetector(
        onTap: onTap,
        child: renderContainer,
      );
    }
    return renderContainer;
  }

  Icon buildIcon({required Icon icon, Color? color}) {
    Color colorIcon = color ?? Colors.white;
    return Icon(
      icon.icon,
      size: icon.size ?? 14,
      color: icon.color ?? colorIcon,
      semanticLabel: icon.semanticLabel,
      textDirection: icon.textDirection,
    );
  }
}

class BadgeIcon extends StatelessWidget {
  final Color color;
  final double size;
  final Icon? icon;
  final EdgeInsets padding;
  final GestureTapCallback? onTap;

  BadgeIcon({
    Key? key,
    required this.icon,
    this.color = Colors.black,
    this.size = 19,
    this.padding = const EdgeInsets.symmetric(horizontal: 8),
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget renderContainer = Container(
      height: size,
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(size / 2)),
      constraints: BoxConstraints(minWidth: size),
      padding: padding,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildIcon(icon: icon ?? Icon(Icons.description)),
        ],
      ),
    );
    if (onTap != null) {
      return GestureDetector(
        onTap: onTap,
        child: renderContainer,
      );
    }
    return renderContainer;
  }

  Icon buildIcon({required Icon icon}) {
    return Icon(
      icon.icon,
      size: icon.size ?? 14,
      color: icon.color ?? Colors.white,
      semanticLabel: icon.semanticLabel,
      textDirection: icon.textDirection,
    );
  }
}
