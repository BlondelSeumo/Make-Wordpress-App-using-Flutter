import 'package:flutter/material.dart';

class ProductCategoryBasicItem extends StatelessWidget {
  final Widget name;
  final Icon? icon;
  final double width;
  final double height;
  final BoxBorder border;
  final EdgeInsetsGeometry padding;
  final Color color;
  final Function onClick;

  const ProductCategoryBasicItem({
    Key? key,
    required this.name,
    required this.onClick,
    this.icon,
    this.border = const Border(bottom: BorderSide(width: 1)),
    this.height = 58,
    this.width = 335,
    this.padding = EdgeInsets.zero,
    this.color = Colors.transparent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onClick(),
      child: Container(
        width: width,
        padding: padding,
        decoration: BoxDecoration(color: color, border: border),
        constraints: BoxConstraints(
          minHeight: height,
        ),
        alignment: Alignment.center,
        child: Row(
          children: [
            Expanded(child: name),
            if (icon is Icon)
              Padding(
                padding: EdgeInsets.only(left: 16),
                child: icon,
              )
          ],
        ),
      ),
    );
  }
}
