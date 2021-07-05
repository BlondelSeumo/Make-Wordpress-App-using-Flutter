import 'package:cirilla/constants/strings.dart';
import 'package:cirilla/mixins/post_mixin.dart';
import 'package:cirilla/models/models.dart';
import 'package:cirilla/types/types.dart';
import 'package:cirilla/widgets/cirilla_product_category_item.dart';
import 'package:flutter/material.dart';

class LayoutBigFirst extends StatelessWidget {
  final List<ProductCategory> categories;
  final BuildItemProductCategoryType buildItem;
  final double pad;
  final Map<String, dynamic> template;
  final EdgeInsetsDirectional padding;
  final double widthView;

  const LayoutBigFirst({
    Key key,
    this.categories,
    this.buildItem,
    this.pad = 0,
    this.template,
    this.padding = EdgeInsetsDirectional.zero,
    this.widthView = 300,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (categories.length <= 0) return Container();

    List<ProductCategory> _categories = List<ProductCategory>.of(categories);
    ProductCategory firstCategory = _categories.removeAt(0);

    double widthWidget = widthView - padding.end - padding.start;

    return Padding(
      padding: padding,
      child: Column(
        children: [
          Column(
            children: [
              FirstItem(category: firstCategory, width: widthWidget, template: template),
              if (categories.length > 0)
                SizedBox(
                  height: pad,
                ),
            ],
          ),
          ...List.generate(
            categories.length,
            (int index) {
              // double newWidth = MediaQuery.of(context).size.width;
              return Column(
                children: [
                  buildItem(
                    context,
                    category: categories[index],
                    width: widthWidget,
                    height: null,
                  ),
                  if (index < categories.length - 1) SizedBox(height: pad)
                ],
              );
            },
          )
        ],
      ),
    );
  }
}

class FirstItem extends StatelessWidget with PostMixin {
  final ProductCategory category;
  final double width;
  final Map<String, dynamic> template;

  const FirstItem({Key key, this.category, this.width, this.template}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CirillaProductCategoryItem(
      category: category,
      width: width,
      height: width,
      template: {
        'template': Strings.productCategoryItemOverlay,
        'data': template is Map<String, dynamic> && template['data'] is Map<String, dynamic> ? template['data'] : {},
      },
    );
  }
}
