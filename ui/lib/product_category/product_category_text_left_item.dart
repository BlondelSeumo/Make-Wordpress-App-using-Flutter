import 'package:flutter/material.dart';

class ProductCategoryTextLeftItem extends StatelessWidget {
  final Function onTap;
  final Widget name;
  final Widget? image;
  final Widget? count;
  final Widget? iconRight;
  final Widget? child;
  final double basePadding;

  ProductCategoryTextLeftItem({
    Key? key,
    required this.onTap,
    required this.name,
    this.image,
    this.count,
    this.iconRight,
    this.child,
    this.basePadding = 8,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          onTap: () => onTap(),
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 1, color: Theme.of(context).dividerColor),
              ),
            ),
            padding: EdgeInsets.symmetric(vertical: basePadding * 2),
            child: Row(
              children: [
                if (image != null) Padding(padding: EdgeInsetsDirectional.only(end: basePadding), child: image),
                Expanded(
                  child: name,
                ),
                if (count != null)
                  Padding(
                    padding: EdgeInsetsDirectional.only(start: basePadding),
                    child: count,
                  ),
                if (iconRight != null)
                  Padding(
                    padding: EdgeInsetsDirectional.only(start: basePadding),
                    child: iconRight,
                  )
              ],
            ),
          ),
        ),
        child ?? Container(),
      ],
    );
  }
}
