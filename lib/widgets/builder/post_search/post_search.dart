import 'package:cirilla/models/setting/setting.dart';
import 'package:cirilla/screens/screens.dart';
import 'package:flutter/material.dart';
import '../product-search//search_widget.dart';

class PostSearchWidget extends SearchWidget {
  final WidgetConfig widgetConfig;

  PostSearchWidget({
    Key key,
    this.widgetConfig,
  }) : super(
          key: key,
          widgetConfig: widgetConfig,
        );

  void onPressed(BuildContext context) async {
    await showSearch<String>(
      context: context,
      delegate: PostSearchDelegate(),
    );
  }
}
