import 'package:flutter/material.dart';

class ImageVerticalItem extends StatelessWidget {
  final Widget image;
  final Widget? title;
  final double width;
  final GestureTapCallback? onTap;

  ImageVerticalItem({
    Key? key,
    required this.image,
    this.title,
    this.width = double.infinity,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            image,
            if (title is Widget) ...[
              SizedBox(height: 8),
              title ?? Container(),
            ]
          ],
        ),
      ),
    );
  }
}
