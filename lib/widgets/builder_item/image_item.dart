import 'package:cirilla/constants/assets.dart';
import 'package:flutter/material.dart';
import 'package:ui/image/image_loading.dart';

class ImageItem extends StatelessWidget {
  final String url;
  final Size size;
  final BoxFit fit;

  ImageItem({
    Key key,
    this.url,
    this.fit = BoxFit.cover,
    this.size = const Size(100, 100),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (url is String && url != '') {
      return ImageLoading(
        url,
        width: size.width,
        height: size.height,
        fit: fit,
      );
    }
    return Image.asset(
      Assets.noImage,
      width: size.width,
      height: size.height,
      fit: fit,
    );
  }
}
