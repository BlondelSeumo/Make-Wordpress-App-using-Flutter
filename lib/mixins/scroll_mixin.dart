import 'package:cirilla/constants/constants.dart';
import 'package:flutter/material.dart';

mixin ScrollMixin<T extends StatefulWidget> on State<T> {
  ScrollController controller;

  bool isScrolledToTop = true;

  @override
  void didChangeDependencies() {
    controller = ScrollController();
    controller.addListener(_scrollListener);
    super.didChangeDependencies();
  }

  _scrollListener() {
    if (controller.offset < appbarEmptySpace) {
      if (!isScrolledToTop) {
        setState(() {
          // reach the top
          isScrolledToTop = true;
        });
      }
    } else {
      if (isScrolledToTop) {
        setState(() {
          // not the top
          isScrolledToTop = false;
        });
      }
    }
  }

  void setScrollState(bool value) {
    setState(() {
      isScrolledToTop = value;
    });
  }
}
