import 'package:flutter/material.dart';

class ImageAlignmentItem extends StatelessWidget {
  final Widget image;
  final Widget? title;
  final Widget? leading;
  final Widget? trailing;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final double width;
  final EdgeInsets padding;
  final GestureTapCallback? onTap;

  ImageAlignmentItem({
    Key? key,
    required this.image,
    this.title,
    this.leading,
    this.trailing,
    this.width = double.infinity,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.padding = const EdgeInsets.all(12),
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget itemWidget = Stack(
      children: [
        image,
        Positioned(
          top: 0,
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            padding: padding,
            child: Column(
              mainAxisAlignment: mainAxisAlignment,
              crossAxisAlignment: crossAxisAlignment,
              children: [
                if (leading != null) leading ?? Container(),
                if (title != null) title ?? Container(),
                if (trailing != null) trailing ?? Container(),
              ],
            ),
          ),
        )
      ],
    );

    return SizedBox(
      width: width,
      child: onTap != null
          ? GestureDetector(
              onTap: onTap,
              child: itemWidget,
            )
          : itemWidget,
    );
  }
}
