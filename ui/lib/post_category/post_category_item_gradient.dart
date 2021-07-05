import 'package:flutter/material.dart';
import 'post_category_item.dart';

class PostCategoryItemGradient extends PostCategoryItem {
  /// Link url image PostCategory
  final Widget image;

  /// widget title PostCategory
  final Widget title;

  /// widget count PostCategory
  final Widget? count;

  /// gradient of item
  final Gradient? gradient;

  /// opacity of item
  final double opacity;

  /// width of item
  final double width;

  /// Function onClick PostCategory
  final Function? onClick;

  /// Border shape item post
  final ShapeBorder? shape;

  /// Color Card of item post
  final Color? color;

  /// elevation item post
  final double? elevation;

  /// color shadow of item post
  final Color? shadowColor;

  PostCategoryItemGradient({
    Key? key,
    required this.image,
    required this.title,
    this.count,
    this.gradient,
    this.opacity = 0.8,
    this.width = 300,
    this.onClick,
    this.shadowColor,
    this.elevation,
    this.color,
    this.shape = const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
  }) : super(
          key: key,
          shadowColor: shadowColor,
          elevation: elevation,
          color: color,
          shape: shape,
        );

  @override
  Widget buildLayout(BuildContext context) {
    return InkResponse(
      onTap: () => onClick?.call() ?? null,
      child: SizedBox(
        width: width,
        child: Stack(
          children: [
            image,
            // Opacity(
            //   opacity: opacity,
            //   child: ,
            // ),
            Positioned(
              top: 0,
              bottom: 0,
              left: 0,
              right: 0,
              child: Opacity(
                opacity: opacity,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: gradient ??
                        LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: [0.0, 1],
                          colors: [Colors.transparent, Colors.black],
                        ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 16,
              left: 16,
              bottom: 16,
              right: 16,
              child: Container(
                alignment: Alignment.bottomLeft,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(child: title),
                    if (count is Widget)
                      Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: count,
                      )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
