import 'package:cirilla/models/models.dart';
import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

class PostImage extends StatelessWidget {
  final Post post;
  final double width;
  final double height;

  PostImage({Key key, this.post, this.width, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ImageLoading(
      post.image,
      width: width,
      height: height,
    );
  }
}
