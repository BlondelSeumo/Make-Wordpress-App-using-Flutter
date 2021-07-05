import 'package:cirilla/constants/strings.dart';
import 'package:cirilla/models/product_category/product_category.dart';
import 'package:flutter/material.dart';

import 'list_category_load_more.dart';

class ChildCategory extends StatefulWidget {
  final ProductCategory parent;
  final int col;
  final int perPage;
  final Map<String, dynamic> template;
  final Map<String, dynamic> styles;
  final String themeModeKey;

  const ChildCategory({
    Key key,
    this.parent,
    this.perPage = 6,
    this.col,
    this.themeModeKey = 'value',
    this.styles = const {},
    this.template = const {},
  }) : super(key: key);

  @override
  _ChildCategoryState createState() => _ChildCategoryState();
}

class _ChildCategoryState extends State<ChildCategory> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<ProductCategory> categories = widget?.parent?.categories ?? [];
    int lengthCategory = widget.perPage > categories.length ? categories.length : widget.perPage;
    return Column(
      children: [
        ListCategoryLoadMore(
          categories: categories.sublist(0, lengthCategory),
          layout: Strings.layoutCategoryGrid,
          col: widget.col,
          pad: 16,
          enableTextShowAll: false,
          textShowAll: '',
          idShowAll: widget.parent.id,
          template: widget.template,
          styles: widget.styles,
          themeModeKey: widget.themeModeKey,
        ),
      ],
    );
  }
}
