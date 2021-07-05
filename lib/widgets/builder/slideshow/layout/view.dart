import 'package:flutter/material.dart';

abstract class View extends StatefulWidget {
  final int count;
  final Size size;
  final bool autoPlay;
  final bool enableIndicator;
  final int interval;
  final int delay;
  final Color colorIndicator;
  final Color colorIndicatorActive;
  final Widget Function(BuildContext context, int index, Size size) buildItem;

  View({
    Key key,
    @required this.buildItem,
    this.autoPlay = true,
    this.enableIndicator = true,
    this.interval = 1800,
    this.delay = 1000,
    this.count = 2,
    this.size = const Size(375, 330),
    this.colorIndicator = Colors.black,
    this.colorIndicatorActive = Colors.black,
  }) : super(key: key);

  @override
  _ViewState createState() => _ViewState();

  @protected
  Widget buildLayout(BuildContext context, double width, int pagination, Function(int value) changePagination);
}

class _ViewState extends State<View> {
  GlobalKey _keyContainer = GlobalKey();
  double widthView = 300;
  int pagination = 0;

  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback(_getSizes);
    super.initState();
  }

  _getSizes(_) {
    final double width = _keyContainer.currentContext?.size?.width ?? 300;
    setState(() {
      widthView = width;
    });
  }

  void changePagination(int index) {
    setState(() {
      pagination = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: _keyContainer,
      width: double.infinity,
      child: widget.buildLayout(context, widthView, pagination, changePagination),
    );
  }
}
