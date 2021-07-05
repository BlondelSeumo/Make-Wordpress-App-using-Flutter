import 'package:flutter/material.dart';

/// A post widget display full width on the screen
///
class PostTimeLineItem extends StatelessWidget {
  static double widthLeft = 74;

  /// Widget image
  final Widget image;

  /// Widget name. It must required
  final Widget name;

  /// Widget category
  final Widget? category;

  /// Widget info heading
  final Widget? headingInfo;

  /// Widget description
  final Widget? description;

  /// Widget left
  final Widget? left;

  /// Function click item
  final Function onClick;

  /// Border of item post
  final Border? border;

  /// Color Card of item post
  final Color? color;

  /// Border of item post
  final BorderRadius? borderRadius;

  /// shadow card
  final List<BoxShadow>? boxShadow;

  /// Create Post Contained Item
  const PostTimeLineItem({
    Key? key,
    required this.image,
    required this.name,
    required this.onClick,
    this.category,
    this.description,
    this.headingInfo,
    this.left,
    this.color,
    this.borderRadius,
    this.border,
    this.boxShadow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: headingInfo ?? Container()),
            if (category != null)
              Padding(
                padding: EdgeInsets.only(left: 16),
                child: category ?? Container(),
              )
          ],
        ),
        SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (left != null) SizedBox(width: widthLeft, child: left ?? Container()),
            Expanded(
              child: InkWell(
                onTap: () => onClick(),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: color ?? Theme.of(context).cardColor,
                    border: border,
                    borderRadius: borderRadius ??
                        BorderRadius.only(
                          topLeft: Radius.circular(8),
                          bottomLeft: Radius.circular(8),
                        ),
                    boxShadow: boxShadow ??
                        [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            offset: Offset(0, 4),
                            blurRadius: 0.08,
                            spreadRadius: 24,
                          )
                        ],
                  ),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      image,
                      SizedBox(height: 16),
                      name,
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
