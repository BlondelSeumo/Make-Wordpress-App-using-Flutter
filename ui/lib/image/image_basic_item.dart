import 'package:flutter/material.dart';

class ImageBasicItem extends StatelessWidget {
  final Widget image;
  final Widget? title;
  final Widget? leading;
  final Widget? button;
  final double width;
  final EdgeInsets padding;

  ImageBasicItem({
    Key? key,
    required this.image,
    this.title,
    this.leading,
    this.button,
    this.width = double.infinity,
    this.padding = const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Stack(
        children: [
          image,
          Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: padding,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        if (leading != null) leading ?? Container(),
                        if (title != null) title ?? Container(),
                        // if (trailing != null) trailing ?? Container(),
                      ],
                    ),
                  ),
                  if (button is Widget)
                    Padding(
                      padding: EdgeInsetsDirectional.only(start: 16),
                      child: button ?? Container(),
                    ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
