import 'package:cirilla/constants/strings.dart';
import 'package:cirilla/models/product_category/product_category.dart';
import 'package:flutter/material.dart';

import 'build_item_product_category.dart';
import 'list_category.dart';

class ListCategoryLoadMore extends ListCategory {
  const ListCategoryLoadMore({
    Key key,
    List<ProductCategory> categories,
    String layout,
    int col,
    double pad,
    bool enableTextShowAll,
    String textShowAll,
    int idShowAll,
    Map<String, dynamic> template,
    Map<String, dynamic> styles,
    String themeModeKey,
  }) : super(
          key: key,
          categories: categories,
          layout: layout,
          col: col,
          pad: pad,
          enableTextShowAll: enableTextShowAll,
          textShowAll: textShowAll,
          idShowAll: idShowAll,
          template: template,
          styles: styles,
          themeModeKey: themeModeKey,
        );

  @override
  Widget buildLayout(
    BuildContext context, {
    @required List<ProductCategory> categories,
    String layout,
    int col,
    double ratio,
    double pad,
    bool enableTextShowAll,
    String textShowAll,
    int idShowAll,
    Map<String, dynamic> template,
    Map<String, dynamic> styles,
    String themeModeKey,
  }) {
    // Todo: with in the horizontal layout
    return LayoutBuilder(builder: (_, BoxConstraints constraints) {
      double width = constraints.maxWidth;
      switch (layout) {
        case Strings.layoutCategoryGrid:
          double widthItem = (width - (col - 1) * pad) / col;
          return Wrap(
            spacing: pad, // gap between adjacent chips
            runSpacing: 24,
            children: List.generate(
              categories.length,
              (index) => BuildItemProductCategory(
                category: categories[index],
                textName: categories[index].id == idShowAll && enableTextShowAll ? textShowAll : null,
                template: template,
                styles: styles,
                widthItem: widthItem,
                themeModeKey: themeModeKey,
              ),
            ),
          );
          break;
        default:
          return Column(
            children: List.generate(
              categories.length,
              (index) => BuildItemProductCategory(
                category: categories[index],
                textName: categories[index].id == idShowAll && enableTextShowAll ? textShowAll : null,
                template: template,
                styles: styles,
                widthItem: width,
                themeModeKey: themeModeKey,
              ),
            ),
          );
      }
    });
  }
}
