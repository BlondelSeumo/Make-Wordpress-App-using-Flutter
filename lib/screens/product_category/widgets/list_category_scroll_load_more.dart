import 'package:cirilla/constants/strings.dart';
import 'package:cirilla/models/product_category/product_category.dart';
import 'package:flutter/material.dart';

import 'build_item_product_category.dart';
import 'list_category.dart';

class ListCategoryScrollLoadMore extends ListCategory {
  const ListCategoryScrollLoadMore({
    Key key,
    List<ProductCategory> categories,
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
  }) : super(
          key: key,
          categories: categories,
          layout: layout,
          col: col,
          ratio: ratio,
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
    switch (layout) {
      case Strings.layoutCategoryGrid:
        return SliverGrid(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: col,
            mainAxisSpacing: pad,
            crossAxisSpacing: pad,
            childAspectRatio: ratio,
          ),
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              ProductCategory category = categories[index];
              return LayoutBuilder(builder: (_, BoxConstraints constraints) {
                double width = constraints.maxWidth;
                double height = constraints.maxHeight;
                return BuildItemProductCategory(
                  category: category,
                  textName: category.id == idShowAll && enableTextShowAll ? textShowAll : null,
                  template: template,
                  styles: styles,
                  widthItem: width,
                  heightItem: height,
                  themeModeKey: themeModeKey,
                );
              });
            },
            childCount: categories.length,
          ),
        );
        break;
      default:
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return Container(
                padding: EdgeInsets.only(bottom: index < categories.length - 1 ? pad : 0),
                child: LayoutBuilder(
                  builder: (_, BoxConstraints constraints) {
                    ProductCategory category = categories[index];
                    double width = constraints.maxWidth;
                    return BuildItemProductCategory(
                      category: category,
                      textName: category.id == idShowAll && enableTextShowAll ? textShowAll : null,
                      template: template,
                      styles: styles,
                      widthItem: width,
                      themeModeKey: themeModeKey,
                    );
                  },
                ),
              );
            },
            childCount: categories.length,
          ),
        );
    }
  }
}
