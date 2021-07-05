import 'package:cirilla/models/setting/setting.dart';
import 'package:cirilla/screens/search/product_search.dart';
import 'package:flutter/material.dart';
import 'search_widget.dart';

class ProductSearchWidget extends SearchWidget {
  final WidgetConfig widgetConfig;

  ProductSearchWidget({
    Key key,
    this.widgetConfig,
  }) : super(
          key: key,
          widgetConfig: widgetConfig,
        );

  void onPressed(BuildContext context) async {
    await showSearch<String>(
      context: context,
      delegate: ProductSearchDelegate(),
    );
  }
}
