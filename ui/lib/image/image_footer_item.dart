import 'package:flutter/material.dart';

class ImageFooterItem extends StatelessWidget {
  final Widget image;
  final Widget? title;
  final Widget? subTitle;
  final Widget footer;
  final CrossAxisAlignment crossAxisAlignment;
  final double width;
  final EdgeInsets padding;
  final GestureTapCallback? onTap;

  ImageFooterItem({
    Key? key,
    required this.image,
    required this.footer,
    this.title,
    this.subTitle,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.width = double.infinity,
    this.padding = const EdgeInsets.all(16),
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
              crossAxisAlignment: crossAxisAlignment,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: crossAxisAlignment,
                    children: [
                      title ?? Container(),
                      subTitle ?? Container(),
                    ],
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                footer,
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
