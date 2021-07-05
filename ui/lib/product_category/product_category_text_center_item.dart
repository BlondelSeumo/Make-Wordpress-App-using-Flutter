import 'package:flutter/material.dart';

class ProductCategoryTextCenterItem extends StatelessWidget {
  final Function onTap;
  final Widget name;
  final Widget? image;
  final Widget? count;
  final Widget? iconRight;
  final Widget? child;
  final double basePadding;

  ProductCategoryTextCenterItem({
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
    return InkWell(
        onTap: () => onTap(),
        child: Container(
          width: double.infinity,
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 1, color: Theme.of(context).dividerColor),
                  ),
                ),
                padding: EdgeInsets.symmetric(vertical: basePadding * 2),
                // margin: EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (image != null) Padding(padding: EdgeInsetsDirectional.only(end: basePadding), child: image),
                    Flexible(child: name),
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
              child ?? Container(),
            ],
          ),
        ));
  }
}
