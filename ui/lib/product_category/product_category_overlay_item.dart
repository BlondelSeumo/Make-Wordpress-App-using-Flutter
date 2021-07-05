import 'package:flutter/material.dart';

class ProductCategoryOverlayItem extends StatelessWidget {
  final Widget image;
  final Widget? name;
  final Widget? count;
  final Color opacityColor;
  final double opacity;
  final BorderRadius borderRadius;
  final Function onClick;

  const ProductCategoryOverlayItem({
    Key? key,
    required this.image,
    required this.onClick,
    this.name,
    this.count,
    this.opacityColor = Colors.black,
    this.opacity = 0.6,
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onClick(),
      child: ClipRRect(
        borderRadius: borderRadius,
        child: Stack(
          children: [
            image,
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                padding: EdgeInsets.all(11),
                color: opacityColor.withOpacity(opacity),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: double.infinity,
                      child: name ?? Container(),
                    ),
                    Container(
                      width: double.infinity,
                      child: count ?? Container(),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
