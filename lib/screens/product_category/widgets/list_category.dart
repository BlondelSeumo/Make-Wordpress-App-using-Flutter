import 'package:cirilla/constants/strings.dart';
import 'package:cirilla/models/product_category/product_category.dart';
import 'package:flutter/material.dart';

abstract class ListCategory extends StatefulWidget {
  final List<ProductCategory> categories;

  // Layout Template (Grid, List)
  final String layout;

  // Number column with layout = grid
  final int col;

  // Number ratio with layout = grid
  final double ratio;

  // Padding items
  final double pad;

  // enable change text in item show all
  final bool enableTextShowAll;

  // text show all
  final String textShowAll;

  // id item show all
  final int idShowAll;

  // id item show all
  final Map<String, dynamic> template;

  // styles item
  final Map<String, dynamic> styles;

  // key theme darkmode
  final String themeModeKey;

  const ListCategory({
    Key key,
    this.categories,
    this.layout = Strings.layoutCategoryGrid,
    this.col = 2,
    this.ratio = 1.0,
    this.pad = 0,
    this.enableTextShowAll = true,
    this.textShowAll = 'Show all',
    this.idShowAll = -1,
    this.template = const {},
    this.styles = const {},
    this.themeModeKey = 'value',
  }) : super(key: key);

  @override
  _ListCategoryState createState() => _ListCategoryState();

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
  });
}

class _ListCategoryState extends State<ListCategory> {
  @override
  Widget build(BuildContext context) {
    return widget.buildLayout(
      context,
      categories: widget.categories ?? [],
      layout: widget.layout ?? Strings.layoutCategoryGrid,
      col: widget.col ?? 2,
      ratio: widget.ratio ?? 1,
      pad: widget.pad ?? 0,
      enableTextShowAll: widget.enableTextShowAll ?? true,
      textShowAll: widget.textShowAll ?? 'Show all',
      idShowAll: widget.idShowAll ?? -1,
      template: widget.template ?? {},
      styles: widget.styles ?? {},
      themeModeKey: widget.themeModeKey ?? 'value',
    );
  }
}
